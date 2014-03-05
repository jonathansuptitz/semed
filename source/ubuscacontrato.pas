unit ubuscacontrato;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, ucontrato;

type

  { Tfrmbuscacontrato }

  Tfrmbuscacontrato = class(TForm)
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    procedure Edit1Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmbuscacontrato: Tfrmbuscacontrato;

implementation

{$R *.lfm}

{ Tfrmbuscacontrato }

procedure Tfrmbuscacontrato.Edit1Change(Sender: TObject);
begin
  frmContrato.dsContratos.DataSet.Filtered:=false;
  frmContrato.dsContratos.DataSet.Filter:= 'codigo_pessoa like '''+Edit1.text'''';
  frmContrato.dsContratos.DataSet.Filtered:=true;
end;

end.

