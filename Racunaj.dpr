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
  frmSplashScreen := TfrmSplashScreen.Create(nil);
  frmSplashScreen.Show;
  Application.ProcessMessages;
  //Sleep(3000);   // Čss prikazovanja splashScreena

  Application.CreateForm(TfrmMain, frmMain);
  // kreiraj Main formo
  frmSplashScreen.Close;        // zapriin sprosti SplashScreen
  frmSplashScreen.Free;
  Application.Run;

end.
