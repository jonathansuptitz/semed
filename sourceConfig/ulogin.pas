unit ulogin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons;

type

  { TfrmLogin }

  TfrmLogin = class(TForm)
    BtnEntrar: TBitBtn;
    BtnSair: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Panel2: TPanel;
    procedure BtnEntrarClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  Umain;

{$R *.lfm}

{ TfrmLogin }

procedure TfrmLogin.BtnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.BtnEntrarClick(Sender: TObject);
begin
  if (Edit1.Text = 'administrador') and (Edit2.Text = 'ceduptim') then
  begin
    Application.CreateForm(TfrmMain, frmMain);
    frmMain.Show;
    self.Hide;
  end
  else
    ShowMessage('Usuário ou senha não encontrado!');
end;

end.

