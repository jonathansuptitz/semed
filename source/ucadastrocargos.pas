unit uCadastroCargos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls, DbCtrls, DBGrids;

type

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
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    memoClau: TMemo;
    Panel1: TPanel;
    procedure BtnApagarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnSelecionarClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure DBEdit1Change(Sender: TObject);
    procedure editPesquisaChange(Sender: TObject);
    procedure editPesquisaKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCadastroCargos: TfrmCadastroCargos;
  campoBusca, ScreenMode: string;

implementation

uses
  dmMain;

{$R *.lfm}

{ TfrmCadastroCargos }

// INICIO ----------------------------------------------------------------------
procedure TfrmCadastroCargos.FormCreate(Sender: TObject);
begin
  ScreenMode := 'mdNormal';
  campoBusca := 'nome_cargo';
end;

procedure TfrmCadastroCargos.editPesquisaKeyPress(Sender: TObject; var Key: char
  );
begin                                                          // Limpa campo de pesquisa
  if (editPesquisa.Text = 'Digite para pesquisar...') then     // quando usuario começa a
    editPesquisa.Text := '';                                   // digitar
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
end;

procedure TfrmCadastroCargos.ComboBox1Change(Sender: TObject);
begin
  if (ComboBox1.Text = 'Código') then                // Altera var com o valor do
    campoBusca := 'codigo_cargo'                     // campo a ser pesquisado quando
  else if (ComboBox1.Text = 'Descrição') then        // usuario muda comboBox
    campoBusca := 'nome_cargo'
  else if (ComboBox1.Text = 'Grupo Ocupacional') then
    campoBusca := 'grupo_ocupacional_cargo';
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
procedure TfrmCadastroCargos.BtnSalvarClick(Sender: TObject);       // Salvar
var
  SLtrans: TStringList;
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

  ScreenMode := 'mdNormal';

  //memoClau.Lines.LoadFromFile('clp/clp'+DBEdit1.Text+'.txt')
end;

procedure TfrmCadastroCargos.BtnSelecionarClick(Sender: TObject);
begin

end;

procedure TfrmCadastroCargos.BtnNovoClick(Sender: TObject);         // Novo
begin
  ScreenMode := 'mdInsert';  // Marcação para não carregar quando o registro é novo
  dsCargos.DataSet.Insert;
end;

procedure TfrmCadastroCargos.BtnVoltarClick(Sender: TObject);       // Voltar
begin
  self.Close;
end;

procedure TfrmCadastroCargos.BtnEditarClick(Sender: TObject);       // Editar
begin
  dsCargos.DataSet.Edit;
end;

procedure TfrmCadastroCargos.BtnApagarClick(Sender: TObject);       // Apagar
begin
  dsCargos.DataSet.Delete;
end;

procedure TfrmCadastroCargos.BtnCancelarClick(Sender: TObject);     // Cancelar
begin
  ScreenMode := 'mdNormal';
  dsCargos.DataSet.Cancel;
end;

// FIM -------------------------------------------------------------------------
procedure TfrmCadastroCargos.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  dsCargos.DataSet.Cancel;      // Cancela INSERT se houver
end;

end.

