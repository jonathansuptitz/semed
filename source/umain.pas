unit Umain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, StdCtrls, Calendar, Menus;

type

  { TFrmMain }

  TFrmMain = class(TForm)
    Label1: TLabel;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuNovoContrato: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    procedure MenuItem1Click(Sender: TObject);
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
  ucontrato;

{$R *.lfm}

{ TFrmMain }

procedure TFrmMain.MenuItem1Click(Sender: TObject);
begin

end;

procedure TFrmMain.MenuNovoContratoClick(Sender: TObject);
begin
  Application.CreateForm(TfrmContrato, frmContrato);
  frmContrato.ShowModal;
  frmContrato.Free;
end;

end.

