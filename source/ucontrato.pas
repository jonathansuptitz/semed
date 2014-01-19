unit ucontrato;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  ExtCtrls;

type

  { TfrmContrato }

  TfrmContrato = class(TForm)
    BtnVoltar: TBitBtn;
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

