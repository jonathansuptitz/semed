unit ucontrato;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, LR_Class, LR_DBSet, LR_Desgn, lr_e_pdf,
  Forms, Controls, Graphics, Dialogs, Buttons, ExtCtrls, DbCtrls, StdCtrls,
  EditBtn, Calendar, DBGrids, ZDataset;

type

  { TfrmContrato }

  TfrmContrato = class(TForm)
    BtnGerarcontrato: TBitBtn;
    BtnVoltar: TBitBtn;
    DBBoxlocal: TComboBox;
    DBBoxCargo: TDBLookupComboBox;
    DBEdthorario: TDBEdit;
    DBGrid1: TDBGrid;
    dspessoa: TDatasource;
    dslocal: TDatasource;
    dscargos: TDatasource;
    DBEdtJornada: TDBEdit;
    DBEdtFuncionario: TDBEdit;
    DBEdtAnoseletivo: TDBEdit;
    DBMemo2: TDBMemo;
    dsContratos: TDatasource;
    DateEditfinal: TDateEdit;
    DateEditinicial: TDateEdit;
    DBEdtCodcontrato: TDBEdit;
    DBMemo1: TDBMemo;
    frDBDataSet1: TfrDBDataSet;
    frDesigner1: TfrDesigner;
    frReport1: TfrReport;
    frTNPDFExport1: TfrTNPDFExport;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panelprincipal: TPanel;
    PanelBotoes: TPanel;
    btnBuscarpessoa: TSpeedButton;
    Radiomanha: TRadioButton;
    RadioGroup1: TRadioGroup;
    Radionoite: TRadioButton;
    Radiotarde: TRadioButton;
    procedure BtnGerarcontratoClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure DBBoxlocalChange(Sender: TObject);
    procedure DBBoxlocalChangeBounds(Sender: TObject);
    procedure DBBoxlocalClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnBuscarpessoaClick(Sender: TObject);
    procedure RadiomanhaChange(Sender: TObject);
    procedure RadionoiteChange(Sender: TObject);
    procedure RadiotardeChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmContrato: TfrmContrato;

implementation
uses
  uPesquisaPessoas;

{$R *.lfm}

{ TfrmContrato }

procedure TfrmContrato.BtnVoltarClick(Sender: TObject);
begin
  close;
end;

procedure TfrmContrato.DBBoxlocalChange(Sender: TObject);
begin
  dslocal.DataSet.Filter:= 'nome_local_trabalho = '''+ DBBoxlocal.Text + '''';
  dslocal.DataSet.Filtered := true;
end;

procedure TfrmContrato.DBBoxlocalChangeBounds(Sender: TObject);
begin

end ;

procedure TfrmContrato.DBBoxlocalClick(Sender: TObject);
begin
      dslocal.DataSet.Filtered := false;
end;

procedure TfrmContrato.BtnGerarcontratoClick(Sender: TObject);
begin
  if not((DBEdtJornada.text = '') or (DBEdtCodcontrato.text = '') or
        (DBEdtAnoseletivo.text = '') or (DBEdtJornada.text = '') or
        (DBEdtFuncionario.text = '')) then
  begin

    //adiciona demais campos tabela contrato
    dsContratos.DataSet.FieldByName('codigo_cargo').Value := dscargos.DataSet.FieldByName('codigo_cargo').value;
    dsContratos.DataSet.FieldByName('periodo_inicial_contrato').Value := DateEditinicial.Text;
    dsContratos.DataSet.FieldByName('periodo_final_contrato').Value := DateEditinicial.Text;
    dsContratos.DataSet.FieldByName('data_contrato').Value := FormatDateTime('yyyy', Date);
    dsContratos.DataSet.FieldByName('salario_contrato').Value := dscargos.DataSet.FieldByName('salario_hora_cargo').value;
    dsContratos.DataSet.Post; //posta

    frReport1.LoadFromFile('contrato.lrf');//carrega o contrato padrão

    frReport1.PrepareReport;//prepara o contrato

    // salva em pdf
    //frReport1.SavePreparedReport('contrato' + dsContratos.DataSet.FieldByName('codigo_contrato').Value + '.pdf');
    frReport1.ShowPreparedReport;//exibi preview do contrato
  end
  else
    Raise Exception.Create('Preencha todos os campos!');
end;

procedure TfrmContrato.FormShow(Sender: TObject);
var
  i: integer;
begin
  //ativa query e coloca em mode de inserção
  dsContratos.DataSet.Active := true;

  //prenche combobox local
  begin
    DBBoxlocal.Clear;
    dslocal.DataSet.First;
    for i:= 1 to dslocal.DataSet.RecordCount do
    begin
      DBBoxlocal.Items.Add(dslocal.DataSet.FieldByName('nome_local_trabalho').value);
      dslocal.DataSet.Next;
    end;
  end;

  //preenche combo box cargos
  begin
    DBBoxCargo.Clear;
    dscargos.DataSet.First;
    for i := 1 to dscargos.DataSet.RecordCount do
    begin
      DBBoxcargo.Items.Add(dscargos.DataSet.FieldByName('nome_cargo').value);
      dscargos.DataSet.Next;
    end;
  end;

  dsContratos.DataSet.Insert;
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

end.

