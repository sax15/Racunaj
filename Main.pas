﻿unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.DateTimeCtrls, FMX.ListBox, FMX.Layouts, System.ImageList, FMX.ImgList,
  FMX.Objects, FMX.Edit, FMX.Controls.Presentation, FMX.TabControl,
  SharedUnit, FMX.GifUtils, System.DateUtils, FMX.ScrollBox, FMX.Memo,
  System.IOUtils, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, System.Rtti, FMX.Grid.Style,
  FMX.Grid, FMX.ComboEdit, System.Generics.Collections, FMX.WebBrowser,
  FMX.Media, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FMXTee.Engine, FMXTee.Series, FMXTee.Procs, FMXTee.Chart,
  FMX.Ani, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.Effects,
  Fmx.Bind.Grid, Data.Bind.Grid;



type
  TfrmMain = class(TForm)
    TabControl: TTabControl;
    tbiRacunaj: TTabItem;
    tbiNastavitve: TTabItem;
    layGumbi: TLayout;
    btnStart: TSpeedButton;
    btnIzhod: TSpeedButton;
    layRezultat: TLayout;
    labRezultat: TLabel;
    layRacunaj: TLayout;
    edtPrvoSt: TEdit;
    labOperator: TLabel;
    edtDrugoSt: TEdit;
    edtRezultat: TEdit;
    btnPreveri: TButton;
    labJeEnako: TLabel;
    layCas: TLayout;
    labCas: TLabel;
    layAnimacija: TLayout;
    imgAnimacija: TImage;
    ImageList: TImageList;
    lbNastavitve: TListBox;
    lbiSestevajDo: TListBoxItem;
    lbiCasRacunanja: TListBoxItem;
    lbiPoljubniNeznanClen: TListBoxItem;
    labRacunjaDo: TLabel;
    edtSestevajDo: TEdit;
    labCasRacunanja: TLabel;
    swcPoljubniNeznanClen: TSwitch;
    labPoljubniNeznanClen: TLabel;
    labNapis: TLabel;
    tmrCasRacunanja: TTimer;
    edtCasRacunanja: TEdit;
    labS: TLabel;
    tmrPavza: TTimer;
    lbiVklopiCas: TListBoxItem;
    labVklopiCasRacunanja: TLabel;
    swcVklopiCasRacunanja: TSwitch;
    lbiOperacije: TListBoxItem;
    tbiOprogramu: TTabItem;
    layMain: TLayout;
    lbhSeštevanje: TListBoxGroupHeader;
    lbhOdštevanje: TListBoxGroupHeader;
    lbiOdstevanje: TListBoxItem;
    labOdstevanjeDo: TLabel;
    edtOdstevanjeDo: TEdit;
    lbhMnozenje: TListBoxGroupHeader;
    libMnozenjeFaktor: TListBoxItem;
    labMnozenje: TLabel;
    edtMnozenjeFaktor: TEdit;
    lbiMnozenjeDo: TListBoxItem;
    labMnozenjeDo: TLabel;
    edtMaxMnozenec: TEdit;
    lbhDeljenje: TListBoxGroupHeader;
    lbiDeljenjeOd: TListBoxItem;
    labDeljenjeOd: TLabel;
    edtDeljenjeOd: TEdit;
    lbiDeljenjeDelitelj: TListBoxItem;
    labDeljenjeDelitelj: TLabel;
    edtDeljenjeDeljitel: TEdit;
    lbiAnimacija: TListBoxItem;
    labAnimacija: TLabel;
    swcPredvajajAnimacijo: TSwitch;
    tbiDebug: TTabItem;
    mDebug: TMemo;
    GridPanelLayout1: TGridPanelLayout;
    chbSestevanje: TCheckBox;
    chbOdstevanje: TCheckBox;
    chbMnozenje: TCheckBox;
    chbDeljenje: TCheckBox;
    lbhOperacije: TListBoxGroupHeader;
    ScrollBox: TScrollBox;
    WebBrowser: TWebBrowser;
    cobOmejitveRacunanja: TComboBox;
    edtCasOmejitev: TEdit;
    edtStRacunovOmejitev: TEdit;
    tmrSkupniCas: TTimer;
    layOmejitevRacunanja: TLayout;
    labOmejitevRacunanja: TLabel;
    lbiZvok: TListBoxItem;
    labPredvajajZvok: TLabel;
    swcPredvajajZvok: TSwitch;
    MediaPlayer: TMediaPlayer;
    FDConnection: TFDConnection;
    FDQIgralci: TFDQuery;
    btnDodajIzberiIgralca: TSpeedButton;
    tbiRezultati: TTabItem;
    scbGrafi: TScrollBox;
    flaVnosnaFormaIgralec: TFloatAnimation;
    layVnosnaFormaIgralca: TLayout;
    recForm: TRectangle;
    btnIzberiIgralca: TButton;
    cbeIgralci: TComboEdit;
    labIgralec: TLabel;
    btnIzbrisiIgralca: TButton;
    crcClose: TCircle;
    labX: TLabel;
    layBottom: TLayout;
    layCenter: TLayout;
    recVnosnaFormaIgralec: TRectangle;
    FDQIgralciID: TFDAutoIncField;
    FDQIgralcinaziv: TStringField;
    ShadowEffect1: TShadowEffect;
    grdRezultati: TGrid;
    Splitter1: TSplitter;
    layGumbIzvoz: TLayout;
    btnIzvoz: TSpeedButton;
    FDQIgre: TFDQuery;
    chrMnozenje: TChart;
    Series2: TPieSeries;
    chrDeljenje: TChart;
    PieSeries2: TPieSeries;
    chrSestevanje: TChart;
    PieSeries3: TPieSeries;
    chrOdstevanje: TChart;
    PieSeries4: TPieSeries;
    chrSkupaj: TChart;
    PieSeries1: TPieSeries;
    bsdIgre: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    bilIgre: TBindingsList;
    libOmejitve: TListBoxItem;
    libPreobleke: TListBoxItem;
    cobPreobleke: TComboBox;
    labPreobleke: TLabel;
    lbhPreobleke: TListBoxGroupHeader;
    lbhZvokAnimacija: TListBoxGroupHeader;
    lbhOmejitve: TListBoxGroupHeader;
    procedure TabControlChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIzhodClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure edtDrugoStKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure btnPreveriClick(Sender: TObject);
    procedure tmrCasRacunanjaTimer(Sender: TObject);
    procedure tmrPavzaTimer(Sender: TObject);
    procedure swcVklopiCasRacunanjaClick(Sender: TObject);
    procedure swcPredvajajAnimacijoClick(Sender: TObject);
    procedure PreveriInShrani(Sender: TObject);
    procedure PrikaziNastavitveOperacije(Sender: TObject);
    procedure ImageLogoClick(Sender: TObject);
    procedure tbiOprogramuClick(Sender: TObject);
    procedure cobOmejitveRacunanjaChange(Sender: TObject);
    procedure tmrSkupniCasTimer(Sender: TObject);
    procedure btnDodajIzberiIgralcaClick(Sender: TObject);
    procedure crcCloseClick(Sender: TObject);
    procedure cbeIgralciClosePopup(Sender: TObject);
    procedure btnIzberiIgralcaClick(Sender: TObject);
    procedure btnIzbrisiIgralcaClick(Sender: TObject);
    procedure flaVnosnaFormaIgralecFinish(Sender: TObject);
    procedure cbeIgralciKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure grdRezultatiCellClick(const Column: TColumn; const Row: Integer);
    procedure btnIzvozClick(Sender: TObject);
    procedure cbeIgralciTyping(Sender: TObject);
    procedure cobPreoblekeChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    cas: Integer;
    skupni_cas_racunanja: Integer;    // skupni čas vsega računanja
    st_izracunanih_racunov: Integer;  // ŠT.ŽE IZRAČUNANIH RAČUNOV
    nnClen: Integer;  // neznani ćlen, 0=prvi člen, 1=drugi člen, 2=tretji člen
    oper: Integer;    // operator 0=+; 1=-
    pravilno, napacno, neodgovorjeno: Integer;
    rezultati: array[0..3, 0..2] of Integer;     //[prlus/minus/krat/deljeno, pravilni/napačni/neodgovorjeni]
    FGifPlayer: TGifPlayer;
    cas_zacetka: TDateTime;
    napaka, odlicno, razmisljam: TStringList;
    zvok_napaka, zvok_odlicno, zvok_razmisljam: TStringList;
    pravilni_izracun: String;

    function PreveriRezultat():Boolean;
    procedure PonastaviRezultate();
    procedure IzpisiTrenutniRezultat();
    procedure IzberiNalogo();
    procedure NastaviVnosnaPolja(polje: TEdit; zaklenjeno: Boolean);
    procedure PocistiPolja();
    procedure PredvajajAnimacijo(seznam: TStringList);
    procedure PredvajajZvok(seznam: TStringList);
    procedure PreveriInShraniNastavitve();
    procedure ZacniIgro();
    procedure KoncajIgro();
    procedure PavzirajIgro();
    procedure NadaljujZIgro();
    procedure NapolniSeznamDatotek(zvrst, mapa: String;var seznam: TStringList);
    procedure PrikaziUstrezneNastavitve();
    procedure IzpisiList(i: TList<Integer>);
    procedure CreateDatabaseAndTable();
    procedure NapolniIgralce();
    procedure ShraniIgralca(ime: String);
    //procedure IzbrisiIgralca(ID: Integer);
    procedure IzbrisiIgralca(naziv: String);
    function DobiIDIgralca(naziv: String): Integer;
    procedure ShraniRezultat();
    procedure IzpisiRezultate();
    procedure NarisiGrafe();
    procedure NapolniPreobleke();
    {$IFDEF MSWINDOWS}
    procedure NastaviPolozajForme();
    {$ENDIF}
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;


implementation

{$R *.fmx}

uses System.Math, u_urlOpen, FMX.DialogService, FMX.Styles;

{ TfrmManin }


procedure TfrmMain.btnIzhodClick(Sender: TObject);
begin
  // Zapri aplikacijo
  Application.Terminate;
end;

procedure TfrmMain.btnIzvozClick(Sender: TObject);
var
  List: TStringList;
  S: String;
  i: Integer;
begin
  // Izvoz podatkov v csv obliko
    List := TStringList.Create;
    try
      // Izvozi najprej glavo
      s:='';
      for i := 0 to grdRezultati.ColumnCount -1 do
      begin
        if s>'' then
          s:=s + ';';
        s:=s + grdRezultati.ColumnByIndex(i).Header;
      end;
      List.Add(s);
      // Izvozi še podatke
      FDQIgre.First;
      while not FDQIgre.Eof do
      begin
        s:='';
        for i:= 0 to FDQIgre.FieldCount - 1 do
        begin
          if s>'' then
            s:=s + ';';
          s:=s + FDQIgre.Fields[i].AsString;
        end;
        List.Add(s);
        FDQIgre.Next;
      end;
    finally
      List.SaveToFile(GetExePath() + trenutni_igralec.naziv + '.csv');
      List.Free;
    end;
    ShowMessage('Podatki so izvoženi ' + GetExePath() + trenutni_igralec.naziv + '.csv');
end;

procedure TfrmMain.btnPreveriClick(Sender: TObject);
begin
  // preveri rezultate
  layRacunaj.Enabled:=False;
  if PreveriRezultat() then   // če je odgovor je pravilen
  begin
     labCas.Text:='BRAVO !!!';
     Inc(pravilno);
     rezultati[oper, 0]:=rezultati[oper,0] + 1;   // Pravilni = 0
     PredvajajAnimacijo(odlicno);
     PredvajajZvok(zvok_odlicno);
  end else                    // odgovor je napačen
  begin
    labCas.Text:=':-( Pravilno je ' + pravilni_izracun + ' )';
    Inc(napacno);
    rezultati[oper, 1]:=rezultati[oper, 1] + 1; // Napačni = 1
    PredvajajAnimacijo(napaka);
    PredvajajZvok(zvok_napaka);
  end;
  IzpisiTrenutniRezultat();
  tmrPavza.Enabled:=True;
  // povečaj št.izračunanih računov in končaj igro če smo prišli do konca
  Inc(st_izracunanih_racunov);
  if (omejitev_racunanja=2) then
  begin
    layOmejitevRacunanja.Visible:=True;
    labOmejitevRacunanja.Text:='Izračunanih ' + IntToSTr(st_izracunanih_racunov) + ' od ' +
                                IntToStr(omejitev_st_racunanja) + ' računov.';
    if (omejitev_racunanja=2) AND (st_izracunanih_racunov>=omejitev_st_racunanja) then
      KoncajIgro();
  end;
end;

procedure TfrmMain.btnStartClick(Sender: TObject);
begin
  case btnStart.ImageIndex of
    1: ZacniIgro();
    2: KoncajIgro();
    3: NadaljujZIgro();
  end;
end;


procedure TfrmMain.cobOmejitveRacunanjaChange(Sender: TObject);
begin
  // skrij edit box če ni izbra Omejitevčasa ali št. vprašanj
  edtCasOmejitev.Visible:=False;
  edtStRacunovOmejitev.Visible:=False;
  if cobOmejitveRacunanja.ItemIndex>0 then     //prikaži layer/label z razpoložljivim časovza računanje ali št. preostalih računov
    layOmejitevRacunanja.Visible:=True
  else
    layOmejitevRacunanja.Visible:=False;
  case cobOmejitveRacunanja.ItemIndex of
    1: edtCasOmejitev.Visible:=True;
    2: edtStRacunovOmejitev.Visible:=True;
  end;
end;

procedure TfrmMain.ZacniIgro();
begin
  btnDodajIzberiIgralca.Enabled:=False;
  TabControl.TabIndex:=0;
  btnStart.ImageIndex:=2;
  cas_zacetka:=Now;
  skupni_cas_racunanja:=0;    // skupni čas računanja vseh računov
  case (omejitev_racunanja) of     // čeje nastavljena omejitev računanja jo prikaži
  0: layOmejitevRacunanja.Visible:=False;
  1:
    begin
      tmrSkupniCas.Enabled:=True;
      layOmejitevRacunanja.Visible:=True;
      labOmejitevRacunanja.Text:='Preostali čas računanja ' +
                                  FormatDateTime('hh:mm:ss', SecondToTime(omejitev_cas_racunanja*60 - skupni_cas_racunanja))  + ' s';

    end;
  2:
    begin
      layOmejitevRacunanja.Visible:=True;
      labOmejitevRacunanja.Text:='Izračunanih ' + IntToSTr(st_izracunanih_racunov) + ' od ' + IntToStr(omejitev_st_racunanja) + ' računov.';
    end;
  end;

  layRacunaj.Enabled:=True;
  PocistiPolja();
  PonastaviRezultate();
  IzpisiTrenutniRezultat();
  IzberiNalogo();
end;

procedure TfrmMain.KoncajIgro();
begin
  btnDodajIzberiIgralca.Enabled:=True;
    FGifPlayer.stop;    // ustavi animacijo
    MediaPlayer.stop;   // ustavi zvok
    tmrSkupniCas.Enabled:=False;;
    imgAnimacija.Visible:=False;
    btnStart.ImageIndex:=1;
    tmrCasRacunanja.Enabled:=False;
    tmrPavza.Enabled:=False;
    PocistiPolja();
    labCas.Text:='';
    layRacunaj.Enabled:=False;
    if ((pravilno<>0) OR (napacno<>0) OR (neodgovorjeno<>0)) then     // če je bil vsaj en račun
    begin
      ShraniRezultat();
      IzpisiRezultate();  // izpiši rezultate v TGrid (zavihek Rezultati)
    end;
end;


procedure TfrmMain.PavzirajIgro();
begin
  if (FGifPlayer<>nil) then
  begin
    if (FGifPlayer.IsPlaying)  then
      FGifPlayer.stop;
  end;
  if btnStart.ImageIndex=2 then     // če smo sredi igre
    btnStart.ImageIndex:=3;         // nastavi gumb na pavzo
  tmrCasRacunanja.Enabled:=False;
  tmrSkupniCas.Enabled:=False;
end;

procedure TfrmMain.NadaljujZIgro();
begin
  if FGifPlayer<>nil then
    FGifPlayer.Play;
  btnStart.ImageIndex:=2;
  if swcVklopiCasRacunanja.IsChecked then
    tmrCasRacunanja.Enabled:=True;
  if omejitev_racunanja=1 then  // prikaži skupni čas računanja
    tmrSkupniCas.Enabled:=True;
  TabControl.TabIndex:=0;
end;

procedure TfrmMain.NapolniSeznamDatotek(zvrst, mapa: String; var seznam: TStringList);
var
  path, ffile: String;
begin
{ Deploying animation files
For Android, set the Remote Path to .\assets\internal\Racunaj\odlicno ali napaka ali razmisljam
For iOS, set the Remote Path to StartUp\Documents\Racunaj\odlicno ali napaka ali razmisljam
XXXXFor Windows 10, set the Remote Path to  %UserProfile%\Racunaj\odlicno ali napaka ali razmisljam
For Android, set the Remote Path to .\assets\internal
For iOS, set the Remote Path to StartUp\Documents
}
  path:=GetExePath() + zvrst + PathDelim  + mapa + PathDelim;
  try
    For ffile in TDirectory.GetFiles(path)  do
      seznam.Add(ffile);
  Except
    //ShowMessage('Pot ' + path + ' ne obstaja!');
  end;
end;

procedure TfrmMain.edtDrugoStKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key=vkReturn then
    btnPreveriClick(Self);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  CreateDatabaseAndTable();
  NapolniIgralce();
  NapolniPreobleke();
  layVnosnaFormaIgralca.Visible:=False; // skri layout Vnosno Formo za igralca
  cas_zacetka:=0;
  layRacunaj.Enabled:=False;
  TabControl.TabIndex:=0;     // prikaži zavihek za igro
  ReadIni();
  if (trenutni_igralec.ID<>-1) then
    cbeIgralci.ItemIndex:=cbeIgralci.Items.IndexOf(trenutni_igralec.naziv);
  if (cbeIgralci.ItemIndex=-1) then    // Nazadnje ni bil izbran noben igralec ali igralca ni več v bazi, zato odpri formo za izbiro igralca
    btnDodajIzberiIgralcaClick(Self)
  else
  begin
    labNapis.Text:=trenutni_igralec.naziv;
    IzpisiRezultate();
  end;

  cobPreobleke.ItemIndex:=preobleka;

  edtSestevajDo.Text:=IntToStr(sestevanje_do);
  edtOdstevanjeDo.Text:=IntToStr(odstevanje_od);
  edtMaxMnozenec.Text:=IntToStr(max_mnozenec);
  edtMnozenjeFaktor.Text:=mnozenje_faktorji;
  edtDeljenjeOd.Text:=IntToStr(deljenje_od);
  edtDeljenjeDeljitel.Text:=deljenje_deljitelji;

  // nastavitve omjejitve čas računanja vseh računov ali števila računov
  cobOmejitveRacunanja.ItemIndex:=omejitev_racunanja; //0=ni omejitve, 1=čas, 2=št. računov
  skupni_cas_racunanja:=0;
  st_izracunanih_racunov:=0;

  edtCasOmejitev.Text:=IntToSTr(omejitev_cas_racunanja);
  edtStRacunovOmejitev.Text:=IntToSTr(omejitev_st_racunanja);
  cobOmejitveRacunanjaChange(Self);

  edtCasRacunanja.Text:=IntToStr(cas_racunanja_enega_st);
  swcPoljubniNeznanClen.IsChecked:=nakljucni_nn_clen;
  swcPredvajajAnimacijo.IsChecked:=predvajaj_animacijo;
  swcPredvajajZvok.IsChecked:=predvajaj_zvok;
  swcVklopiCasRacunanja.IsChecked:=vklopi_cas_racunanja;
  lbiCasRacunanja.Enabled:=swcVklopiCasRacunanja.IsChecked;
  btnStart.Enabled:=False;

  if (GetBit(operacije, 0)=True) then
  begin
    chbSestevanje.IsChecked:=True;
    btnStart.Enabled:=True;
  end;
  if (GetBit(operacije, 1)=True) then
  begin
    chbOdstevanje.IsChecked:=True;
    btnStart.Enabled:=True;
  end;
  if (GetBit(operacije, 2)=True) then
  begin
    chbMnozenje.IsChecked:=True;
    btnStart.Enabled:=True;
  end;
  if (GetBit(operacije, 3)=True) then
  begin
    chbDeljenje.IsChecked:=True;
    btnStart.Enabled:=True;
  end;

  PrikaziUstrezneNastavitve;

  {$IFDEF MSWINDOWS}
  NastaviPolozajForme();
  {$ENDIF}

  labOperator.Text:='';
  cas:=cas_racunanja_enega_st;
  try
    FGifPlayer := TGifPlayer.Create(Self);
    FGifPlayer.Image := imgAnimacija;
    napaka:=TStringList.Create;
    odlicno:=TStringList.Create;
    razmisljam:=TStringList.Create;
    //napolni seznam animacij
    NapolniSeznamDatotek('Animacije','napaka', napaka);      //napaka, odlicno, razmisljam
    NapolniSeznamDatotek('Animacije', 'odlicno', odlicno);
    NapolniSeznamDatotek('Animacije', 'razmisljam', razmisljam);
    // napolni seznam zvokov
    zvok_napaka:=TStringList.Create;
    zvok_odlicno:=TStringList.Create;
    zvok_razmisljam:=TStringList.Create;
    NapolniSeznamDatotek('Zvok', 'napaka', zvok_napaka);      //napaka, odlicno, razmisljam
    NapolniSeznamDatotek('Zvok', 'odlicno', zvok_odlicno);
    NapolniSeznamDatotek('Zvok', 'razmisljam', zvok_razmisljam);
  Except
    ShowMessage('Napaka pri inicializaciji program!');
  end;
  PonastaviRezultate();
  IzpisiTrenutniRezultat();
end;


procedure TfrmMain.PocistiPolja();
begin
  edtPrvoSt.Text:='';
  edtDrugoSt.Text:='';
  edtRezultat.Text:='';
end;

procedure TfrmMain.PonastaviRezultate();
var
  i, j: Integer;
begin
  pravilno:=0;
  napacno:=0;
  neodgovorjeno:=0;
  st_izracunanih_racunov:=0;
  // resetiraj števce rezultatov
  for i:=0 to 3 do
    for j:=0 to 2 do
        rezultati[i, j]:=0;
end;

procedure TfrmMain.PredvajajAnimacijo(seznam: TStringList);
var
  ff, i: Integer;
begin
  if NOT (predvajaj_animacijo) then
  begin
    FGifPlayer.stop;
    imgAnimacija.Visible:=True;
    exit;
  end;
  // predvajaj animacijo
  ff:=seznam.Count;
  if ff>0 then
  begin
    i:=Random(ff);
    FGifPlayer.LoadFromFile(seznam[i]);
    imgAnimacija.Visible:=True;
    //FGifPlayer.LoadFromStream();
    FGifPlayer.Play;
  end;
end;


procedure TfrmMain.PredvajajZvok(seznam: TStringList);
var
  ff, i: Integer;
begin
  // predvajaj zvok
   if NOT (predvajaj_zvok) then
   begin
    MediaPlayer.stop;
    exit;
   end;
  // predvajaj zvok
  ff:=seznam.Count;
  if ff>0 then
  begin
    i:=Random(ff);
    MediaPlayer.FileName:=seznam[i];
    //FGifPlayer.LoadFromStream();
    MediaPlayer.Play;
  end;
end;

function TfrmMain.PreveriRezultat(): Boolean;
var
  st1,st2, rez: Integer;
begin
  // preveri rezultat
  Result:=False;
  tmrCasRacunanja.Enabled:=False;
  Try
    st1:=StrToInt(edtPrvoSt.Text);
    st2:=StrToInt(edtDrugoSt.Text);
    rez:=StrToInt(edtRezultat.Text);

    case oper of
      0:   //+
      begin
        if rez=st1+st2 then
          Result:=True
        else
          Result:=False;
      end;
      1:  // -
      begin
        if rez=st1-st2 then
          Result:=True
        else
          Result:=False;
      end;
      2:  // *
      begin
        if rez=st1*st2 then
          Result:=True
        else
          Result:=False;
      end;
      3:  // /
      begin
        if rez=st1/st2 then
          Result:=True
        else
          Result:=False;
      end;
    end;

  Except
    labCas.Text:='TO NI ŠTEVILO';
    Result:=False;
  End;
end;


procedure TfrmMain.PreveriInShrani(Sender: TObject);
begin
  PreveriInShraniNastavitve();
end;

procedure TfrmMain.PreveriInShraniNastavitve();
var
  napaka: String;
  faktorji: TList<Integer>;
begin
  // preveri vsa vnosna polja v nastavitvah če so pravilna
  napaka:='';
  Try
    faktorji:=TList<Integer>.Create;

    // preveri pravilnost vnesenih podatkov, ob napaki vrzi izjemo
    if (StrToInt(edtCasRacunanja.Text)<0) then
      napaka:='Nepravilen čas računanja enega števila!';
    if (StrToInt(edtSestevajDo.Text)<0) then
      napaka:='V polju Seštevanje do mora biti pozitivno število!';
    if (StrToInt(edtOdstevanjeDo.Text)<0) then
      napaka:='V polju Odštevanje od mora biti pozitivno število!';
      // Množenje
    StrToListIntFaktorji(edtMnozenjeFaktor.Text, StrToInt(edtMaxMnozenec.Text), faktorji);
    if (faktorji.Count=0) then      // preveri ali so pravilno zapisani faktorji množenja
      napaka:='Napaka pri zapisu faktorjev množenja!';
      // Deljenje
    faktorji.Clear;
    StrToListIntFaktorji(edtDeljenjeDeljitel.Text, StrToInt(edtDeljenjeOd.Text), faktorji);   // fator/ji
    if (faktorji.Count=0) then      // preveri ali so pravilno zapisani faktorji deljenja
      napaka:='Napaka pri zapisu faktorjev deljenja!';
    if (StrToInt(edtDeljenjeOd.Text)<GetMax(faktorji)) then
      napaka:='V polju Deljenje do mora biti število večje od največjega delitelja!';

    if (napaka<>'') then
      raise Exception.Create(napaka);

    sestevanje_do:=StrToInt(edtSestevajDo.Text);
    odstevanje_od:=StrToInt(edtOdstevanjeDo.Text);
    max_mnozenec:=StrToInt(edtMaxMnozenec.Text);
    mnozenje_faktorji:=edtMnozenjeFaktor.Text;
    deljenje_od:=StrToInt(edtDeljenjeOd.Text);
    deljenje_deljitelji:=edtDeljenjeDeljitel.Text;
    cas_racunanja_enega_st:=StrToInt(edtCasRacunanja.Text);
    if cas_racunanja_enega_st=0 then       // če je čas računanja enak 0 izklopi checkbox
      swcVklopiCasRacunanja.IsChecked:=False;
    vklopi_cas_racunanja:=swcVklopiCasRacunanja.IsChecked;

    preobleka:=cobPreobleke.ItemIndex;

    nakljucni_nn_clen:=swcPoljubniNeznanClen.IsChecked;
    predvajaj_animacijo:=swcPredvajajAnimacijo.IsChecked;
    predvajaj_zvok:=swcPredvajajZvok.IsChecked;

    omejitev_racunanja:=cobOmejitveRacunanja.ItemIndex;
    cobOmejitveRacunanjaChange(Self);
    omejitev_cas_racunanja:=StrToInt(edtCasOmejitev.Text);
    omejitev_st_racunanja:=StrToInt(edtStRacunovOmejitev.Text);

    operacije:=0;
    if chbSestevanje.IsChecked then
      SetBit(operacije, 0);
    if chbOdstevanje.IsChecked then
      SetBit(operacije, 1);
    if chbMnozenje.IsChecked then
      SetBit(operacije, 2);
    if chbDeljenje.IsChecked then
      SetBit(operacije, 3);
    SaveIni();
  Except
    ShowMessage(napaka);
    TabControl.TabIndex:=1;
  End;
end;

procedure TfrmMain.swcPredvajajAnimacijoClick(Sender: TObject);
begin
  // Skrij / prikaži animacijo
  { TODO : Predvajanje animacije se ne nadaljuje, nadaljuje se še le ko damo nov račun }
  predvajaj_animacijo:=swcPredvajajAnimacijo.IsChecked;
  if NOT (predvajaj_animacijo) then
  begin
    FGifPlayer.stop;
    imgAnimacija.Visible:=False;
  end else
    imgAnimacija.Visible:=True;
end;

procedure TfrmMain.swcVklopiCasRacunanjaClick(Sender: TObject);
begin
  lbiCasRacunanja.Enabled:=swcVklopiCasRacunanja.IsChecked;
end;

procedure TfrmMain.TabControlChange(Sender: TObject);
begin
  // Če je izbran katerikoli drugi zavihek pavziraj igro
  if ((TabControl.TabIndex<>0) and (cas_zacetka>0)) then
    //KoncajIgro();
    PavzirajIgro();
  // Če je bila igra pavzirana jo nadaljuj
  if ((TabControl.TabIndex=0) and (cas_zacetka>0) and (btnStart.ImageIndex<>1)) then
    NadaljujZIgro();
end;

procedure TfrmMain.tmrCasRacunanjaTimer(Sender: TObject);
begin
  // prikaži čas na formi
  Dec(cas);
  labCas.Text:=IntToStr(cas) + ' s';
  Application.ProcessMessages;
  // preveri ali se je čas že iztekel
  if cas=0 then  // čas je potekel
  begin
    tmrCasRacunanja.Enabled:=False;
    MediaPlayer.stop;   // ustavi zvok
    FGifPlayer.stop;    // ustavi animacijo
    Inc(neodgovorjeno);
    rezultati[oper, 2]:=rezultati[oper, 2] + 1;        // Neodgovorjeni = 2
    labCas.Text:='ŽAL SE JE TVOJ ČAS IZTEKEL! (' + pravilni_izracun + ')';
    layRacunaj.Enabled:=False;
    tmrPavza.Enabled:=True;
    // povečaj št.izračunanih računov in končaj igro če smo prišli do konca
    Inc(st_izracunanih_racunov);
    if (omejitev_racunanja=2) then
    begin
      layOmejitevRacunanja.Visible:=True;
      labOmejitevRacunanja.Text:='Izračunanih ' + IntToSTr(st_izracunanih_racunov) + ' od ' +
                                  IntToStr(omejitev_st_racunanja) + ' računov.';
      if (omejitev_racunanja=2) AND (st_izracunanih_racunov>=omejitev_st_racunanja) then
        KoncajIgro();
    end;
    IzpisiTrenutniRezultat();
  end;
end;

procedure TfrmMain.IzberiNalogo();
var
  st1, st2,rez: Integer;
  tmp: Integer;
  faktorji: TList<Integer>;
  delitelji: TList<Integer>;
  i: Integer;

begin
  try
    delitelji:=TList<Integer>.Create;
    faktorji:=TList<Integer>.Create;
    st1:=0;
    st2:=0;
    PocistiPolja();   // počisti polja
    cas:=cas_racunanja_enega_st;      // ponastavi čas
    if swcVklopiCasRacunanja.IsChecked then
      labCas.Text:=IntToStr(cas) + ' s'
    else
      labCas.Text:='';
    rez:=0;

    Randomize;

    // če je opracija=0 potem ni izbrano nobeno polje -> exit
    // 0=+; 1=-; 2=*; 3=/
    case operacije of
      0: Exit;
      1: oper:=0;                 // 0=+
      2: oper:=1;                 //1=-
      3: oper:=Random(2);         // 0=+ in 1=-
      4: oper:=2;                 // 2=*
      5: oper:=Random(2)*2;       // 2=* in 0=+
      6: oper:=RandomRange(1,3);  // 2=* in 1=-
      7: oper:=Random(3);         // 2=*, 0=+ in 1=-
      8: oper:=3;                 //3=/
      9: oper:=Random(2)*3;       // 3=/ in 0=+
      10: oper:=Random(2)*2+1;    //  3=/ in 1=-
      11: // 3=/, 0=+ in 1=-
      begin
        oper:=Random(3);
        if oper=2 then
          oper:=3;
      end;
      12: oper:=RandomRange(2,4);   // 3=/ in 2=*
      13: // 3=/, 2=* in 0=+
      begin
        oper:=RandomRange(1,4);
        if oper=1 then
          oper:=0;
      end;
      14: oper:=Random(4)+1;       // 3=/,2=* in 1=-
      15: oper:=Random(4);         // 3=/, 2=*, 1=- in 0=+
    end;

    case oper of
      0:     // za +
      begin
        st1:=Random(sestevanje_do + 1);
        st2:=Random(sestevanje_do+1-st1);
      end;
      1:     // za  -
      begin
        st1:=Random(odstevanje_od + 1);
        st2:=Random(odstevanje_od+1-st1);
      end;
      2:      // za *
      begin
        StrToListIntFaktorji(edtMnozenjeFaktor.Text, max_mnozenec, faktorji);              // fator/ji
        st1:=faktorji.items[Random(faktorji.Count)];     // izberi naključnega množitelja iz podanih
        st2:=Random(max_mnozenec)+1;
        if Random(100)>50 then
          ZamenjajStevila(st1, st2);
      end;
      3:    // za /                        { TODO : Popravi, upoštevaj deljenje z }
      begin
        StrToListIntFaktorji(edtDeljenjeDeljitel.Text, deljenje_od, faktorji);   // fator/ji
        if (faktorji.Items[0]=0) then
          faktorji.Delete(0);         // izbriši 0, napaka deljenja z 0
mDebug.Lines.Clear;
mDebug.Lines.Add('Vsi faktorji');
IzpisiList(faktorji);
        st2:=faktorji.items[Random(faktorji.Count)];   // izberi naključni faktor med vsemi faktorji
        { TODO : Popravi, dabo razporeditev naključnih številj drugačna. Večja verjetnost mora biti za 1/3 faktorjev.
Drugače je velikokrat rezultat samo 1! }
mDebug.Lines.Add('----------Izbran faktor----------------');
mDebug.Lines.Add(IntToStr(st2));
mDebug.Lines.Add('-------------Vsi delitelji---------------');
        DeliteljiSt2(deljenje_od, st2, delitelji);
IzpisiList(delitelji);
//TabControl.TabIndex:=3;
        i:=Random(delitelji.Count);
        st1:=delitelji.Items[i];
      end;
    end;


    case oper of
      0:    // +
      begin
        labOperator.Text:='+';
        rez:=st1+st2;
        pravilni_izracun:=IntToSTr(st1) + '+' + IntToStr(st2) + '=' + IntToStr(rez);
      end;
      1:    // -
      begin
        labOperator.Text:='-';
        if (st1<st2) then  // zamenjaj prvo in drugo številko (da vedno odšteješ večjega od manjšega
        begin
          tmp:=st1;
          st1:=st2;
          st2:=Tmp;
        end;
        rez:=st1-st2;
        pravilni_izracun:=IntToSTr(st1) + '-' + IntToStr(st2) + '=' + IntToStr(rez);
      end;
      2:   // *
      begin
        labOperator.Text:='*';
        rez:=st1*st2;
        pravilni_izracun:=IntToSTr(st1) + '*' + IntToStr(st2) + '=' + IntToStr(rez)
      end;
      3:   // /
      begin
        labOperator.Text:='/';
        rez:=Round(st1/st2);
        pravilni_izracun:=IntToSTr(st1) + '/' + IntToStr(st2) + '=' + IntToStr(rez);
      end;
    end;

    if swcPoljubniNeznanClen.IsChecked then
      nnClen:=Random(3) // 0=prvi člen, 1=drugi člen, 2=tretji člen
    else
      nnClen:=2;

    if nakljucni_nn_clen then
    begin
      case nnClen of
        0:    // neznani prvi člen
        begin
          edtDrugoSt.Text:=IntToStr(st2);
          NastaviVnosnaPolja(edtDrugoSt, True);
          edtRezultat.Text:=IntToStr(rez);
          NastaviVnosnaPolja(edtRezultat, True);
          NastaviVnosnaPolja(edtPrvoSt, False);
        end;
        1:    // neznani drugi člen
        begin
          edtPrvoSt.Text:=IntToStr(st1);
          NastaviVnosnaPolja(edtPrvoSt, True);
          edtRezultat.Text:=IntToStr(rez);
          NastaviVnosnaPolja(edtRezultat, True);
          NastaviVnosnaPolja(edtDrugoSt, False);
        end;
        2:    // neznani reziltat
        begin
          edtPrvoSt.Text:=IntToStr(st1);
          NastaviVnosnaPolja(edtPrvoSt, True);
          edtDrugoSt.Text:=IntToStr(st2);
          NastaviVnosnaPolja(edtDrugoSt, True);
          NastaviVnosnaPolja(edtRezultat, False);
        end;
      end;
    end else
    begin
      edtPrvoSt.Text:=IntToStr(st1);
      NastaviVnosnaPolja(edtPrvoSt, True);
      edtDrugoSt.Text:=IntToStr(st2);
      NastaviVnosnaPolja(edtDrugoSt, True);
      NastaviVnosnaPolja(edtRezultat, False);
    end;
    PredvajajAnimacijo(razmisljam);
    PredvajajZvok(zvok_razmisljam);
    if swcVklopiCasRacunanja.IsChecked then
      tmrCasRacunanja.Enabled:=True;
  finally
    delitelji.Free;
    faktorji.Free;
  end;
end;

procedure TfrmMain.IzpisiTrenutniRezultat();
begin
  labRezultat.Text:='PRAVILNO: ' + IntToStr(pravilno) + ', NAPAČNO: ' + IntToStr(napacno) + ', ' + 'NEODGOVORJENO: ' + IntToStr(neodgovorjeno);
  labOmejitevRacunanja.Text:='Izračunanih ' + IntToSTr(st_izracunanih_racunov) + ' od ' + IntToStr(omejitev_st_racunanja) + ' računov.';
end;

procedure TfrmMain.tmrPavzaTimer(Sender: TObject);
begin
  tmrPavza.Enabled:=False;
  layRacunaj.Enabled:=True;
  IzberiNalogo();
end;


procedure TfrmMain.tmrSkupniCasTimer(Sender: TObject);
begin
  Inc(skupni_cas_racunanja);
  labOmejitevRacunanja.Text:='Preostali čas računanja ' +
                          FormatDateTime('hh:mm:ss', SecondToTime(omejitev_cas_racunanja*60 - skupni_cas_racunanja))  + ' s';

  if (skupni_cas_racunanja>=(omejitev_cas_racunanja*60)) then
    KoncajIgro();    // čas za reševanje vsaeh računov se je iztekel.
end;


procedure TfrmMain.NastaviVnosnaPolja(polje: TEdit; zaklenjeno: Boolean);
begin
  polje.CanFocus:=NOT zaklenjeno;
  polje.ReadOnly:=zaklenjeno;
  if NOT zaklenjeno then
    polje.SetFocus;
end;


procedure TfrmMain.PrikaziNastavitveOperacije(Sender: TObject);
begin
  PrikaziUstrezneNastavitve();
end;

procedure TfrmMain.PrikaziUstrezneNastavitve();
begin
        { TODO 1 : LIst Deljenje se ne prikaže vedno, ko kliknemo na checkbox!!!!! }
  btnStart.Enabled:=False;
  lbhSeštevanje.Visible:=False;
  lbiSestevajDo.Visible:=False;
  lbhOdštevanje.Visible:=False;
  lbiOdstevanje.Visible:=False;
  lbhMnozenje.Visible:=False;
  lbiMnozenjeDo.Visible:=False;
  libMnozenjeFaktor.Visible:=False;
  lbhDeljenje.Visible:=False;
  lbiDeljenjeOd.Visible:=False;
  lbiDeljenjeDelitelj.Visible:=False;

  if (chbSestevanje.IsChecked) then   // Plus (+)
  begin
    lbhSeštevanje.Visible:=True;
    lbiSestevajDo.Visible:=True;
    btnStart.Enabled:=True;
  end;
  if (chbOdstevanje.IsChecked) then   // Minus (-)
  begin
    lbhOdštevanje.Visible:=True;
    lbiOdstevanje.Visible:=True;
    btnStart.Enabled:=True;
  end;
  if (chbMnozenje.IsChecked) then   // Krat (*)
  begin
    lbhMnozenje.Visible:=True;
    lbiMnozenjeDo.Visible:=True;
    libMnozenjeFaktor.Visible:=True;
    btnStart.Enabled:=True;
  end;
  if (chbDeljenje.IsChecked) then   // Deljeno (/)
  begin
    lbhDeljenje.Visible:=True;
    lbiDeljenjeOd.Visible:=True;
    lbiDeljenjeDelitelj.Visible:=True;
    btnStart.Enabled:=True;
  end;
end;


procedure TfrmMain.ImageLogoClick(Sender: TObject);
begin
  // odpri spletno stran aspira.si v privzetem brskalniku
  tUrlOpen.OpenURL('www.aspira.si');
end;


procedure TfrmMain.tbiOprogramuClick(Sender: TObject);
var
  path: String;
begin
  // naloži about.html v brskalnik
  path:=GetExePath() + 'about.html';
  WebBrowser.LoadFromStrings(TFile.ReadAllText(path), '');
  //WebBrowser.Navigate(path);
end;


procedure TfrmMain.CreateDatabaseAndTable();
var
  DBName: String;
begin
  // če podatkovna baza ne obstaja jo kreiraj, ustvari tabele in polja ter se priklopi nanjo
  DBName:=GetExePath() + 'racunaj.sqlite';

  FDConnection.Params.Values['database'] := DBName;
  FDConnection.Connected:= True;

  FDConnection.ExecSQL('CREATE TABLE IF NOT EXISTS Igralci ('+
                      ' id integer PRIMARY KEY AUTOINCREMENT, '+
                      '	naziv varchar NOT NULL)');

  FDConnection.ExecSQL('CREATE TABLE IF NOT EXISTS Igre (' +
                        'id integer PRIMARY KEY AUTOINCREMENT, ' +
                        'igralec_id integer NOT NULL, ' +
                        'datum datetime, ' +
                        'sestevanje_pravilni integer DEFAULT 0, ' +
                        'sestevanje_napacni integer DEFAULT 0, ' +
                        'sestevanje_neodgovorjeni integer DEFAULT 0, ' +
                        'odstevanje_pravilni integer DEFAULT 0, ' +
                        'odstevanje_napacni integer DEFAULT 0, ' +
                        'odstevanje_neodgovorjeni integer DEFAULT 0, ' +
                        'mnozenje_pravilni integer DEFAULT 0, ' +
                        'mnozenje_napacni integer DEFAULT 0, ' +
                        'mnozenje_neodgovorjeni integer DEFAULT 0, ' +
                        'deljenje_pravilni integer DEFAULT 0, ' +
                        'deljenje_napacni integer DEFAULT 0, ' +
                        'deljenje_neodgovorjeni integer DEFAULT 0)');

end;


procedure TfrmMain.ShraniIgralca(ime: String);
begin
  // Dodaj igralca v DB
  FDQIgralci.SQL.Clear;
  FDQIgralci.SQL.Add('INSERT INTO Igralci (naziv) VALUES (:naziv)');
  FDQIgralci.Params.ParamByName('naziv').Value:=ime;
  FDQIgralci.ExecSQL();
end;

procedure TfrmMain.ShraniRezultat();
var
  sql: String;
begin
  // shrani razultat za trenutnega igralca v DB  // //
  sql:='INSERT INTO Igre (igralec_id, datum, sestevanje_pravilni, sestevanje_napacni, ' +
      'sestevanje_neodgovorjeni, odstevanje_pravilni, odstevanje_napacni, ' +
      'odstevanje_neodgovorjeni, mnozenje_pravilni, mnozenje_napacni, ' +
      'mnozenje_neodgovorjeni, deljenje_pravilni, deljenje_napacni, ' +
      'deljenje_neodgovorjeni) VALUES (:igralec_id, :datum, :sestevanje_pravilni, :sestevanje_napacni, ' +
      ':sestevanje_neodgovorjeni, :odstevanje_pravilni, :odstevanje_napacni, ' +
      ':odstevanje_neodgovorjeni, :mnozenje_pravilni, :mnozenje_napacni, ' +
      ':mnozenje_neodgovorjeni, :deljenje_pravilni, :deljenje_napacni, ' +
      ':deljenje_neodgovorjeni)';
  FDQIgre.SQL.Clear;
  FDQIgre.SQL.Add(sql);
  FDQIgre.Params.ParamByName('igralec_id').Value:=trenutni_igralec.ID;
  FDQIgre.Params.ParamByName('datum').Value:=Now();

  FDQIgre.Params.ParamByName('sestevanje_pravilni').Value:=rezultati[0,0];
  FDQIgre.Params.ParamByName('sestevanje_napacni').Value:=rezultati[0,1];
  FDQIgre.Params.ParamByName('sestevanje_neodgovorjeni').Value:=rezultati[0,2];

  FDQIgre.Params.ParamByName('odstevanje_pravilni').Value:=rezultati[1,0];
  FDQIgre.Params.ParamByName('odstevanje_napacni').Value:=rezultati[1,1];
  FDQIgre.Params.ParamByName('odstevanje_neodgovorjeni').Value:=rezultati[1,2];

  FDQIgre.Params.ParamByName('mnozenje_pravilni').Value:=rezultati[2,0];
  FDQIgre.Params.ParamByName('mnozenje_napacni').Value:=rezultati[2,1];
  FDQIgre.Params.ParamByName('mnozenje_neodgovorjeni').Value:=rezultati[2,2];

  FDQIgre.Params.ParamByName('deljenje_pravilni').Value:=rezultati[3,0];
  FDQIgre.Params.ParamByName('deljenje_napacni').Value:=rezultati[3,1];
  FDQIgre.Params.ParamByName('deljenje_neodgovorjeni').Value:=rezultati[3,2];
  FDQIgre.ExecSQL();
  IzpisiRezultate();
end;


function TfrmMain.DobiIDIgralca(naziv: String): Integer;
begin
  // dobi ID igralca
  Result:=-1;
  FDQIgralci.SQL.Clear;
  FDQIgralci.SQL.Add('SELECT * FROM Igralci WHERE naziv=:naziv');
  FDQIgralci.Params.ParamByName('naziv').Value:=naziv;
  FDQIgralci.Open();
  if FDQIgralci.RecordCount>0 then
    Result:=FDQIgralci.FieldByName('ID').AsInteger;
end;

procedure TfrmMain.IzbrisiIgralca(naziv: String);
var
  ID: Integer;
begin
  ID:=DobiIDIgralca(naziv);
  if ID>-1 then
  begin
    ID:=FDQIgralci.FieldByName('ID').AsInteger;
    // Izbriši igralca iz DB in vse njegove rezutate
    FDQIgralci.SQL.Clear;
    FDQIgralci.SQL.Add('DELETE FROM Igralci WHERE id=:id');
    FDQIgralci.Params.ParamByName('id').Value:=ID;
    FDQIgralci.ExecSQL();

    FDQIgralci.SQL.Clear;
    FDQIgralci.SQL.Add('DELETE FROM Igre WHERE igralec_id=:igralec_id');
    FDQIgralci.Params.ParamByName('igralec_id').Value:=ID;
    FDQIgralci.ExecSQL();
  end;
end;


procedure TfrmMain.NapolniIgralce();
begin
  // Napolni že obstoječe igralce iz DB v cbeIgralci
  cbeIgralci.Items.Clear; // počisti ComboBox

  cbeIgralci.Items.Clear;
  FDQIgralci.SQL.Clear;
  FDQIgralci.SQL.Add('SELECT * FROM Igralci');
  FDQIgralci.Open();

  while not FDQIgralci.Eof do begin
    cbeIgralci.Items.Add(FDQIgralci.FieldByName('naziv').AsString);
    FDQIgralci.Next;
  end;
  FDQIgralci.Close;
end;

procedure TfrmMain.IzpisiRezultate();
begin
  // Izpiši vse rezultate za izbranega igralca in jih predstavi v tabeli (zavihek Rezultati)
  FDQIgre.SQL.Clear;
  FDQIgre.SQL.Add('SELECT * FROM Igre WHERE igralec_id=:igralec_id');
  FDQIgre.Params.ParamByName('igralec_id').Value:=trenutni_igralec.ID;
  FDQIgre.Open();
  NarisiGrafe();
end;

procedure TfrmMain.grdRezultatiCellClick(const Column: TColumn;
  const Row: Integer);
  Begin
    NarisiGrafe();
  end;

procedure TfrmMain.btnDodajIzberiIgralcaClick(Sender: TObject);
begin
  // Odpri formo za dodajanje / izbiranje igralcev
  if layVnosnaFormaIgralca.Visible=False then
  begin
    layVnosnaFormaIgralca.Position.Y := Self.Height + 20;   //frmMain.Height
    layVnosnaFormaIgralca.Visible := true;
    cbeIgralci.SetFocus;

    flaVnosnaFormaIgralec.Inverse := false;
    flaVnosnaFormaIgralec.StartValue := Self.Height + 20;   //frmMain.Height
    flaVnosnaFormaIgralec.StopValue := 0;
    flaVnosnaFormaIgralec.Start;
  end else
  begin
    flaVnosnaFormaIgralec.Inverse := true;
    flaVnosnaFormaIgralec.Start;
  end;
  if cbeIgralci.Text='' then
  begin
    btnIzberiIgralca.Enabled:=False;
    crcClose.Enabled:=False;
  end else
  begin
    btnIzberiIgralca.Enabled:=True;
    crcClose.Enabled:=True;
  end;
  if cbeIgralci.ItemIndex<>-1 then
    btnIzbrisiIgralca.Visible:=True;
  btnStart.Enabled:=False;
end;

procedure TfrmMain.flaVnosnaFormaIgralecFinish(Sender: TObject);
begin
  // konec animacije forme za vnos igralca
  if flaVnosnaFormaIgralec.Inverse = true then
    layVnosnaFormaIgralca.Visible := false;
end;

procedure TfrmMain.cbeIgralciClosePopup(Sender: TObject);
begin
  // Prikaži možnost izbrisa igralca iz DB
  if cbeIgralci.ItemIndex<>-1 then // ni bil izbran noben igralec iz menija
  begin
    btnIzbrisiIgralca.Visible:=True;
    btnIzberiIgralca.Enabled:=True;
  end;
end;

procedure TfrmMain.cbeIgralciKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  // če je bil pritisnjen Enter klikni na gumb OK
  if Key=vkReturn then
    btnIzberiIgralcaClick(Self);
end;

procedure TfrmMain.cbeIgralciTyping(Sender: TObject);
begin
  // Skrij možnost izbrisa igralca iz DB
  btnIzbrisiIgralca.Visible:=False;
  if cbeIgralci.Text='' then
  begin
    btnIzberiIgralca.Enabled:=False;
    crcClose.Enabled:=False;
  end else
  begin
    btnIzberiIgralca.Enabled:=True;
  end;
end;

procedure TfrmMain.crcCloseClick(Sender: TObject);
begin
  // Zapri formo za dodajanje / izbiranje igralcev
  flaVnosnaFormaIgralec.Inverse := true;
  flaVnosnaFormaIgralec.Start;
  btnStart.Enabled:=True;
  cbeIgralci.Text:=cbeIgralci.Items[cbeIgralci.ItemIndex];
end;


procedure TfrmMain.btnIzberiIgralcaClick(Sender: TObject);
var
  igralec: String;
begin
  // Potrdi izbranega Igralca
  flaVnosnaFormaIgralec.Inverse := true;
  flaVnosnaFormaIgralec.Start;

  cbeIgralci.Items.IndexOf(cbeIgralci.Text);  // če ime že obstaja v cbeIgralci in DB, samo nastavi kot izbranega v cbeIgralce
  if cbeIgralci.ItemIndex=-1 then // če dodamo noveg igralca
  begin
    // Dodaj novega igralca v DB
    igralec:=cbeIgralci.Text;
    ShraniIgralca(igralec);
    NapolniIgralce();
    cbeIgralci.ItemIndex:=cbeIgralci.Items.IndexOf(igralec);
  end;
  // nastavi trenutnega igralca
  trenutni_igralec.ID:=DobiIDIgralca(cbeIgralci.Items.KeyNames[cbeIgralci.ItemIndex]);
  trenutni_igralec.naziv:=cbeIgralci.Items.KeyNames[cbeIgralci.ItemIndex];
  labNapis.Text:=trenutni_igralec.naziv;
  btnStart.Enabled:=True;
  IzpisiRezultate();
  SaveIni();
end;


procedure TfrmMain.btnIzbrisiIgralcaClick(Sender: TObject);
var
  igralec: String;
begin
  // Ali res želiš izbrisati igralca X in vse njegove podatke?
  igralec:=cbeIgralci.Text;
  TDialogService.MessageDialog(('Ali želite resnično izbrisati igralca ' + igralec + ' in vse njegove rezultate?'),
    system.UITypes.TMsgDlgType.mtConfirmation, [system.UITypes.TMsgDlgBtn.mbYes, system.UITypes.TMsgDlgBtn.mbNo],
    system.UITypes.TMsgDlgBtn.mbYes,0,
    procedure (const AResult: System.UITypes.TModalResult)
    begin
        if AResult=mrYes then
        begin
          IzbrisiIgralca(cbeIgralci.Items.KeyNames[cbeIgralci.ItemIndex]);
          if (cbeIgralci.ItemIndex<>-1) then     // če igralec obstaja ga izbriši
              cbeIgralci.Items.Delete(cbeIgralci.ItemIndex);
          cbeIgralci.Text:='';
          btnIzbrisiIgralca.Visible:=False;
          btnIzberiIgralca.Enabled:=False;
          crcClose.Enabled:=False;
        end;
    end);
end;


procedure TfrmMain.NarisiGrafe();
var
  pravilni, napacni, neodgovorjeni: Integer;
begin
  chrSestevanje.Series[0].Clear;
  chrOdstevanje.Series[0].Clear;
  chrMnozenje.Series[0].Clear;
  chrDeljenje.Series[0].Clear;
  chrSkupaj.Series[0].Clear;
  if NOT (FDQIgre.IsEmpty) then   // čeobstajajo rezultati jih prikaži na grafu
  begin
    // Seštevanje
    chrSestevanje.Series[0].Add(FDQIgre.FieldByName('sestevanje_pravilni').Value, 'Pravilni', clTeeColor);
    chrSestevanje.Series[0].Add(FDQIgre.FieldByName('sestevanje_napacni').Value, 'Napačni', clTeeColor);
    chrSestevanje.Series[0].Add(FDQIgre.FieldByName('sestevanje_neodgovorjeni').Value, 'Neodgovorjeni', clTeeColor);
    // Odštevanje
    chrOdstevanje.Series[0].Add(FDQIgre.FieldByName('odstevanje_pravilni').Value, 'Pravilni', clTeeColor);
    chrOdstevanje.Series[0].Add(FDQIgre.FieldByName('odstevanje_napacni').Value, 'Napačni', clTeeColor);
    chrOdstevanje.Series[0].Add(FDQIgre.FieldByName('odstevanje_neodgovorjeni').Value, 'Neodgovorjeni', clTeeColor);
    // Množenje
    chrMnozenje.Series[0].Add(FDQIgre.FieldByName('mnozenje_pravilni').Value, 'Pravilni', clTeeColor);
    chrMnozenje.Series[0].Add(FDQIgre.FieldByName('mnozenje_napacni').Value, 'Napačni', clTeeColor);
    chrMnozenje.Series[0].Add(FDQIgre.FieldByName('mnozenje_neodgovorjeni').Value, 'Neodgovorjeni', clTeeColor);
    // Deljenje
    chrDeljenje.Series[0].Add(FDQIgre.FieldByName('deljenje_pravilni').Value, 'Pravilni', clTeeColor);
    chrDeljenje.Series[0].Add(FDQIgre.FieldByName('deljenje_napacni').Value, 'Napačni', clTeeColor);
    chrDeljenje.Series[0].Add(FDQIgre.FieldByName('deljenje_neodgovorjeni').Value, 'Neodgovorjeni', clTeeColor);
    // SKUPAJ
    pravilni:=FDQIgre.FieldByName('sestevanje_pravilni').Value + FDQIgre.FieldByName('odstevanje_pravilni').Value +
              FDQIgre.FieldByName('mnozenje_pravilni').Value +  FDQIgre.FieldByName('deljenje_pravilni').Value;
    napacni:=FDQIgre.FieldByName('sestevanje_napacni').Value + FDQIgre.FieldByName('odstevanje_napacni').Value +
              FDQIgre.FieldByName('mnozenje_napacni').Value +  FDQIgre.FieldByName('deljenje_napacni').Value;
    neodgovorjeni:=FDQIgre.FieldByName('sestevanje_neodgovorjeni').Value + FDQIgre.FieldByName('odstevanje_neodgovorjeni').Value +
              FDQIgre.FieldByName('mnozenje_neodgovorjeni').Value +  FDQIgre.FieldByName('deljenje_neodgovorjeni').Value;
    chrSkupaj.Series[0].Add(pravilni, 'Pravilni', clTeeColor);
    chrSkupaj.Series[0].Add(napacni, 'Napačni', clTeeColor);
    chrSkupaj.Series[0].Add(neodgovorjeni, 'Neodgovorjeni', clTeeColor);
  end;
end;

procedure TfrmMain.NapolniPreobleke();
begin
  cobPreobleke.Clear;
  {$IFDEF MSWINDOWS}
  cobPreobleke.Items.Add('Privzeto');
  cobPreobleke.Items.Add('Transparent');
  cobPreobleke.Items.Add('Win10ModernBlue');
  cobPreobleke.Items.Add('Win10ModernGreen');
  cobPreobleke.Items.Add('Win10ModernPurple');
  cobPreobleke.Items.Add('Win10ModernSlateGray');
  {$ENDIF}
  {$IFDEF ANDROID}
  cobPreobleke.Items.Add('Privzeto');
  cobPreobleke.Items.Add('AndroidLDarkBlue');
  cobPreobleke.Items.Add('AndroidLDark');
  cobPreobleke.Items.Add('AndroidLight');
  {$ENDIF}
  {$IFDEF IOS}
  { TODO : Preveri iOS preobleke }
  libPreobleke.Visible:=False;
{$ENDIF}
end;


procedure TfrmMain.cobPreoblekeChange(Sender: TObject);
var
  s: String;
begin
  s:=cobPreobleke.Items[cobPreobleke.ItemIndex];
  if s='Privzeto' then
    TStyleManager.SetStyle(nil)
  else
    TStyleManager.TrySetStyleFromResource(s);
end;

{$IFDEF MSWINDOWS}
procedure TfrmMain.NastaviPolozajForme();
begin
  // Windows - položaj in velikost okna
  if (forma_visina=-1) or (forma_sirina=-1) then
  begin
    // Forma je v Maximized state
    Self.WindowState:=TWindowState.wsMaximized;
    exit;
  end else
  begin
    Self.Height:=forma_visina;
    Self.Width:=forma_sirina;
  end;
  if (forma_levo=-1) or (forma_zgoraj=-1) then
  begin
    // nastavi formo na sredino zaslona
    Self.Left:=(Screen.Size.Width div 2) - (Self.Width div 2);
    Self.Top:=(Screen.Size.Height div 2) - (Self.Height div 2);
  end else
  begin
    Self.Top:=forma_zgoraj;
    Self.Left:=forma_levo;
  end;
end;
{$ENDIF}

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  // Windows - položaj in velikost okna
  if (Self.WindowState=TWindowState.wsMaximized) then
  begin
    forma_sirina:=-1;
    forma_visina:=-1;
    forma_levo:=-1;
    forma_zgoraj:=-1;
  end else
  begin
    forma_sirina:=Self.Width;
    forma_visina:=Self.Height;
    forma_levo:=Self.Left;
    forma_zgoraj:=Self.Top;
  end;
  SaveIni();
  {$ENDIF}
end;



 { TODO : DEBUGG - odstrani }
procedure TfrmMain.IzpisiList(i: TList<Integer>);
var
  j: integer;
begin
  for j:=0 to i.Count-1 do
    mDebug.Lines.Add(IntToStr(i.Items[j]));
end;
{ TODO : DEBUGG - odstrani }

end.
