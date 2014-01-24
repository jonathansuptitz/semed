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
    CadastrarLocalTrabalho: TMenuItem;
    CadastrarCargo: TMenuItem;
    MenuNovoContrato: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    procedure CadastrarCargoClick(Sender: TObject);
    procedure CadastrarLocalTrabalhoClick(Sender: TObject);
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
  ucontrato, ucadastropessoas, UCadastroLocalTrabalho, uCadastroCargos;

{$R *.lfm}

{ TFrmMain }

// MENU ------------------------------------------------------------------------

procedure TFrmMain.CadastrarPessoasClick(Sender: TObject);  // Cadastrar Pessoas
begin
  Application.CreateForm(TfrmCadastroPessoas, frmCadastroPessoas);
  frmCadastroPessoas.ShowModal;
  frmCadastroPessoas.Free;
end;

procedure TFrmMain.CadastrarLocalTrabalhoClick(Sender: TObject);// Cadastrar local de trabalho
begin
  Application.CreateForm(TfrmCadastroLocalTrabalho, frmCadastroLocalTrabalho);
  frmCadastroLocalTrabalho.ShowModal;
  frmCadastroLocalTrabalho.Free;
end;

procedure TFrmMain.CadastrarCargoClick(Sender: TObject);   // Cadastrar Cargo
begin
  Application.CreateForm(TfrmCadastroCargos, frmCadastroCargos);
  frmCadastroCargos.ShowModal;
  frmCadastroCargos.Free;
end;

procedure TFrmMain.MenuNovoContratoClick(Sender: TObject);  // Novo Contrato
begin
  Application.CreateForm(TfrmContrato, frmContrato);
  frmContrato.ShowModal;
  frmContrato.Free;
end;

end.

