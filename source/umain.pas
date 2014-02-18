unit Umain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, StdCtrls, Menus, Buttons, LCLType;

type

  { TFrmMain }

  TFrmMain = class(TForm)
    BtnContratos: TBitBtn;
    BtnPessoas: TBitBtn;
    BtnCargos: TBitBtn;
    BtnLocaisdeTrabalho: TBitBtn;
    BtnSair: TBitBtn;
    dsMural: TDatasource;
    BtnNovo: TImage;
    BtnAtualizar: TImage;
    Image1: TImage;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    memoMural: TMemo;
    MenuItem1: TMenuItem;
    MenuCadastrar: TMenuItem;
    CadastrarPessoas: TMenuItem;
    CadastrarLocalTrabalho: TMenuItem;
    CadastrarCargo: TMenuItem;
    MenuNovoContrato: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    StatusBar: TStatusBar;
    Timer1: TTimer;
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure CadastrarCargoClick(Sender: TObject);
    procedure CadastrarLocalTrabalhoClick(Sender: TObject);
    procedure CadastrarPessoasClick(Sender: TObject);
    procedure BtnAtualizarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure MenuNovoContratoClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  ucontrato, ucadastropessoas, UCadastroLocalTrabalho, uCadastroCargos,
  Ucadastromural;

{$R *.lfm}

{ TFrmMain }

// MURAL DE RECADOS ------------------------------------------------------------

procedure TFrmMain.BtnAtualizarClick(Sender: TObject);   // Botão Atualizar
begin
  frmCadastroMural.AtualizarMural;
end;

procedure TFrmMain.BtnNovoClick(Sender: TObject);        // Botão Novo Recado
begin
  Application.CreateForm(TfrmCadastroMural, frmCadastroMural);
  frmCadastroMural.ShowModal;
  frmCadastroMural.Free;
end;

// INTERFACE -------------------------------------------------------------------

procedure TFrmMain.Timer1Timer(Sender: TObject);         // Atualiza data e hora do barra inferior
begin
  StatusBar.Panels[3].Text := TimeToStr(Time)+'  -  '+ DateToStr(Date)+'  ';
end;

// MENU SUPERIOR ---------------------------------------------------------------

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

// MENU ------------------------------------------------------------------------

procedure TFrmMain.BtnSairClick(Sender: TObject);
begin
  Close;
end;

// FIM -------------------------------------------------------------------------

procedure TFrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if Application.MessageBox('Deseja realmente sair?','Sair', MB_OKCANCEL) = idOK then
    Application.Terminate
  else
    abort;
end;

end.

