unit Umain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, StdCtrls, Menus, ZConnection, ZDataset;

type

  { TFrmMain }

  TFrmMain = class(TForm)
    dsMural: TDatasource;
    BtnNovo: TImage;
    BtnAtualizar: TImage;
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
    procedure BtnNovoClick(Sender: TObject);
    procedure CadastrarCargoClick(Sender: TObject);
    procedure CadastrarLocalTrabalhoClick(Sender: TObject);
    procedure CadastrarPessoasClick(Sender: TObject);
    procedure BtnAtualizarClick(Sender: TObject);
    procedure MenuNovoContratoClick(Sender: TObject);
    procedure AtualizarMural;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  ucontrato, ucadastropessoas, UCadastroLocalTrabalho, uCadastroCargos, dmMain,
  Ucadastromural;

{$R *.lfm}

{ TFrmMain }

// MURAL DE RECADOS ------------------------------------------------------------

procedure TFrmMain.AtualizarMural;
begin
 { dsMural.DataSet.First;

  memoMural.Lines.Clear;        // Limpa MEMO
  memoMural.Lines.Add('----- INICIO DOS REGISTROS -----');
  memoMural.Lines.Add('');

  while not (dsMural.DataSet.EOF) do  //Enquanto nao for fim dos registros
  begin
    memoMural.Lines.Add('* ' + dsMural.DataSet.FieldByName('data_mural').Value +   // Escreve data e nome
                        ', por ' + dsMural.DataSet.FieldByName('usuario_mural').Value + ':');
    memoMural.Lines.Add(dsMural.DataSet.FieldByName('conteudo_mural').Value);  // Escreve conteudo
    memoMural.Lines.Add('');                                                   // Pula linha

    if not (dsMural.DataSet.EOF) then   // Se nao for ultimo registro, passa para proximo
      dsMural.DataSet.Next;
  end;  }
end;

procedure TFrmMain.BtnAtualizarClick(Sender: TObject);   // Botão Atualizar
begin
 // AtualizarMural;
end;

procedure TFrmMain.BtnNovoClick(Sender: TObject);
begin
 { Application.CreateForm(TfrmCadastroMural, frmCadastroMural);
  frmCadastroMural.ShowModal;
  frmCadastroMural.Free;  }
end;

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

