unit SplashScreen;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.Objects, FMX.Ani,
  FMX.Effects, FMX.Filter.Effects;

type
  TfrmSplashScreen = class(TForm)
    Image1: TImage;
    tmrStart: TTimer;
    RippleTransitionEffect1: TRippleTransitionEffect;
    tmrRiipleTransition: TTimer;
    GlowEffect1: TGlowEffect;
    tmrGlow: TTimer;
    Image2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    procedure tmrStartTimer(Sender: TObject);
    procedure tmrRiipleTransitionTimer(Sender: TObject);
    procedure tmrGlowTimer(Sender: TObject);
  private
    { Private declarations }
    FInitialized: Boolean;
    progress: Integer;
    procedure LoadMainForm;
  public
    { Public declarations }
  end;

var
  frmSplashScreen: TfrmSplashScreen;

implementation

{$R *.fmx}

uses System.Devices, Main;

procedure TfrmSplashScreen.FormCreate(Sender: TObject);
begin
//  tmrStart.Enabled:= false;
//  tmrStart.Interval:= 5000; // can be changed to improve startup speed in later releases

  progress:=100;
  RippleTransitionEffect1.Enabled:=True;
  tmrRiipleTransition.Enabled:=True;
  tmrGlow.Enabled:=False;
  Image2.Visible:=False;
end;

procedure TfrmSplashScreen.FormPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  //tmrStart.Enabled:= not FInitialized;
end;


procedure TfrmSplashScreen.LoadMainForm();
type
  TFormClass = class of TForm;
var
  form: TForm;
  formClass: TFormClass;
begin
  formClass:= nil;
  formClass:= TfrmMain;

  form:= formClass.Create(Application);
  form.Show;
  Application.MainForm:= form;
  Close;
end;

procedure TfrmSplashScreen.tmrGlowTimer(Sender: TObject);
begin
  GlowEffect1.Enabled:=False;
  tmrGlow.Enabled:=False;
  if not FInitialized then begin
    FInitialized := true;
    LoadMainForm;
  end;
end;

procedure TfrmSplashScreen.tmrRiipleTransitionTimer(Sender: TObject);
begin
  // prikaži efekt Riiple
  if progress>0 then
  begin
    Dec(progress);
    RippleTransitionEffect1.Progress:=progress;
  end else
  begin     // ko pride do 0 ga končajin začni glow effekt
    Image2.Visible:=True;
    tmrRiipleTransition.Enabled:=False;
    tmrGlow.Enabled:=True;
    RippleTransitionEffect1.Enabled:=False;
    GlowEffect1.Enabled:=True;
    tmrGlow.Enabled:=True;
  end;
end;

procedure TfrmSplashScreen.tmrStartTimer(Sender: TObject);
begin
exit;
  tmrStart.Enabled := false;
  if not FInitialized then begin
    FInitialized := true;
    LoadMainForm;
  end;
end;

end.
