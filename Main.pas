unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.DateTimeCtrls, FMX.ListBox, FMX.Layouts, System.ImageList, FMX.ImgList,
  FMX.Objects, FMX.Edit, FMX.Controls.Presentation, FMX.TabControl,
  SharedUnit, FMX.GifUtils, System.DateUtils, FMX.ScrollBox, FMX.Memo,
  System.IOUtils, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, System.Rtti, FMX.Grid.Style,
  FMX.Grid;

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
    labCasRacunanja: TLabel;
    swcPoljubniNeznanClen: TSwitch;
    labPoljubniNeznanClen: TLabel;
    labNapis: TLabel;
    tmrCasRacunanja: TTimer;
    edtCasRacunanja: TEdit;
    labS: TLabel;
    tbiRezultati: TTabItem;
    memRezultati: TMemo;
    tmrPavza: TTimer;
    tbiUrejevalnikAnimacij: TTabItem;
    Layout1: TLayout;
    layDatoteke: TLayout;
    imgUrejevalnikAnimacij: TImage;
    libMape: TListBox;
    cobMape: TComboBox;
    livDatoteke: TListView;
    btnDodajAnimacijo: TButton;
    lbiVklopiCas: TListBoxItem;
    labVklopiCasRacunanja: TLabel;
    swcVklopiCasRacunanja: TSwitch;
    stgRezultati: TStringGrid;
    stcLabela: TStringColumn;
    stcPrviNNClen: TStringColumn;
    stcDrugiNNClen: TStringColumn;
    stcTretjiNNClen: TStringColumn;
    Splitter: TSplitter;
    stcPovpCas: TStringColumn;
    lbiOperacije: TListBoxItem;
    cobOperacije: TComboBox;
    labOperacije: TLabel;
    procedure TabControlChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIzhodClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure edtDrugoStKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure btnPreveriClick(Sender: TObject);
    procedure tmrCasRacunanjaTimer(Sender: TObject);
    procedure tmrPavzaTimer(Sender: TObject);
    procedure cobMapeChange(Sender: TObject);
    procedure livDatotekeChange(Sender: TObject);
    procedure livDatotekeItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure edtRacunajDoExit(Sender: TObject);
    procedure swcVklopiCasRacunanjaClick(Sender: TObject);
  private
    { Private declarations }
    cas: Integer;
    nnClen: Integer;  // neznani ćlen, 0=prvi člen, 1=drugi člen, 2=tretji člen
    oper: Integer;    // operator 0=+; 1=-
    pravilno, napacno, neodgovorjeno: Integer;
    // rezultat[pravilno/napačno/potekel čas, plus/minus/krat/deljeno, prvi/drugi/tretji neznani člen
    rezultati: array[0..2, 0..3, 0..2] of Integer;
    //pravilno plus, pravilno minus, pravilno krat, pravilno deljeno, napačni plus, napačni minus, napačno krat, napačno deljeno,
    //neodgovorjen plus, neodgovorjen minus, neodgovorjeno krat, neodgovorjeno deljeno
    povprecen_cas: array[0..11] of Integer;
    FGifPlayer: TGifPlayer;
    FGifPlayerUrejevalnik: TGifPlayer;
    cas_zacetka: TDateTime;
    napaka, odlicno, razmisljam: TStringList;
    pravilni_izracun: String;
    function PreveriRezultat():Boolean;
    procedure PonastaviRezultate();
    procedure IzpisiRezultate();
    procedure IzberiNalogo();
    procedure NastaviVnosnaPolja(polje: TEdit; zaklenjeno: Boolean);
    procedure PocistiPolja();
    procedure PredvajajAnimacijo(animacija: String; seznam: TStringList);
    procedure NapolniSeznamDatotek(mapa: String;var seznam: TStringList);
    procedure NapolniListoDatotek();
    procedure ShraniNastavitve();
    procedure ZacniIgro();
    procedure KoncajIgro();
    procedure PavzirajIgro();
    procedure NadaljujZIgro();
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;


implementation

{$R *.fmx}

uses System.Math, System.Generics.Collections;

{ TfrmManin }

procedure TfrmMain.btnIzhodClick(Sender: TObject);
begin
  // Zapri aplikacijo
  Application.Terminate;
end;

procedure TfrmMain.btnPreveriClick(Sender: TObject);
begin
  // preveri rezultate
  // rezultat[pravilno/napačno/potekel čas, plus/minus, prvi/drugi/tretji neznani člen
  layRacunaj.Enabled:=False;
  if PreveriRezultat() then   // če je odgovor je pravilen
  begin
     labCas.Text:='BRAVO !!!';
     Inc(pravilno);
     rezultati[0, oper, nnClen]:=rezultati[0, oper, nnClen] + 1;
     povprecen_cas[oper]:=povprecen_cas[oper] + (cas_racunanja_enega_st-cas);
     PredvajajAnimacijo('odlicno', odlicno);
  end else                    // odgovor je napačen
  begin
    labCas.Text:=':-( Pravilno je ' + pravilni_izracun + ' )';
    Inc(napacno);
    rezultati[1, oper, nnClen]:=rezultati[1, oper, nnClen] + 1;
    povprecen_cas[2+oper]:=povprecen_cas[2+oper] + (cas_racunanja_enega_st-cas);
    PredvajajAnimacijo('napaka', napaka);
  end;
  IzpisiRezultate();
  tmrPavza.Enabled:=True;
end;

procedure TfrmMain.btnStartClick(Sender: TObject);
begin
  if btnStart.ImageIndex=1 then // začni igro
  begin
    ZacniIgro();
  end else    // končaj igro
  begin
    KoncajIgro();
  end;
end;

procedure TfrmMain.ZacniIgro();
begin
    btnStart.ImageIndex:=2;
    cas_zacetka:=Now;
    layRacunaj.Enabled:=True;
    PocistiPolja();
    PonastaviRezultate();
    IzpisiRezultate();
    IzberiNalogo();
end;

procedure TfrmMain.KoncajIgro();
var
  skupen_cas: Integer;
begin
    FGifPlayer.stop;
    imgAnimacija.Visible:=False;
    btnStart.ImageIndex:=1;
    tmrCasRacunanja.Enabled:=False;
    tmrPavza.Enabled:=False;
    skupen_cas:=SecondsBetween(Now, cas_zacetka);
    PocistiPolja();
    labCas.Text:='';
    layRacunaj.Enabled:=False;
    // rezultat[pravilno/napačno/potekel čas, plus/minus, prvi/drugi/tretji neznani člen
    // rezultat[pravilno/napačno/potekel čas, plus/minus/krat/deljeno, prvi/drugi/tretji neznani člen
    stgRezultati.Cells[0,0]:='Pravilni Plus';
    stgRezultati.Cells[1,0]:=IntToStr(rezultati[0,0,0]);  // pravilni,plus,prvi nn člen
    stgRezultati.Cells[2,0]:=IntToStr(rezultati[0,0,1]);  // pravilni,plus,drugi nn člen
    stgRezultati.Cells[3,0]:=IntToStr(rezultati[0,0,2]);  // pravilni,plus,tretji nn člen
    stgRezultati.Cells[4,0]:=FloatToStr(povprecen_cas[0]/(rezultati[0,0,0] + rezultati[0,0,1] + rezultati[0,0,2]));
    stgRezultati.Cells[0,1]:='Pravilni Minus';
    stgRezultati.Cells[1,1]:=IntToStr(rezultati[0,1,0]);  // pravilni,minus,prvi nn člen
    stgRezultati.Cells[2,1]:=IntToStr(rezultati[0,1,1]);  // pravilni,minus,drugi nn člen
    stgRezultati.Cells[3,1]:=IntToStr(rezultati[0,1,2]);  // pravilni,minus,tretji nn člen
    stgRezultati.Cells[4,1]:=FloatToStr(povprecen_cas[1]/(rezultati[0,1,0] + rezultati[0,1,1] + rezultati[0,1,2]));
    stgRezultati.Cells[0,2]:='Pravilni Krat';
    stgRezultati.Cells[1,2]:=IntToStr(rezultati[0,2,0]);  // pravilni,krat,prvi nn člen
    stgRezultati.Cells[2,2]:=IntToStr(rezultati[0,2,1]);  // pravilni,krat,drugi nn člen
    stgRezultati.Cells[3,2]:=IntToStr(rezultati[0,2,2]);  // pravilni,krat,tretji nn člen
    stgRezultati.Cells[4,2]:=FloatToStr(povprecen_cas[2]/(rezultati[0,2,0] + rezultati[0,2,1] + rezultati[0,2,2]));
    stgRezultati.Cells[0,3]:='Pravilni Deljeno';
    stgRezultati.Cells[1,3]:=IntToStr(rezultati[0,3,0]);  // pravilni,deljeno,prvi nn člen
    stgRezultati.Cells[2,3]:=IntToStr(rezultati[0,3,1]);  // pravilni,deljeno,drugi nn člen
    stgRezultati.Cells[3,3]:=IntToStr(rezultati[0,3,2]);  // pravilni,deljeno,tretji nn člen
    stgRezultati.Cells[4,3]:=FloatToStr(povprecen_cas[3]/(rezultati[0,3,0] + rezultati[0,3,1] + rezultati[0,3,2]));
    stgRezultati.Cells[0,4]:='Napačno Plus';
    stgRezultati.Cells[1,4]:=IntToStr(rezultati[1,0,0]);  // napačni,plus,prvi nn člen
    stgRezultati.Cells[2,4]:=IntToStr(rezultati[1,0,1]);  // napačni,plus,drugi nn člen
    stgRezultati.Cells[3,4]:=IntToStr(rezultati[1,0,2]);  // napačni,plus,tretji nn člen
    stgRezultati.Cells[4,4]:=FloatToStr(povprecen_cas[4]/(rezultati[1,0,0] + rezultati[1,0,1] + rezultati[1,0,2]));
    stgRezultati.Cells[0,5]:='Napačno Minus';
    stgRezultati.Cells[1,5]:=IntToStr(rezultati[1,1,0]);  // napačni,minus,prvi nn člen
    stgRezultati.Cells[2,5]:=IntToStr(rezultati[1,1,1]);  // napačni,minus,drugi nn člen
    stgRezultati.Cells[3,5]:=IntToStr(rezultati[1,1,2]);  // napačni,minus,tretji nn člen
    stgRezultati.Cells[4,5]:=FloatToStr(povprecen_cas[5]/(rezultati[1,1,0] + rezultati[1,1,1] + rezultati[1,1,2]));
    stgRezultati.Cells[0,6]:='Napačno Krat';
    stgRezultati.Cells[1,6]:=IntToStr(rezultati[1,2,0]);  // napačni,krat,prvi nn člen
    stgRezultati.Cells[2,6]:=IntToStr(rezultati[1,2,1]);  // napačni,krat,drugi nn člen
    stgRezultati.Cells[3,6]:=IntToStr(rezultati[1,2,2]);  // napačni,krat,tretji nn člen
    stgRezultati.Cells[4,6]:=FloatToStr(povprecen_cas[6]/(rezultati[1,2,0] + rezultati[1,2,1] + rezultati[1,2,2]));
    stgRezultati.Cells[0,7]:='Napačno Deljeno';
    stgRezultati.Cells[1,7]:=IntToStr(rezultati[1,3,0]);  // napačni,deljeno,prvi nn člen
    stgRezultati.Cells[2,7]:=IntToStr(rezultati[1,3,1]);  // napačni,deljeno,drugi nn člen
    stgRezultati.Cells[3,7]:=IntToStr(rezultati[1,3,2]);  // napačni,deljeno,tretji nn člen
    stgRezultati.Cells[4,7]:=FloatToStr(povprecen_cas[7]/(rezultati[1,3,0] + rezultati[1,3,1] + rezultati[1,3,2]));
    stgRezultati.Cells[0,8]:='Neodgovorjeno Plus';
    stgRezultati.Cells[1,8]:=IntToStr(rezultati[2,0,0]);  // neodgovorjeni,plus,prvi nn člen
    stgRezultati.Cells[2,8]:=IntToStr(rezultati[2,0,1]);  // neodgovorjeni,plus,drugi nn člen
    stgRezultati.Cells[3,8]:=IntToStr(rezultati[2,0,2]);  // neodgovorjeni,plus,tretji nn člen
    stgRezultati.Cells[4,8]:=FloatToStr(povprecen_cas[8]/(rezultati[2,0,0] + rezultati[1,0,1] + rezultati[2,0,2]));
    stgRezultati.Cells[0,9]:='Neodgovorjeno Minus';
    stgRezultati.Cells[1,9]:=IntToStr(rezultati[2,1,0]);  // neodgovorjeni,minus,prvi nn člen
    stgRezultati.Cells[2,9]:=IntToStr(rezultati[2,1,1]);  // neodgovorjeni,minus,drugi nn člen
    stgRezultati.Cells[3,9]:=IntToStr(rezultati[2,1,2]);  // neodgovorjeni,minus,tretji nn člen
    stgRezultati.Cells[4,9]:=FloatToStr(povprecen_cas[9]/(rezultati[2,1,0] + rezultati[2,1,1] + rezultati[2,1,2]));

    stgRezultati.Cells[0,10]:='Neodgovorjeno Krat';
    stgRezultati.Cells[1,10]:=IntToStr(rezultati[2,2,0]);  // neodgovorjeni,plus,prvi nn člen
    stgRezultati.Cells[2,10]:=IntToStr(rezultati[2,2,1]);  // neodgovorjeni,plus,drugi nn člen
    stgRezultati.Cells[3,10]:=IntToStr(rezultati[2,2,2]);  // neodgovorjeni,plus,tretji nn člen
    stgRezultati.Cells[4,10]:=FloatToStr(povprecen_cas[10]/(rezultati[2,2,0] + rezultati[1,2,1] + rezultati[2,2,2]));
    stgRezultati.Cells[0,11]:='Neodgovorjeno Deljeno';
    stgRezultati.Cells[1,11]:=IntToStr(rezultati[2,3,0]);  // neodgovorjeni,minus,prvi nn člen
    stgRezultati.Cells[2,11]:=IntToStr(rezultati[2,3,1]);  // neodgovorjeni,minus,drugi nn člen
    stgRezultati.Cells[3,11]:=IntToStr(rezultati[2,3,2]);  // neodgovorjeni,minus,tretji nn člen
    stgRezultati.Cells[4,11]:=FloatToStr(povprecen_cas[11]/(rezultati[2,3,0] + rezultati[2,3,1] + rezultati[2,3,2]));

    memRezultati.Lines.Add(DateTimeToStr(Now) + ' ; čas reševanje=' + IntToStr(skupen_cas) + ' sec ; pravilnih=' + IntToSTr(pravilno) +
                            '; napačnih=' + IntToStr(napacno) + '; neodgovorjenih=' +
                            IntToSTr(neodgovorjeno));
end;

procedure TfrmMain.PavzirajIgro();
begin
  if (FGifPlayer<>nil) then
  begin
    if (FGifPlayer.IsPlaying)  then
      FGifPlayer.stop;
  end;
  tmrCasRacunanja.Enabled:=False;
end;

procedure TfrmMain.NadaljujZIgro();
begin
  if FGifPlayer<>nil then
    FGifPlayer.Play;
  if swcVklopiCasRacunanja.IsChecked then
    tmrCasRacunanja.Enabled:=True;
end;

procedure TfrmMain.edtDrugoStKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key=vkReturn then
    btnPreveriClick(Self);
end;

procedure TfrmMain.edtRacunajDoExit(Sender: TObject);
begin
  // Shrani nastavitve v System.ini
  ShraniNastavitve();
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  cas_zacetka:=0;
  PonastaviRezultate();
  TabControl.TabIndex:=0;
  ReadIni();
  edtRacunajDo.Text:=IntToStr(racuna_do_st);
  edtCasRacunanja.Text:=IntToStr(cas_racunanja_enega_st);
  swcPoljubniNeznanClen.IsChecked:=nakljucni_nn_clen;
  swcVklopiCasRacunanja.IsChecked:=vklopi_cas_racunanja;
  lbiCasRacunanja.Enabled:=swcVklopiCasRacunanja.IsChecked;
  cobOperacije.ItemIndex:=operacije;
  cas:=cas_racunanja_enega_st;
  try
    FGifPlayer := TGifPlayer.Create(Self);
    FGifPlayer.Image := imgAnimacija;
    FGifPlayerUrejevalnik:=TGifPlayer.Create(Self);
    FGifPlayerUrejevalnik.Image:=imgUrejevalnikAnimacij;
    livDatoteke.Items.Clear;
    napaka:=TStringList.Create;
    odlicno:=TStringList.Create;
    razmisljam:=TStringList.Create;
    NapolniSeznamDatotek('napaka', napaka);      //napaka, odlicno, razmisljam
    NapolniSeznamDatotek('odlicno', odlicno);
    NapolniSeznamDatotek('razmisljam', razmisljam);
  Except

  end;
  NapolniListoDatotek();
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
var
  i, j, k: Integer;
begin
  pravilno:=0;
  napacno:=0;
  neodgovorjeno:=0;
  // resetiraj števce rezultatov
  for i:=0 to 2 do
    for j:=0 to 1 do
      for k:=0 to 2 do
        rezultati[i, j, k]:=0;
  // resetiraj povprečne čase
  for i:=0 to 5 do
    povprecen_cas[i]:=0;

end;

procedure TfrmMain.PredvajajAnimacijo(animacija: String; seznam: TStringList);
var
  ff, i: Integer;
  path: String;
begin
{ TODO : Odstrani za predvajanje animacije! }
exit;
  // predvajaj animacijo
  path:=TPath.GetDocumentsPath + PathDelim + 'Racunaj' + PathDelim + 'animation' + PathDelim  + animacija + PathDelim;
  ff:=seznam.Count-1;
  i:=Random(ff)+1;
  FGifPlayer.LoadFromFile(seznam[i]);
  imgAnimacija.Visible:=True;
  //FGifPlayer.LoadFromStream();
  FGifPlayer.Play;
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

procedure TfrmMain.ShraniNastavitve();
begin
  Try
    racuna_do_st:=StrToInt(edtRacunajDo.Text);
    cas_racunanja_enega_st:=StrToInt(edtCasRacunanja.Text);
    nakljucni_nn_clen:=swcPoljubniNeznanClen.IsChecked;
    vklopi_cas_racunanja:=swcVklopiCasRacunanja.IsChecked;
    operacije:=cobOperacije.ItemIndex;
    SaveIni();
  Except

  End;
end;

procedure TfrmMain.swcVklopiCasRacunanjaClick(Sender: TObject);
begin
  lbiCasRacunanja.Enabled:=swcVklopiCasRacunanja.IsChecked;
end;

procedure TfrmMain.TabControlChange(Sender: TObject);
begin
  // Če ni izbran urejevalnik animacij, zaustavi animacijo v urejevalniku
  if (TabControl.TabIndex<>3) and (FGifPlayerUrejevalnik<>nil) then
    FGifPlayerUrejevalnik.stop;
  if ((TabControl.TabIndex<>0) and (cas_zacetka>0)) then
    //KoncajIgro();
    PavzirajIgro();
  // Če je bila igra pavzirana jonadaljuj
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
    Inc(neodgovorjeno);
    // rezultat[pravilno/napačno/potekel čas, plus/minus, prvi/drugi/tretji neznani člen
    rezultati[2, oper, nnClen]:=rezultati[2, oper, nnClen] + 1;
    povprecen_cas[4+oper]:=povprecen_cas[4+oper] + cas_racunanja_enega_st;
    labCas.Text:='ŽAL SE JE TVOJ ČAS IZTEKEL! (' + pravilni_izracun + ')';
    layRacunaj.Enabled:=False;
    tmrPavza.Enabled:=True;
    IzpisiRezultate();
  end;
end;


procedure TfrmMain.IzberiNalogo();
var
  st1, st2,rez: Integer;
  tmp: Integer;
  delitelji: TList<Integer>;

  a: Integer;
begin
  try
    delitelji:=TList<Integer>.Create;
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

    case operacije of
      0: oper:=0; // +
      1: oper:=1; //-
      2: oper:=Random(2);    // 0=+; 1=-
      3: oper:=2;            // 2=*
      4: oper:=3;           // /
      5: oper:=RandomRange(2,4);    // 2=*, 3=/
      6: oper:=Random(4); // 0=+, 1=-, 2=*, 3=/
    end;

    case oper of
      0,1:     // za + in -
      begin
        st1:=Random(racuna_do_st + 1);
        st2:=Random(racuna_do_st+1-st1);
      end;
      2:      // za *
      begin
        tmp:=(Floor(Sqrt(racuna_do_st))+1);
        st1:=Random(tmp);
        st2:=Random(tmp);
      end;
      3:    // za /
      begin
        st1:=Random(racuna_do_st) + 1;      // odstrani deljenje z 0
        DeliteljiSt(st1, delitelji);
        a:=Random(delitelji.Count);

        st2:=delitelji.Items[a];
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
        pravilni_izracun:=IntToSTr(st1) + '*' + IntToStr(st2) + '=' + IntToStr(rez);
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
    PredvajajAnimacijo('razmisljam', razmisljam);
    if swcVklopiCasRacunanja.IsChecked then
      tmrCasRacunanja.Enabled:=True;
  finally
    delitelji.Free;
  end;
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

procedure TfrmMain.NapolniSeznamDatotek(mapa: String;var seznam: TStringList);
var
  path, ffile: String;
begin
  path:=TPath.GetDocumentsPath + PathDelim + 'Racunaj' + PathDelim + 'animation' + PathDelim  + mapa + PathDelim;
  For ffile in TDirectory.GetFiles(path)  do
  begin
    seznam.Add(ffile);
  end;
end;


procedure TfrmMain.NapolniListoDatotek();
var
  mapa: TStrings;
  LItem: TListViewItem;
  i: Integer;
begin
  mapa:=napaka;
  // napolni datoteke vsezna ListView
  case cobMape.ItemIndex of       //napaka, odlicno, razmisljam
    0:
      mapa:=napaka;
    1:
      mapa:=odlicno;
    2:
      mapa:=razmisljam;
  end;
  livDatoteke.BeginUpdate;
  for i:=0 to mapa.Count-1 do
  begin
    LItem := livDatoteke.Items.Add;
    LItem.Text := mapa[i];
  end;
  livDatoteke.EndUpdate;
end;


procedure TfrmMain.cobMapeChange(Sender: TObject);
begin
  // ker je bil izbrana druga možnost iz padajočega menija, ustrezno napolni seznam
  livDatoteke.Items.Clear;
  NapolniListoDatotek();
end;


procedure TfrmMain.livDatotekeChange(Sender: TObject);
var
  datoteka: String;
begin
  // če izberemo datoteko, prikaži izbrano animacijo
  FGifPlayerUrejevalnik.stop();
  datoteka:=livDatoteke.Items[livDatoteke.ItemIndex].Text;
  FGifPlayerUrejevalnik.LoadFromFile(datoteka);
  FGifPlayerUrejevalnik.Play();
  imgUrejevalnikAnimacij.Visible:=True;
end;

procedure TfrmMain.livDatotekeItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  datoteka: String;
begin
  // če izberemo datoteko, prikaži izbrano animacijo
  FGifPlayerUrejevalnik.stop();
  datoteka:=AItem.Text;
  FGifPlayerUrejevalnik.LoadFromFile(datoteka);
  FGifPlayerUrejevalnik.Play();
  imgUrejevalnikAnimacij.Visible:=True;
end;

end.
