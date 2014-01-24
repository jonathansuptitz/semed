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
    DBEdit5: TDBEdit;
    DBGrid1: TDBGrid;
    dsCargos: TDatasource;
    editPesquisa: TEdit;
    GroupBox1: TGroupBox;
    imgNovo: TImage;
    imgEdit: TImage;
    imgSalvar: TImage;
    imgCancelar: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
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
    procedure BtnVoltarClick(Sender: TObject);
    procedure editPesquisaKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCadastroCargos: TfrmCadastroCargos;

implementation

{$R *.lfm}

{ TfrmCadastroCargos }

// INICIO ----------------------------------------------------------------------
procedure TfrmCadastroCargos.editPesquisaKeyPress(Sender: TObject; var Key: char
  );
begin                                                          // Limpa campo de pesquisa
  if (editPesquisa.Text = 'Digite para pesquisar...') then     // quando usuario começa a
    editPesquisa.Text := '';                                   // digitar
end;

// BOTOES ----------------------------------------------------------------------
procedure TfrmCadastroCargos.BtnVoltarClick(Sender: TObject);       // Voltar
begin
  self.Close;
end;

procedure TfrmCadastroCargos.BtnNovoClick(Sender: TObject);         // Novo
begin
  dsCargos.DataSet.Insert;
end;

procedure TfrmCadastroCargos.BtnSalvarClick(Sender: TObject);       // Salvar
begin
  dsCargos.DataSet.Post;
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
  dsCargos.DataSet.Cancel;
end;

// FIM -------------------------------------------------------------------------
procedure TfrmCadastroCargos.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  dsCargos.DataSet.Cancel;      // Cancela INSERT se houver
end;

end.

