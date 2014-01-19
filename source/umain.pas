unit Umain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, StdCtrls, Menus;

type

  { TFrmMain }

  TFrmMain = class(TForm)
    Label1: TLabel;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuCadastrar: TMenuItem;
    CadastrarPessoas: TMenuItem;
    MenuNovoContrato: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    procedure CadastrarPessoasClick(Sender: TObject);
    procedure MenuNovoContratoClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  ucontrato, ucadastropessoas;

{$R *.lfm}

{ TFrmMain }

// MENU ------------------------------------------------------------------------

procedure TFrmMain.CadastrarPessoasClick(Sender: TObject);  // Cadastrar Pessoas
begin
  Application.CreateForm(TfrmCadastroPessoas, frmCadastroPessoas);
  frmCadastroPessoas.ShowModal;
  frmCadastroPessoas.Free;
end;

procedure TFrmMain.MenuNovoContratoClick(Sender: TObject);  // Novo Contrato
begin
  Application.CreateForm(TfrmContrato, frmContrato);
  frmContrato.ShowModal;
  frmContrato.Free;
end;

end.

