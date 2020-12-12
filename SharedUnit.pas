unit SharedUnit;

interface

uses inifiles, SysUtils, System.IOUtils;

var
  racuna_do_st: Integer;
  cas_racunanja_enega_st: Integer;
  nakljucni_nn_clen: Boolean;
  IniFile : TIniFile;

procedure SaveIni();
procedure ReadIni();
function GetExePath(): String;
function CountFilesInFolder ( path: string ): integer;

implementation


function GetExePath(): String;
begin
{$IFDEF MSWINDOWS}
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
  finally
    IniFile.Free
  end;
end;


function CountFilesInFolder(path: string): integer;
var
  tsr: TSearchRec;
begin
  result := 0;
  if FindFirst ( path + '*.gif', faAnyFile and not faDirectory, tsr ) = 0 then begin
    repeat
      inc ( result );
    until FindNext ( tsr ) <> 0;
    FindClose ( tsr );
  end;
end;


end.
