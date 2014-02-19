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
    CadastroLocalTrabalho: TMenuItem;
    CadastroCargos: TMenuItem;
    CadastroPessoas: TMenuItem;
    CadastroSeparador1: TMenuItem;
    MenuSuporte: TMenuItem;
    MenuSobre: TMenuItem;
    CadastroContrato: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    StatusBar: TStatusBar;
    Timer1: TTimer;
    procedure BtnCargosClick(Sender: TObject);
    procedure BtnContratosClick(Sender: TObject);
    procedure BtnLocaisdeTrabalhoClick(Sender: TObject);
    procedure BtnPessoasClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure CadastroLocalTrabalhoClick(Sender: TObject);
    procedure CadastroCargosClick(Sender: TObject);
    procedure CadastroPessoasClick(Sender: TObject);
    procedure CadastroContratoClick(Sender: TObject);
    procedure MenuSobreClick(Sender: TObject);
    procedure MenuSuporteClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BtnAtualizarClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
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
  Ucadastromural, usuporte, usobre;

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

procedure TFrmMain.CadastroContratoClick(Sender: TObject);             // Contrato
begin
  Application.CreateForm(TfrmContrato, frmContrato);
  frmContrato.ShowModal;
  frmContrato.Free;
end;

procedure TFrmMain.CadastroPessoasClick(Sender: TObject);              // Pessoas
begin
  Application.CreateForm(TfrmCadastroPessoas, frmCadastroPessoas);
  frmCadastroPessoas.ShowModal;
  frmCadastroPessoas.Free;
end;

procedure TFrmMain.CadastroCargosClick(Sender: TObject);               // Cargos
begin
  Application.CreateForm(TfrmCadastroCargos, frmCadastroCargos);
  frmCadastroCargos.ShowModal;
  frmCadastroCargos.Free;
end;

procedure TFrmMain.CadastroLocalTrabalhoClick(Sender: TObject);        // Locais de Trabalho
begin
  Application.CreateForm(TfrmCadastroLocalTrabalho, frmCadastroLocalTrabalho);
  frmCadastroLocalTrabalho.ShowModal;
  frmCadastroLocalTrabalho.Free;
end;

procedure TFrmMain.MenuSuporteClick(Sender: TObject);                  // Suporte
begin
  Application.CreateForm(TfrmSuporte, frmSuporte);
  frmSuporte.ShowModal;
  frmSuporte.Free;
end;

procedure TFrmMain.MenuSobreClick(Sender: TObject);                    // Sobre
begin
  Application.CreateForm(TfrmSobre, frmSobre);
  frmSobre.ShowModal;
  frmSobre.Free;
end;

// MENU ------------------------------------------------------------------------

procedure TFrmMain.BtnContratosClick(Sender: TObject);         // Contratos
begin
  Application.CreateForm(TfrmContrato, frmContrato);
  frmContrato.ShowModal;
  frmContrato.Free;
end;

procedure TFrmMain.BtnPessoasClick(Sender: TObject);           // Pessoas
begin
  Application.CreateForm(TfrmCadastroPessoas, frmCadastroPessoas);
  frmCadastroPessoas.ShowModal;
  frmCadastroPessoas.Free;
end;

procedure TFrmMain.BtnCargosClick(Sender: TObject);            // Cargos
begin
  Application.CreateForm(TfrmCadastroCargos, frmCadastroCargos);
  frmCadastroCargos.ShowModal;
  frmCadastroCargos.Free;
end;

procedure TFrmMain.BtnLocaisdeTrabalhoClick(Sender: TObject);  // Locais de Trabalho
begin
  Application.CreateForm(TfrmCadastroLocalTrabalho, frmCadastroLocalTrabalho);
  frmCadastroLocalTrabalho.ShowModal;
  frmCadastroLocalTrabalho.Free;
end;

procedure TFrmMain.BtnSairClick(Sender: TObject);              // Sair
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

