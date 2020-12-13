﻿unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.DateTimeCtrls, FMX.ListBox, FMX.Layouts, System.ImageList, FMX.ImgList,
  FMX.Objects, FMX.Edit, FMX.Controls.Presentation, FMX.TabControl,
  SharedUnit, FMX.GifUtils, System.DateUtils, FMX.ScrollBox, FMX.Memo,
  System.IOUtils;

type
  TfrmMain = class(TForm)
    TabControl: TTabControl;
    tbiRacunaj: TTabItem;
    tbiNastavitve: TTabItem;
    layGumbi: TLayout;
    btnStart: TSpeedButton;
    btnIzhod: TSpeedButton;
    layRezultat1: TLayout;
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
    lbiRacunajDo: TListBoxItem;
    lbiCasRacunanja: TListBoxItem;
    lbiPoljubniNeznanClen: TListBoxItem;
    labRacunjaDo: TLabel;
    edtRacunajDo: TEdit;
    iabCasRacunanja: TLabel;
    swcPoljubniNeznanClen: TSwitch;
    labPoljubniNeznanClen: TLabel;
    labNapis: TLabel;
    tmrCasRacunanja: TTimer;
    edtCasRacunanja: TEdit;
    labS: TLabel;
    tbiRezultati: TTabItem;
    memRezultati: TMemo;
    tmrPavza: TTimer;
    TabItem1: TTabItem;
    procedure TabControlChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIzhodClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure edtDrugoStKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure btnPreveriClick(Sender: TObject);
    procedure tmrCasRacunanjaTimer(Sender: TObject);
    procedure tmrPavzaTimer(Sender: TObject);
  private
    { Private declarations }
    cas: Integer;
    pravilno, napacno, neodgovorjeno: Integer;
    FGifPlayer: TGifPlayer;
    cas_zacetka: TDateTime;
    function PreveriRezultat():Boolean;
    procedure PonastaviRezultate();
    procedure IzpisiRezultate();
    procedure IzberiNalogo();
    procedure NastaviVnosnaPolja(polje: TEdit; zaklenjeno: Boolean);
    procedure PocistiPolja();
    procedure PredvajajAnimacijo(animacija: String);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;


implementation

{$R *.fmx}

{ TfrmManin }

procedure TfrmMain.btnIzhodClick(Sender: TObject);
begin
  // Zapri aplikacijo
  Application.Terminate;
end;

procedure TfrmMain.btnPreveriClick(Sender: TObject);
begin
  // preveri rezultate
  layRacunaj.Enabled:=False;
  if PreveriRezultat() then   // če je odgovor je pravilen
  begin
     labCas.Text:='BRAVO !!!';
     Inc(pravilno);
     PredvajajAnimacijo('odlicno');
  end else                    // odgovor je napačen
  begin
    labCas.Text:=':( !!!';
    Inc(napacno);
    PredvajajAnimacijo('napaka');
  end;
  IzpisiRezultate();
  tmrPavza.Enabled:=True;
end;

procedure TfrmMain.btnStartClick(Sender: TObject);
var
  skupen_cas: Integer;
begin
  if btnStart.ImageIndex=1 then // začni igro
  begin
    btnStart.ImageIndex:=2;
    cas_zacetka:=Now;
    layRacunaj.Enabled:=True;
    PocistiPolja();
    PonastaviRezultate();
    IzpisiRezultate();
    IzberiNalogo();
  end else    // končaj igro
  begin
    btnStart.ImageIndex:=1;
    tmrCasRacunanja.Enabled:=False;
    tmrPavza.Enabled:=False;
    skupen_cas:=SecondsBetween(Now, cas_zacetka);
    PocistiPolja();
    labCas.Text:='';
    layRacunaj.Enabled:=False;
    memRezultati.Lines.Add(DateTimeToStr(Now) + ' ; čas reševanje=' + IntToStr(skupen_cas) + ' sec ; pravilnih=' + IntToSTr(pravilno) +
                            '; napačnih=' + IntToStr(napacno) + '; neodgovorjenih=' +
                            IntToSTr(neodgovorjeno));
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
  TabControl.TabIndex:=0;
  ReadIni();
  edtRacunajDo.Text:=IntToStr(racuna_do_st);
  edtCasRacunanja.Text:=IntToStr(cas_racunanja_enega_st);
  swcPoljubniNeznanClen.IsChecked:=nakljucni_nn_clen;
  cas:=cas_racunanja_enega_st;
  FGifPlayer := TGifPlayer.Create(Self);
  FGifPlayer.Image := imgAnimacija;
  PonastaviRezultate();
  IzpisiRezultate();

end;

procedure TfrmMain.PocistiPolja();
begin
  edtPrvoSt.Text:='';
  edtDrugoSt.Text:='';
  edtRezultat.Text:='';
end;

procedure TfrmMain.PonastaviRezultate();
begin
  pravilno:=0;
  napacno:=0;
  neodgovorjeno:=0;
end;

procedure TfrmMain.PredvajajAnimacijo(animacija: String);
var
  ff, i: Integer;
  path: String;
begin
  path:=TPath.GetDocumentsPath + PathDelim + 'Racunaj' + PathDelim + 'animation' + PathDelim  + animacija + PathDelim;
  ff:=CountFilesInFolder(path );
  i:=Random(ff)+1;
  FGifPlayer.LoadFromFile(path + IntToStr(i) + '.gif');
  imgAnimacija.Visible:=True;

  //FGifPlayer.LoadFromStream();

  FGifPlayer.Play;
end;

function TfrmMain.PreveriRezultat(): Boolean;
var
  st1,st2, rez: Integer;
begin
  // preveri rezultat
  tmrCasRacunanja.Enabled:=False;
  Try
    st1:=StrToInt(edtPrvoSt.Text);
    st2:=StrToInt(edtDrugoSt.Text);
    rez:=StrToInt(edtRezultat.Text);
    if (labOperator.Text='+') then
    begin
      if rez=st1+st2 then
        Result:=True
      else
        Result:=False;
    end else
    begin
      if rez=st1-st2 then
        Result:=True
      else
        Result:=False;
    end;
  Except
    labCas.Text:='TO NI ŠTEVILO';
    Result:=False;
  End;
end;

procedure TfrmMain.TabControlChange(Sender: TObject);
begin
  Try
    racuna_do_st:=StrToInt(edtRacunajDo.Text);
    cas_racunanja_enega_st:=StrToInt(edtCasRacunanja.Text);
    nakljucni_nn_clen:=swcPoljubniNeznanClen.IsChecked;
    SaveIni();
  Except

  End;
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
    Inc(neodgovorjeno);
    labCas.Text:='ŽAL SE JE TVOJ ČAS IZTEKEL!';
    IzpisiRezultate();
    IzberiNalogo();
  end;
end;


procedure TfrmMain.IzberiNalogo();
var
  st1, st2,rez, oper: Integer;
  nnClen: Integer;
  tmp: Integer;
begin
  PocistiPolja();   // počisti polja
  cas:=cas_racunanja_enega_st;      // ponastavi čas
  labCas.Text:=IntToStr(cas) + ' s';
  rez:=0;
  Randomize;
  st1:=Random(racuna_do_st + 1);
  st2:=Random(racuna_do_st+1-st1);
  oper:=Random(2);    // 0=+; 1=-
  nnClen:=Random(3); // 0=prvi člen, 1=drugi člen, 2=tretji člen
  case oper of
    0:
    begin
      labOperator.Text:='+';
      rez:=st1+st2;
    end;
    1:
    begin
      labOperator.Text:='-';
      if (st1<st2) then  // zamenjaj prvo in drugo številko (da vedno odšteješ večjega od manjšega
      begin
        tmp:=st1;
        st1:=st2;
        st2:=Tmp;
      end;
      rez:=st1-st2;
    end;
  end;

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
  PredvajajAnimacijo('razmisljam');
  tmrCasRacunanja.Enabled:=True;
end;

procedure TfrmMain.IzpisiRezultate();
begin
  labRezultat.Text:='PRAVILNO: ' + IntToStr(pravilno) + ', NAPAČNO: ' + IntToStr(napacno) + ', ' + 'NEODGOVORJENO: ' + IntToStr(neodgovorjeno);
end;

procedure TfrmMain.tmrPavzaTimer(Sender: TObject);
begin
  tmrPavza.Enabled:=False;
  layRacunaj.Enabled:=True;
  IzberiNalogo();
end;


procedure TfrmMain.NastaviVnosnaPolja(polje: TEdit; zaklenjeno: Boolean);
begin
  polje.CanFocus:=NOT zaklenjeno;
  polje.ReadOnly:=zaklenjeno;
  if NOT zaklenjeno then
    polje.SetFocus;
end;




end.
