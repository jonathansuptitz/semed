unit UCadastroLocalTrabalho;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  DBGrids, StdCtrls, ExtCtrls, Buttons;

type

  {Quando esse form for chamado por outro por motivo de pesquisa(como buscar o codigo),
   deve-se habilitar o botão "Selecionar", que passa o valor do código para o form
   que o chamou (implementar para cada pesquisa).
   ex: Application.CreateForm(TfrmCadastroLocaltrabalho, frmCadastroLocaltrabalho);
       frmCadastroLocaltrabalho.BtnSeleciona.Enable := true;
       frmCadastroLocaltrabalho.ShowModal;
       frmCadastroLocaltrabalho.Free;

   Caso o form seja aberto pela tela
   principal, o mesmo deve permanecer desabilitado}

  { TfrmCadastroLocalTrabalho }

  TfrmCadastroLocalTrabalho = class(TForm)
    BtnSelecionar: TBitBtn;
    BtnApagar: TBitBtn;
    BtnCancelar: TBitBtn;
    BtnEditar: TBitBtn;
    BtnNovo: TBitBtn;
    BtnSalvar: TBitBtn;
    BtnVoltar: TBitBtn;
    ComboBox1: TComboBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBGrid1: TDBGrid;
    dsLocal_trabalho: TDatasource;
    editPesquisa: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    procedure BtnApagarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnSelecionarClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure editPesquisaChange(Sender: TObject);
    procedure editPesquisaKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure EditON;
    procedure EditOFF;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCadastroLocalTrabalho: TfrmCadastroLocalTrabalho;
  campoBusca: string;

implementation

uses
  dmMain;

{ TfrmCadastroLocalTrabalho }

// INICIO ----------------------------------------------------------------------
procedure TfrmCadastroLocalTrabalho.FormCreate(Sender: TObject);  // Atribui valor
begin                                                             // inicial a pesquisa
  campoBusca := 'nome_local_trabalho';
end;

procedure TfrmCadastroLocalTrabalho.editPesquisaKeyPress(Sender: TObject;
  var Key: char);                                            // Limpa campo quando usuario
begin                                                        // começa a digitar
  if (editPesquisa.Text = 'Digite para pesquisar...') then
    editPesquisa.Text := '';
end;

// PREVISAO DE ERROS -----------------------------------------------------------
procedure TfrmCadastroLocalTrabalho.EditON;        // Habilitar Edição
begin
  DBEdit2.ReadOnly := false;
  DBEdit3.ReadOnly := false;
  DBEdit4.ReadOnly := false;
  DBEdit5.ReadOnly := false;
  DBEdit6.ReadOnly := false;
  DBEdit7.ReadOnly := false;

  BtnSalvar.Enabled := true;
  BtnCancelar.Enabled := true;
  BtnNovo.Enabled := false;
  BtnEditar.Enabled := false;
  BtnApagar.Enabled := false;
  BtnSelecionar.Enabled := false;
  BtnVoltar.Enabled := false;
  if BtnSelecionar.Enabled then
    SelecionarAtivo := true; // Marca estado inicial do BtnSelecionar
end;

procedure TfrmCadastroLocalTrabalho.EditOFF;       // Desabilitar Edição
begin
  DBEdit2.ReadOnly := true;
  DBEdit3.ReadOnly := true;
  DBEdit4.ReadOnly := true;
  DBEdit5.ReadOnly := true;
  DBEdit6.ReadOnly := true;
  DBEdit7.ReadOnly := true;

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
procedure TfrmCadastroLocalTrabalho.editPesquisaChange(Sender: TObject); // Atualiza pesquisa
begin
  if (campoBusca = 'codigo_local_trabalho') then     // Se opção selecionada for código
  begin
    if (Length(editPesquisa.Text) = 0) then             // Se usuario apagar todos os caracteres do campo
      DM1.tb_local_trabalho.Filtered := false             // Desabilita filtro para evitar erro
    else
    begin                                                 // Senao executa filtro normalmente
      DM1.tb_local_trabalho.Filter := campoBusca+' = '+ editPesquisa.Text;
      DM1.tb_local_trabalho.Filtered := true; {Pesquisa para código apenas com "="}
    end;
  end
  else
  begin                                              // Se opção selecionada for código -> executa filtro normalmente
    DM1.tb_local_trabalho.Filter := campoBusca+' LIKE '+ QuotedStr('*' + editPesquisa.Text + '*');
    DM1.tb_local_trabalho.Filtered := true;
  end;
end;

procedure TfrmCadastroLocalTrabalho.ComboBox1Change(Sender: TObject);
begin
  if (ComboBox1.Text = 'Nome') then                // Altera var com o valor do
    campoBusca := 'nome_local_trabalho'            // campo a ser pesquisado quando
  else                                             // usuario muda comboBox
    campoBusca := 'codigo_local_trabalho';
end;

//MENU -------------------------------------------------------------------------
procedure TfrmCadastroLocalTrabalho.BtnSelecionarClick(Sender: TObject);   // Botão SELECIONAR
begin                                                                      // Implementar conforme explicação
                                                                           // no inicio do fonte.
end;

procedure TfrmCadastroLocalTrabalho.BtnNovoClick(Sender: TObject);    // Novo
begin
  dsLocal_trabalho.DataSet.Insert;
end;

procedure TfrmCadastroLocalTrabalho.BtnSalvarClick(Sender: TObject);  // Salvar
begin
  dsLocal_trabalho.DataSet.Post;
end;

procedure TfrmCadastroLocalTrabalho.BtnVoltarClick(Sender: TObject);  // Voltar
begin
  self.Close;
end;

procedure TfrmCadastroLocalTrabalho.BtnEditarClick(Sender: TObject);  //Editar
begin
  dsLocal_trabalho.DataSet.Edit;
end;

procedure TfrmCadastroLocalTrabalho.BtnApagarClick(Sender: TObject);  // Apagar
begin
  dsLocal_trabalho.DataSet.Delete;
end;

procedure TfrmCadastroLocalTrabalho.BtnCancelarClick(Sender: TObject);// Cancelar
begin
  dsLocal_trabalho.DataSet.Cancel;
end;

// FIM -------------------------------------------------------------------------
procedure TfrmCadastroLocalTrabalho.FormClose(Sender: TObject;   // OnClose
  var CloseAction: TCloseAction);
begin
  dsLocal_trabalho.DataSet.Cancel;   // Cancela INSERT se houver

  DM1.tb_local_trabalho.Filtered := false;  // Cancela filtro para não prejudcar outros processos.
end;                                        // Registro selecionado se mantém.

{$R *.lfm}

end.

