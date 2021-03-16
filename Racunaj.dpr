program Racunaj;

{$IFDEF MSWINDOWS}
{$R RacunajWin.dres}
{$ENDIF}
{$IFDEF ANDROID}
{$R RacunajAndroid.dres}
{$ENDIF}
{$IFDEF IOS}
{$R RacunajIOS.dres}
{$ENDIF}

uses
  System.StartUpCopy,
  FMX.Forms,
  System.SysUtils,
  Main in 'Main.pas' {frmMain},
  SharedUnit in 'SharedUnit.pas',
  FMX.GifUtils in 'FMX.GifUtils.pas',
  SplashScreen in 'SplashScreen.pas' {frmSplashScreen},
  u_urlOpen in 'u_urlOpen.pas';

{$IFDEF MSWINDOWS}
{$R RacunajWin.res}
{$ENDIF}
{$IFDEF ANDROID}
{$R RacunajAndroid.res}
{$ENDIF}
{$IFDEF IOS}
{$R RacunajIOS.res}
{$ENDIF}
begin
  Application.Initialize;
  Application.CreateForm(TfrmSplashScreen, frmSplashScreen);
  Application.Run;
end.
