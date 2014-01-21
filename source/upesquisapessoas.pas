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
    procedure editPesquisaChange(Sender: TObject);
    procedure editPesquisaKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmPesquisaPessoas: TfrmPesquisaPessoas;

implementation

uses
  dmMain;

procedure TfrmPesquisaPessoas.editPesquisaChange(Sender: TObject);
begin
  DM1.tb_pessoas.Filter := 'nome_pessoa LIKE '+ QuotedStr('*' + editPesquisa.Text + '*');
  DM1.tb_pessoas.Filtered := true;
end;

procedure TfrmPesquisaPessoas.editPesquisaKeyPress(Sender: TObject;
  var Key: char);
begin
  if (editPesquisa.Text = 'Digite para pesquisar...') then
    editPesquisa.Text := '';
end;

procedure TfrmPesquisaPessoas.BtnEncerrarClick(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmPesquisaPessoas.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  DM1.tb_pessoas.Filtered := false;
end;

{$R *.lfm}

{ TfrmPesquisaPessoas }

end.

