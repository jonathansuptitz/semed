unit ucontrato;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Ipfilebroker, IpHtml, LR_Class, LR_DBSet,
  LR_Desgn, lr_e_pdf, Forms, Controls, Graphics, Dialogs, Buttons, ExtCtrls,
  DbCtrls, StdCtrls, EditBtn, Grids;

type

  { TfrmContrato }

  TfrmContrato = class(TForm)
    btnlimparlocais: TBitBtn;
    Btnadicionalocal: TBitBtn;
    BtnGerarcontrato: TBitBtn;
    BtnVoltar: TBitBtn;
    Datasource1: TDatasource;
    DBEdtcargo: TDBEdit;
    DBEdtcpftest2: TDBEdit;
    DBEdtcpfteste1: TDBEdit;
    DBEdttest2: TDBEdit;
    DBEdtteste1: TDBEdit;
    dscidades: TDatasource;
    DBEdthorario: TDBEdit;
    dspessoa: TDatasource;
    dslocal: TDatasource;
    dscargos: TDatasource;
    DBEdtJornada: TDBEdit;
    DBEdtFuncionario: TDBEdit;
    DBEdtAnoseletivo: TDBEdit;
    DBMemovacancia: TDBMemo;
    dsContratos: TDatasource;
    DateEditfinal: TDateEdit;
    DateEditinicial: TDateEdit;
    DBEdtCodcontrato: TDBEdit;
    DBMemoobs: TDBMemo;
    edtlocal: TEdit;
    frDBDataSet1: TfrDBDataSet;
    frDesigner1: TfrDesigner;
    frReport1: TfrReport;
    frTNPDFExport1: TfrTNPDFExport;
    IpFileDataProvider1: TIpFileDataProvider;
    IpHtmlPanel1: TIpHtmlPanel;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panelprincipal: TPanel;
    PanelBotoes: TPanel;
    btnBuscarpessoa: TSpeedButton;
    RadioGroup1: TRadioGroup;
    Radiomanha: TRadioButton;
    Radionoite: TRadioButton;
    Radiotarde: TRadioButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    StringGrid1: TStringGrid;
    procedure editahtml;
    procedure BtnadicionalocalClick(Sender: TObject);
    procedure BtnGerarcontratoClick(Sender: TObject);
    procedure btnlimparlocaisClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnBuscarpessoaClick(Sender: TObject);
    procedure frReport1GetValue(const ParName: String; var ParValue: Variant);
    procedure PanelprincipalClick(Sender: TObject);
    procedure RadiomanhaChange(Sender: TObject);
    procedure RadionoiteChange(Sender: TObject);
    procedure RadiotardeChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmContrato: TfrmContrato;

implementation
uses
  uPesquisaPessoas,UCadastroLocalTrabalho, uCadastroCargos;

var
  linhas, numlocal: integer;

{$R *.lfm}

{ TfrmContrato }

procedure TfrmContrato.BtnVoltarClick(Sender: TObject);
begin
  close;
end;

procedure TfrmContrato.BtnGerarcontratoClick(Sender: TObject);
begin
    if not((DBEdtJornada.text = '') or (DBEdtCodcontrato.text = '') or
          (DBEdtAnoseletivo.text = '') or (DBEdtJornada.text = '') or
          (DBEdtFuncionario.text = '')) then
    begin
      try
        //adiciona demais campos tabela contrato
        dsContratos.DataSet.FieldByName('periodo_inicial_contrato').Value := DateEditinicial.Text;
        dsContratos.DataSet.FieldByName('periodo_final_contrato').Value := DateEditfinal.Text;
        dsContratos.DataSet.FieldByName('data_contrato').Value := FormatDateTime('dd/mm/yyyy', Date);
        dsContratos.DataSet.FieldByName('salario_contrato').Value := dscargos.DataSet.FieldByName('salario_hora_cargo').value;

        dsContratos.DataSet.Post; //posta
      finally
        editahtml; //chama o preenchimento do html
      end;
    end
    else
      ShowMessage('Preencha todos os campos!');
end;

procedure TfrmContrato.btnlimparlocaisClick(Sender: TObject);
begin
  StringGrid1.Clean(0,1,1,3,[gznormal]);
  numlocal := 0;
end;

procedure TfrmContrato.BtnadicionalocalClick(Sender: TObject);
begin
  //adiociona mais locais de trabalho
  StringGrid1.Cells[0,linhas] := edtlocal.text;
  StringGrid1.Cells[1,linhas] := DBEdthorario.text;

  if linhas = 3 then
    linhas := 1
  else
    inc(linhas);

  inc(numlocal);
end;

procedure TfrmContrato.FormShow(Sender: TObject);
begin
  //ativa query e coloca em mode de inserção
  dsContratos.DataSet.Active := true;

  //para varios locais
  linhas := 1;
  numlocal := 0;
  //--

  dsContratos.DataSet.Insert;//contro em modo de insecao
end;

procedure TfrmContrato.btnBuscarpessoaClick(Sender: TObject);
begin
  //chama a pesquisa de pessoa
  Application.CreateForm(TfrmPesquisaPessoas, frmPesquisaPessoas);
  frmPesquisaPessoas.showmodal;
  frmPesquisaPessoas.free;

  //filtra o dspessoa para o contrato
  dspessoa.DataSet.Filter := 'codigo_pessoa = ''' + DBEdtFuncionario.text + '''';
  dspessoa.DataSet.Filtered := true;
end;

procedure TfrmContrato.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
  if ParName = 'Varhora' then
  begin
    if numlocal = 1 then
      ParValue := StringGrid1.Cells[1,1]
    else if numlocal = 2 then
      ParValue := StringGrid1.Cells[1,1] +', '+ StringGrid1.Cells[1,2]
    else if numlocal = 3 then
      ParValue := StringGrid1.Cells[1,1] +', '+ StringGrid1.Cells[1,2]
      + ', ' + StringGrid1.Cells[1,3];
  end;
  if ParName = 'Varobs' then
  begin
    ParValue:= '                                                             ' +
    '                                                                        ' +
    '                                                                        ' +
    '                                                                        ';
  end;
  if ParName = 'Varlocais' then
  begin
    if numlocal = 1 then
      ParValue := StringGrid1.Cells[0,1]
    else if numlocal = 2 then
      ParValue := StringGrid1.Cells[0,1] +', '+ StringGrid1.Cells[0,2]
    else if numlocal = 3 then
      ParValue := StringGrid1.Cells[0,1] +', '+ StringGrid1.Cells[0,2]
      + ', ' + StringGrid1.Cells[0,3];
  end;
end;

procedure TfrmContrato.PanelprincipalClick(Sender: TObject);
begin

end;

procedure TfrmContrato.RadiomanhaChange(Sender: TObject);
begin
    if Radiomanha.Checked then
      DBedtHorario.DataField:= 'horario_matutino_trabalho';
end;

procedure TfrmContrato.RadionoiteChange(Sender: TObject);
begin
    if Radionoite.Checked then
      DBedtHorario.DataField:= 'horario_noturno_trabalho';
end;

procedure TfrmContrato.RadiotardeChange(Sender: TObject);
begin
    if Radiotarde.Checked then
      DBedtHorario.DataField:= 'horario_vespertino_trabalho';
end;

procedure TfrmContrato.SpeedButton1Click(Sender: TObject);
begin
   //chama a pesquisa de cargo
  Application.CreateForm(TfrmCadastroCargos, frmCadastroCargos);
  frmCadastroCargos.showmodal;
  frmCadastroCargos.free;

  //filtra o dscargo para o contrato
  dscargos.DataSet.Filter := 'codigo_cargo = ''' + DBEdtcargo.text + '''';
  dscargos.DataSet.Filtered := true;
end;

procedure TfrmContrato.SpeedButton2Click(Sender: TObject);
begin
  //chama a pesquisa de local
  Application.CreateForm(TfrmCadastroLocalTrabalho, frmCadastroLocalTrabalho);
  frmCadastroLocalTrabalho.showmodal;
  frmCadastroLocalTrabalho.free;

  //filtra o dslocal para o contrato
  dslocal.DataSet.Filter := 'nome_local = ''' + edtlocal.text + '''';
  dslocal.DataSet.Filtered := true;
end;


//prenche contrato em html
procedure TfrmContrato.editahtml;
var
  texto : TStringList;
  pstl : string;
  y : integer;
begin
  try
    texto := TStringList.Create;
    texto.LoadFromFile('contrato.html');
    for y := 0 to texto.Count-1 do
    begin
      pstl := texto[y];
      texto[y] := StringReplace(pstl,'varnome',dspessoa.DataSet.FieldByName('nome_pessoa').value,[rfIgnoreCase,rfReplaceAll]);
    end;
    texto.SaveToFile('contratoteste.html');
    //IpHtmlPanel1.OpenURL(ExpandLocalHtmlFileName('contratoteste.html'));
  finally
    texto.Free;
  end;
end;

end.

