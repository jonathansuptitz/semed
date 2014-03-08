unit ubuscacontrato;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, Calendar, EditBtn, udmcontratos, uCadastroCargos,LCLType;

type

  { Tfrmbuscacontrato }

  Tfrmbuscacontrato = class(TForm)
    DateEdit1: TDateEdit;
    DBGrid1: TDBGrid;
    EditButton1: TEditButton;
    edtfuncionario: TEdit;
    edtcodigo: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure EditButton1Change(Sender: TObject);
    procedure edtfuncionarioChange(Sender: TObject);
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

procedure Tfrmbuscacontrato.edtfuncionarioChange(Sender: TObject);
begin
  if Length(edtfuncionario.text) <> 0 then
  begin
    DMcontratos.dsContratos.DataSet.Filter:= 'codigo_pessoa like '+QuotedStr('*'+edtfuncionario.text+'*');
    DMcontratos.dsContratos.DataSet.Filtered:=true;
  end
  else
    DMcontratos.dsContratos.DataSet.Filtered:=false;
end;

procedure Tfrmbuscacontrato.EditButton1Change(Sender: TObject);
begin
  //chama a pesquisa de cargo
  Application.CreateForm(TfrmCadastroCargos, frmCadastroCargos);
  frmCadastroCargos.SelecionarAtivo := true; // Habilita botão SELECIONAR
  frmCadastroCargos.showmodal;
  frmCadastroCargos.free;
end;

end.

