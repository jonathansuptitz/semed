unit ucontrato;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  ExtCtrls, DbCtrls, StdCtrls, EditBtn, Calendar;

type

  { TfrmContrato }

  TfrmContrato = class(TForm)
    BtnGerarcontrato: TBitBtn;
    BtnVoltar: TBitBtn;
    DateEditfinal: TDateEdit;
    DateEditinicial: TDateEdit;
    DBEdtCodcontrato: TDBEdit;
    DBMemo1: TDBMemo;
    EditButton1: TEditButton;
    edtFuncionario: TEditButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panelprincipal: TPanel;
    PanelBotoes: TPanel;
    procedure BtnVoltarClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmContrato: TfrmContrato;

implementation

{$R *.lfm}

{ TfrmContrato }

procedure TfrmContrato.BtnVoltarClick(Sender: TObject);
begin
  close;
end;

end.

