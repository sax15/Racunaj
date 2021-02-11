unit SharedUnit;

interface

uses inifiles, SysUtils, System.IOUtils, System.Generics.Collections;

type
  // definicija igralca
  TIgralec = record
    ID      : Integer;
    naziv : String;
  end;

var
  trenutni_igralec: TIgralec;   // record trenutnega igralca
  sestevanje_do: Integer;
  odstevanje_od: Integer;
  max_mnozenec: Integer;
  mnozenje_faktorji: String;
  deljenje_od: Integer;
  deljenje_deljitelji: String;

  omejitev_racunanja: Integer;    // ali imamo nastavljeno omejitev čas ali št. računanja
  omejitev_cas_racunanja: Integer;   // omejitev čas računanja (ne vključuje časaanimacij)
  omejitev_st_racunanja: Integer;     // omejitev števila računov

  predvajaj_animacijo: Boolean; // vklopi izklopi animacijo
  predvajaj_zvok: Boolean;  // vklopi izklopi zvok
  vklopi_cas_racunanja: Boolean;
  cas_racunanja_enega_st: Integer;
  nakljucni_nn_clen: Boolean;
  operacije: Integer;
  IniFile : TIniFile;

const
  SecPerDay = 86400;
  SecPerHour = 3600;
  SecPerMinute = 60;

procedure SaveIni();
procedure ReadIni();
function GetExePath(): String;
function CountFilesInFolder (path: String ): integer;
Procedure DeliteljiSt(st: Integer; var delitelji: TList<Integer>);
Procedure DeliteljiSt2(st, faktor: Integer; var delitelji: TList<Integer>);
Procedure StrToListIntFaktorji(sfaktorji: String; max: Integer; var faktorji: TList<Integer>);
Procedure ZamenjajStevila(var st1: Integer; var st2: Integer);
Function GetMax(var list: TList<Integer>): Integer;

procedure ClearBit(var Value: Integer; Index: Byte);
procedure SetBit(var Value: Integer; Index: Byte);
procedure PutBit(var Value: Integer; Index: Byte; State: Boolean);
function GetBit(Value: Integer; Index: Byte): Boolean;
function SecondToTime(const Seconds: Cardinal): Double;

implementation


function GetExePath(): String;
begin
{$IFDEF MSWINDOWS}
  //Result:=TPath.GetDocumentsPath + PathDelim;
  Result:=ExtractFilePath(ParamStr(0));
{$ELSE}
  //Result:=TPath.GetDocumentsPath + PathDelim;
  Result:=TPath.GetDocumentsPath + PathDelim + 'Racunaj' + PathDelim;
{$ENDIF}

end;

procedure SaveIni();
begin
  iniFile := TIniFile.Create(GetExePath() + 'System.ini');  { TODO : Preveri kje se zapiše ini file v Android in iOS }
  try
    IniFile.WriteInteger('Nastavitve', 'Sestevanje do', sestevanje_do);
    IniFile.WriteInteger('Nastavitve', 'Odstevanje od', odstevanje_od);
    IniFile.WriteInteger('Nastavitve', 'Najvecji mnozenec', max_mnozenec);
    IniFile.WriteString('Nastavitve', 'Mnozenje faktorji', mnozenje_faktorji);
    IniFile.WriteInteger('Nastavitve', 'Deljenje od', deljenje_od);
    IniFile.WriteString('Nastavitve', 'Deljenje delitelji', deljenje_deljitelji);
    IniFile.WriteString('Nastavitve', 'Zadnji igralec naziv', trenutni_igralec.naziv);
    IniFile.WriteInteger('Nastavitve', 'Zadnji igralec ID', trenutni_igralec.ID);

    IniFile.WriteInteger('Nastavitve', 'Omejitev racunanja', omejitev_racunanja);
    IniFile.WriteInteger('Nastavitve', 'Omejitev cas racunanja', omejitev_cas_racunanja);
    IniFile.WriteInteger('Nastavitve', 'Omejitev stevila racunov', omejitev_st_racunanja);
    IniFile.WriteInteger('Nastavitve', 'Cas racunanja enega stevila', cas_racunanja_enega_st);
    IniFile.WriteBool('Nastavitve', 'Nakljucni nezna clen', nakljucni_nn_clen);
    IniFile.WriteBool('Nastavitve', 'Predvajaj animacijo', predvajaj_animacijo);
    IniFile.WriteBool('Nastavitve', 'Predvajaj zvok', predvajaj_zvok);
    IniFile.WriteBool('Nastavitve', 'Vklopi cas racunanja', vklopi_cas_racunanja);
    IniFile.WriteInteger('Nastavitve', 'Operacije', operacije);
  finally
    IniFile.Free;
  end;

end;

procedure ReadIni();
begin
  iniFile := TIniFile.Create(GetExePath() + 'System.ini');
  try
    sestevanje_do:=(IniFile.ReadInteger('Nastavitve', 'Sestevanje do', 10));
    odstevanje_od:=(IniFile.ReadInteger('Nastavitve', 'Odstevanje od', 10));
    max_mnozenec:=(IniFile.ReadInteger('Nastavitve', 'Najvecji mnozenec', 20));
    mnozenje_faktorji:=(IniFile.ReadString('Nastavitve', 'Mnozenje faktorji', '2'));
    deljenje_od:=(IniFile.ReadInteger('Nastavitve', 'Deljenje od', 10));
    deljenje_deljitelji:=(IniFile.ReadString('Nastavitve', 'Deljenje delitelji', '2'));

    trenutni_igralec.naziv:=IniFile.ReadString('Nastavitve', 'Zadnji igralec naziv', '');
    trenutni_igralec.ID:=IniFile.ReadInteger('Nastavitve', 'Zadnji igralec ID', -1);

    omejitev_racunanja:=(IniFile.ReadInteger('Nastavitve', 'Omejitev racunanja', 0));
    omejitev_cas_racunanja:=(IniFile.ReadInteger('Nastavitve', 'Omejitev cas racunanja', 10));
    omejitev_st_racunanja:=(IniFile.ReadInteger('Nastavitve', 'Omejitev stevila racunov', 20));

    cas_racunanja_enega_st:=(IniFile.ReadInteger('Nastavitve', 'Cas racunanja enega stevila', 10));
    nakljucni_nn_clen:=IniFile.ReadBool('Nastavitve', 'Nakljucni nezna clen', False);
    predvajaj_animacijo:=IniFile.ReadBool('Nastavitve', 'Predvajaj animacijo', True);
    predvajaj_zvok:=IniFile.ReadBool('Nastavitve', 'Predvajaj zvok', True);
    vklopi_cas_racunanja:=IniFile.ReadBool('Nastavitve', 'Vklopi cas racunanja', True);
    operacije:=IniFile.ReadInteger('Nastavitve', 'Operacije', 2);
  finally
    IniFile.Free
  end;
end;


function CountFilesInFolder(path: string): integer;
var
  tsr: TSearchRec;
  name: String;
begin
  result := 0;
  if FindFirst ( path + '*.gif', faAnyFile and not faDirectory, tsr ) = 0 then begin
    repeat
      name:=tsr.Name;
      inc ( result );
    until FindNext ( tsr ) <> 0;
    FindClose ( tsr );
  end;
end;


Procedure DeliteljiSt(st: Integer; var delitelji: TList<Integer>);
var
  i, rez: Integer;
begin
  i:=1;
  rez:=st;
  Repeat
    if(st mod i)=0 then
    begin
      rez:=st Div i;
      delitelji.Add(i);
      delitelji.Add(rez);
    end;
    inc(i);
  Until i>=rez;
end;

Procedure DeliteljiSt2(st, faktor: Integer; var delitelji: TList<Integer>);
var
  i, rez: Integer;
begin
  i:=1;
  rez:=0;
  while (rez<=st) do
  begin
    delitelji.Add(faktor*i);
    inc(i);
    rez:=faktor*i;
  end;
end;

Procedure StrToListIntFaktorji(sfaktorji: String; max: Integer; var faktorji: TList<Integer>);  // sparsaj sting='*' ali '2,4,6' ali '1-5' vTlist<Integer>
var
  i, st1, st2: Integer;
  s: String;
begin
  try
   //sparsaj sting='*'=max ali '2,4,6' ali '1-5' v Tlist<Integer>
   if sfaktorji='*' then      // če smo vpisali* potem velja katerikoli faktor
   begin
    for i:=0 to max do
      faktorji.Add(i);
   end else
   begin
     if (sfaktorji.IndexOf(',')>-1) then     // faktorji so ločeni z vejico
     begin
      s:=sfaktorji;
      while (s.IndexOf(',')>-1) do
      begin
        st1:=StrToInt(s.Substring(0,s.IndexOf(',')));
        faktorji.Add(st1);
        s:=s.Substring(s.IndexOf(',')+1);
      end;
      faktorji.Add(StrToInt(s));
     end else if (sfaktorji.IndexOf('-')>-1) then   // faktorji od - do
     begin
      st1:=StrToInt(sfaktorji.Substring(0,sfaktorji.IndexOf('-')));
      st2:=StrToInt(sfaktorji.Substring(sfaktorji.IndexOf('-')+1, sfaktorji.Length));
      for i:=st1 to st2 do
        faktorji.Add(i);
     end else      // faktor je samo en
      faktorji.Add(StrToInt(sfaktorji));
   end;
  Except
    faktorji.Clear;
   end;

end;

Procedure ZamenjajStevila(var st1: Integer; var st2: Integer);
var
  tmp: Integer;
begin
  tmp:=st1;
  st1:=st2;
  st2:=tmp;
end;

Function GetMax(var list: TList<Integer>): Integer;
var
  max, num: Integer;
begin
  max:=0;
  for num in list do
    if num>max then
      max:=num;
  result:=max;
end;


procedure ClearBit(var Value: Integer; Index: Byte);
begin
  Value := Value and ((Integer(1) shl Index) xor High(Integer));
end;

procedure SetBit(var Value: Integer; Index: Byte);
begin
  Value:=  Value or (Integer(1) shl Index);
end;

procedure PutBit(var Value: Integer; Index: Byte; State: Boolean);
begin
  Value := (Value and ((Integer(1) shl Index) xor High(Integer))) or (Integer(State) shl Index);
end;

function GetBit(Value: Integer; Index: Byte): Boolean;
begin
  Result := ((Value shr Index) and 1) = 1;
end;

function SecondToTime(const Seconds: Cardinal): Double;
var
  ms, ss, mm, hh, dd: Cardinal;
begin
  dd := Seconds div SecPerDay;
  hh := (Seconds mod SecPerDay) div SecPerHour;
  mm := ((Seconds mod SecPerDay) mod SecPerHour) div SecPerMinute;
  ss := ((Seconds mod SecPerDay) mod SecPerHour) mod SecPerMinute;
  ms := 0;
  Result := dd + EncodeTime(hh, mm, ss, ms);
end;

end
.
