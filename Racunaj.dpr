program Racunaj;

uses
  System.StartUpCopy,
  FMX.Forms,
  System.SysUtils,
  Main in 'Main.pas' {frmMain},
  SharedUnit in 'SharedUnit.pas',
  FMX.GifUtils in 'FMX.GifUtils.pas',
  SplashScreen in 'SplashScreen.pas' {frmSplashScreen},
  u_urlOpen in 'u_urlOpen.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSplashScreen, frmSplashScreen);
  Application.Run;
end.
