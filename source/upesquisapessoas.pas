unit uPesquisaPessoas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, DBGrids;

type

  { TfrmPesquisaPessoas }

  TfrmPesquisaPessoas = class(TForm)
    BtnCancelar: TBitBtn;
    ComboBox1: TComboBox;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Panel1: TPanel;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmPesquisaPessoas: TfrmPesquisaPessoas;

implementation

{$R *.lfm}

end.

