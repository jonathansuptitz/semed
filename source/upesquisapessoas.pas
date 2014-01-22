unit uPesquisaPessoas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, DBGrids;

type

  { TfrmPesquisaPessoas }

  TfrmPesquisaPessoas = class(TForm)
    BtnEncerrar: TBitBtn;
    ComboBox1: TComboBox;
    dsPessoas: TDatasource;
    DBGrid1: TDBGrid;
    editPesquisa: TEdit;
    Panel1: TPanel;
    procedure BtnEncerrarClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
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
  frmPesquisaPessoas: TfrmPesquisaPessoas;
  campoBusca: string;

implementation

uses
  dmMain, ucontrato;

// INICIO ----------------------------------------------------------------------
procedure TfrmPesquisaPessoas.FormCreate(Sender: TObject);    // Atribui valor a var
begin                                                         // para iniciar pesquisa
  campoBusca := 'nome_pessoa';
end;

procedure TfrmPesquisaPessoas.editPesquisaKeyPress(Sender: TObject;
  var Key: char);                                            // Limpa campo quando
begin                                                        // usuario começa a digitar
  if (editPesquisa.Text = 'Digite para pesquisar...') then
    editPesquisa.Text := '';
end;

// PESQUISA --------------------------------------------------------------------
procedure TfrmPesquisaPessoas.editPesquisaChange(Sender: TObject);  // quando digita
begin                                                               // ativa filtro
  DM1.tb_pessoas.Filter := campoBusca+' LIKE '+ QuotedStr('*' + editPesquisa.Text + '*');
  DM1.tb_pessoas.Filtered := true;
end;

procedure TfrmPesquisaPessoas.ComboBox1Change(Sender: TObject);  // atualiza var quando
begin                                                            // usuario troca no combo
  if ComboBox1.Text = 'Nome' then
    campoBusca := 'nome_pessoa'
  else if ComboBox1.Text = 'CPF' then
    campoBusca := 'cpf_pessoa'
  else if ComboBox1.Text = 'Cidade' then
    campoBusca := 'cidade_pessoa'
  else if ComboBox1.Text = 'Bairro' then
    campoBusca := 'bairro_pessoa'
  else if ComboBox1.Text = 'RG' then
    campoBusca := 'rg_pessoa';

  editPesquisa.Text := '';
end;

// FIM -------------------------------------------------------------------------
procedure TfrmPesquisaPessoas.BtnEncerrarClick(Sender: TObject); // Botão Encerrar Pesquisa
begin
  self.Close;
end;

procedure TfrmPesquisaPessoas.DBGrid1DblClick(Sender: TObject);  // Duplo clique na grid
begin
  self.Close;
end;

procedure TfrmPesquisaPessoas.FormClose(Sender: TObject;  // Desativa filtro da tabela (principal)
  var CloseAction: TCloseAction);                         // para nao afetar outros processos.
begin                                                     // O registro continua no selecionado.
  DM1.tb_pessoas.Filtered := false;

  //caso o frmcontrato esteje aberto manda o codigo da pessoa para o campo nele
  if not(frmContrato = nil) then
  begin
    frmContrato.dsContratos.DataSet.FieldByName('codigo_pessoa').value := dsPessoas.DataSet.FieldByName('codigo_pessoa').value ;
  end;

end;

{$R *.lfm}

{ TfrmPesquisaPessoas }

end.

