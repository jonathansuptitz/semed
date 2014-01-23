unit UCadastroLocalTrabalho;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  DBGrids, StdCtrls, ExtCtrls, Buttons;

type

  { TfrmCadastroLocalTrabalho }

  TfrmCadastroLocalTrabalho = class(TForm)
    BtnApagar: TBitBtn;
    BtnCancelar: TBitBtn;
    BtnEditar: TBitBtn;
    BtnNovo: TBitBtn;
    BtnSelecionar: TBitBtn;
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
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCadastroLocalTrabalho: TfrmCadastroLocalTrabalho;

implementation

uses
  dmMain;

{$R *.lfm}

end.

