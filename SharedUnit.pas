unit SharedUnit;

interface

uses inifiles, SysUtils, System.IOUtils;

var
  racuna_do_st: Integer;
  vklopi_cas_racunanja: Boolean;
  cas_racunanja_enega_st: Integer;
  nakljucni_nn_clen: Boolean;
  IniFile : TIniFile;

procedure SaveIni();
procedure ReadIni();
function GetExePath(): String;
function CountFilesInFolder (path: String ): integer;


implementation


function GetExePath(): String;
begin
{$IFDEF MSWINDOWS}
  //Result:=TPath.GetDocumentsPath + PathDelim;
  Result:=ExtractFilePath(ParamStr(0));
{$ENDIF}
{$IFDEF LINUX}
  Result:=TPath.GetDocumentsPath + PathDelim;
{$ENDIF}
{$IFDEF ANDROID}
  Result:=TPath.GetDocumentsPath + PathDelim;
{$ENDIF}
end;

procedure SaveIni();
begin
  iniFile := TIniFile.Create(GetExePath() + 'System.ini');
  try
    IniFile.WriteInteger('Nastavitve', 'Racunaj do stevila', racuna_do_st);
    IniFile.WriteInteger('Nastavitve', 'Cas racunanja enega stevila', cas_racunanja_enega_st);
    IniFile.WriteBool('Nastavitve', 'Nakljucni nezna clen', nakljucni_nn_clen);
    IniFile.WriteBool('Nastavitve', 'Vklopi cas racunanja', vklopi_cas_racunanja);
  finally
    IniFile.Free;
  end;

end;

procedure ReadIni();
begin
  iniFile := TIniFile.Create(GetExePath() + 'System.ini');
  try
    racuna_do_st:=IniFile.ReadInteger('Nastavitve', 'Racunaj do stevila', 10);
    cas_racunanja_enega_st:=(IniFile.ReadInteger('Nastavitve', 'Cas racunanja enega stevila', 10));
    nakljucni_nn_clen:=IniFile.ReadBool('Nastavitve', 'Nakljucni nezna clen', False);
    vklopi_cas_racunanja:=IniFile.ReadBool('Nastavitve', 'Vklopi cas racunanja', True);
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


end.
