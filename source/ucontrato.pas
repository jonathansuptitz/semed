unit ucontrato;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, LR_Class, LR_DBSet, LR_Desgn, lr_e_pdf,
  Forms, Controls, Graphics, Dialogs, Buttons, ExtCtrls, DbCtrls, StdCtrls,
  EditBtn, Calendar, DBGrids, Grids, ZDataset;

type

  { TfrmContrato }

  TfrmContrato = class(TForm)
    btnlimparlocais: TBitBtn;
    Btnadicionalocal: TBitBtn;
    BtnGerarcontrato: TBitBtn;
    BtnVoltar: TBitBtn;
    DBBoxCargo: TDBLookupComboBox;
    DBBoxlocal: TComboBox;
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
    Panel1: TPanel;
    Panelprincipal: TPanel;
    PanelBotoes: TPanel;
    btnBuscarpessoa: TSpeedButton;
    RadioGroup1: TRadioGroup;
    Radiomanha: TRadioButton;
    Radionoite: TRadioButton;
    Radiotarde: TRadioButton;
    StringGrid1: TStringGrid;
    procedure BtnadicionalocalClick(Sender: TObject);
    procedure BtnGerarcontratoClick(Sender: TObject);
    procedure btnlimparlocaisClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure DBBoxlocalChange(Sender: TObject);
    procedure DBBoxlocalChangeBounds(Sender: TObject);
    procedure DBBoxlocalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnBuscarpessoaClick(Sender: TObject);
    procedure frReport1GetValue(const ParName: String; var ParValue: Variant);
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

var
  linhas, numlocal: integer;

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

procedure TfrmContrato.FormCreate(Sender: TObject);
begin

end;

procedure TfrmContrato.BtnGerarcontratoClick(Sender: TObject);
begin
  dsContratos.DataSet.Filter := 'codigo_contrato = ' + DBEdtCodcontrato.text;
  dsContratos.DataSet.Filtered := true;

  if not(dsContratos.DataSet.FieldCount = 0) then
  begin

    if not((DBEdtJornada.text = '') or (DBEdtCodcontrato.text = '') or
          (DBEdtAnoseletivo.text = '') or (DBEdtJornada.text = '') or
          (DBEdtFuncionario.text = '')) then
    begin
      try
        //adiciona demais campos tabela contrato
        dsContratos.DataSet.FieldByName('periodo_inicial_contrato').Value := DateEditinicial.Text;
        dsContratos.DataSet.FieldByName('periodo_final_contrato').Value := DateEditinicial.Text;
        dsContratos.DataSet.FieldByName('data_contrato').Value := FormatDateTime('dd/mm/yyyy', Date);
        dsContratos.DataSet.FieldByName('salario_contrato').Value := dscargos.DataSet.FieldByName('salario_hora_cargo').value;

        dsContratos.DataSet.Post; //posta
      finally
        Application.ProcessMessages;

        frReport1.LoadFromFile('contrato.lrf');//carrega o contrato padrão

        frReport1.PrepareReport;//prepara o contrato

        // salva em pdf
        //frReport1.SavePreparedReport('contrato' + dsContratos.DataSet.FieldByName('codigo_contrato').Value + '.pdf');

        frReport1.ShowPreparedReport;//exibi preview do contrato
      end;
    end
    else
      ShowMessage('Preencha todos os campos!');
  end;
end;

procedure TfrmContrato.btnlimparlocaisClick(Sender: TObject);
begin
  StringGrid1.Clean(0,1,1,3,[gznormal]);
end;

procedure TfrmContrato.BtnadicionalocalClick(Sender: TObject);
begin
  //adiociona mais locais de trabalho
  StringGrid1.Cells[0,linhas] := DBBoxlocal.text;
  StringGrid1.Cells[1,linhas] := DBEdthorario.text;

  if linhas = 3 then
    linhas := 1
  else
    inc(linhas);

  inc(numlocal);
end;

procedure TfrmContrato.FormShow(Sender: TObject);
var
  i: integer;
begin
  //ativa query e coloca em mode de inserção
  dsContratos.DataSet.Active := true;
  linhas := 1;
  numlocal := 0;

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

procedure TfrmContrato.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
  if ParName = 'Varhora' then
  begin
    if numlocal = 1 then
      ParValue := 'Horario: ' + StringGrid1.Cells[1,1]
    else if numlocal = 2 then
      ParValue := 'Horario: ' + StringGrid1.Cells[1,1] +', '+ StringGrid1.Cells[1,2]
    else if numlocal = 2 then
      ParValue := 'Horario: ' + StringGrid1.Cells[1,1] +', '
      + StringGrid1.Cells[1,2] + ', ' + StringGrid1.Cells[1,3];
  end;
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

