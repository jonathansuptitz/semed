unit uCadastroCargos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls, DbCtrls, DBGrids, LCLType;

type

  {Quando esse form for chamado por outro por motivo de pesquisa(como buscar o codigo),
   deve-se habilitar o botão "Selecionar", que passa o valor do código para o form
   que o chamou (implementar para cada pesquisa).
   ex: Application.CreateForm(TfrmCadastroCargos, frmCadastroCargos);
       frmCadastroCargos.SelecionarATIVO := true;
       frmCadastroCargos.ShowModal;
       frmCadastroCargos.Free;

   Caso o form seja aberto pela tela
   principal, o SELECIONAR deve permanecer desabilitado}

  { TfrmCadastroCargos }

  TfrmCadastroCargos = class(TForm)
    BtnApagar: TBitBtn;
    BtnCancelar: TBitBtn;
    BtnEditar: TBitBtn;
    BtnNovo: TBitBtn;
    BtnSalvar: TBitBtn;
    BtnSelecionar: TBitBtn;
    BtnVoltar: TBitBtn;
    ComboBox1: TComboBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBGrid1: TDBGrid;
    dsCargos: TDatasource;
    editPesquisa: TEdit;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    memoClau: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BtnApagarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnSelecionarClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure DBEdit1Change(Sender: TObject);
    procedure DBEdit4KeyPress(Sender: TObject; var Key: char);
    procedure DBGrid1Enter(Sender: TObject);
    procedure editPesquisaChange(Sender: TObject);
    procedure editPesquisaKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure EditON;
    procedure EditOFF;
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    SelecionarAtivo: boolean;
  end;

var
  frmCadastroCargos: TfrmCadastroCargos;
  campoBusca, ScreenMode: string;

implementation

uses
  dmMain, ucontrato;

{$R *.lfm}

{ TfrmCadastroCargos }

// INICIO ----------------------------------------------------------------------
procedure TfrmCadastroCargos.FormCreate(Sender: TObject);
begin
  SelecionarAtivo := false;
end;

procedure TfrmCadastroCargos.FormShow(Sender: TObject);
begin
  ScreenMode := 'mdNormal';
  campoBusca := 'nome_cargo';
  EditOFF;
end;

procedure TfrmCadastroCargos.editPesquisaKeyPress(Sender: TObject; var Key: char
  );
begin                                                          // Limpa campo de pesquisa
  if (editPesquisa.Text = 'Digite para pesquisar...') then     // quando usuario começa a
    editPesquisa.Text := '';                                   // digitar
end;

// PREVISAO de ERROS -----------------------------------------------------------

procedure TfrmCadastroCargos.DBEdit4KeyPress(Sender: TObject; var Key: char); //Masc Moeda
begin
  if not (Key in ['0'..'9', chr(8){backspace}, DecimalSeparator]) then
    Key := #0{nil};
end;

procedure TfrmCadastroCargos.DBGrid1Enter(Sender: TObject); // Ao selecionar GRID
begin
  EditOFF;
end;

procedure TfrmCadastroCargos.EditON;        // Habilitar Edição
begin
  DBEdit2.ReadOnly := false;
  DBEdit3.ReadOnly := false;
  DBEdit4.ReadOnly := false;
  memoClau.ReadOnly := false;

  BtnSalvar.Enabled := true;
  BtnCancelar.Enabled := true;
  BtnNovo.Enabled := false;
  BtnEditar.Enabled := false;
  BtnApagar.Enabled := false;
  BtnSelecionar.Enabled := false;
  BtnVoltar.Enabled := false;
end;

procedure TfrmCadastroCargos.EditOFF;       // Desabilitar Edição
begin
  DBEdit2.ReadOnly := true;
  DBEdit3.ReadOnly := true;
  DBEdit4.ReadOnly := true;
  memoClau.ReadOnly := true;

  BtnSalvar.Enabled := false;
  BtnCancelar.Enabled := false;
  BtnNovo.Enabled := true;
  BtnEditar.Enabled := true;
  BtnApagar.Enabled := true;
  BtnVoltar.Enabled := true;
  if SelecionarAtivo then  // Verifica se BtnSelecionar esava ativo inicialmente
    BtnSelecionar.Enabled := true;
end;

// PESQUISA --------------------------------------------------------------------
procedure TfrmCadastroCargos.editPesquisaChange(Sender: TObject);
begin
  if (campoBusca = 'codigo_cargo') then               // Se opção selecionada for código
  begin
    if (Length(editPesquisa.Text) = 0) then             // Se usuario apagar todos os caracteres do campo
      DM1.tb_cargos.Filtered := false                     // Desabilita filtro para evitar erro
    else
    begin                                                 // Senao executa filtro normalmente
      DM1.tb_cargos.Filter := campoBusca+' = '+ editPesquisa.Text;
      DM1.tb_cargos.Filtered := true; {Pesquisa para código apenas com "="}
    end;
  end
  else
  begin                                              // Se opção selecionada for código -> executa filtro normalmente
    DM1.tb_cargos.Filter := campoBusca+' LIKE '+ QuotedStr('*' + editPesquisa.Text + '*');
    DM1.tb_cargos.Filtered := true;
  end;

  EditOFF;
end;

procedure TfrmCadastroCargos.ComboBox1Change(Sender: TObject);
begin
  if (ComboBox1.Text = 'Código') then                // Altera var com o valor do
    campoBusca := 'codigo_cargo'                     // campo a ser pesquisado quando
  else if (ComboBox1.Text = 'Descrição') then        // usuario muda comboBox
    campoBusca := 'nome_cargo'
  else if (ComboBox1.Text = 'Grupo Ocupacional') then
    campoBusca := 'grupo_ocupacional_cargo';

  EditOFF;
end;

// CONTROLE DE CLAUSULA - MEMO -------------------------------------------------
procedure TfrmCadastroCargos.DBEdit1Change(Sender: TObject); // Quando muda registro,
begin                                                        // carrega Clau. prim. para
  memoClau.Lines.Clear;                                      // memo
  if (FileExists('clp/clp'+DBEdit1.Text+'.txt')) then
    if (ScreenMode <> 'mdInsert') then               // Se INSERT nao estiver ativo
      memoClau.Lines.LoadFromFile('clp/clp'+DBEdit1.Text+'.txt')
  else
    ShowMessage('Ocorreu um erro ao carregar Cláusula Primeira!');
end;

// BOTOES ----------------------------------------------------------------------

procedure TfrmCadastroCargos.BtnSelecionarClick(Sender: TObject);   // Selecionar
begin                   // manda o codigo do cargo para o campo corespondente no form de Contratos
  frmContrato.dsContratos.DataSet.FieldByName('codigo_cargo').value := dsCargos.DataSet.FieldByName('codigo_cargo').value;
  Close;
end;

procedure TfrmCadastroCargos.BtnSalvarClick(Sender: TObject);       // Salvar
var
  SLtrans: TStringList;
begin
  if (DBEdit2.Text = '') or (DBEdit3.Text = '') or (DBEdit4.Text = '') or (memoClau.Text = '') then
    ShowMessage('Todos os campos são obrigatorios!')
  else
  begin
    //salva o caminho da clausula no banco
    dsCargos.DataSet.FieldByName('clausula_primeira_cargo').value := 'clp/clp'+DBEdit1.Text+'.txt';

    dsCargos.DataSet.Post;  // Salvar registro

    try
      SLtrans := TStringList.Create;

      SLtrans.Assign(memoClau.Lines);//atribui memo na stringlist

      SLtrans.SaveToFile('clp/clp'+DBEdit1.Text+'.txt');  //salva a stringlist direto no arquivo
    finally
      SLtrans.Free;//libera stringlist da memoria
    end;

    ShowMessage('Registro salvo com sucesso!');

    ScreenMode := 'mdNormal';

    EditOFF;
  end;
end;

procedure TfrmCadastroCargos.BtnNovoClick(Sender: TObject);         // Novo
begin
  ScreenMode := 'mdInsert';  // Marcação para não carregar quando o registro é novo
  dsCargos.DataSet.Insert;

  EditON;
end;

procedure TfrmCadastroCargos.BtnVoltarClick(Sender: TObject);       // Voltar
begin
  self.Close;
end;

procedure TfrmCadastroCargos.BtnEditarClick(Sender: TObject);       // Editar
begin
  dsCargos.DataSet.Edit;

  EditON;
end;

procedure TfrmCadastroCargos.BtnApagarClick(Sender: TObject);       // Apagar
begin
  if Application.MessageBox('Deseja realmente apagar o registro?','Apagar registro', MB_YESNO) = idYES then
  begin
    dsCargos.DataSet.Delete;
    ShowMessage('Registro apagado com sucesso!');
    EditOFF;
  end;
end;

procedure TfrmCadastroCargos.BtnCancelarClick(Sender: TObject);     // Cancelar
begin
  ScreenMode := 'mdNormal';
  dsCargos.DataSet.Cancel;

  EditOFF;
end;

// FIM -------------------------------------------------------------------------
procedure TfrmCadastroCargos.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  dsCargos.DataSet.Cancel;      // Cancela INSERT se houver
end;

end.

