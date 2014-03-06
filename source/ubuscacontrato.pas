unit ubuscacontrato;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, Calendar, EditBtn, ucontrato, uCadastroCargos;

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
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
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
    frmContrato.dsContratos.DataSet.Filter:= 'codigo_pessoa like '+QuotedStr('*'+edtfuncionario.text+'*');
    frmContrato.dsContratos.DataSet.Filtered:=true;
  end
  else
    frmContrato.dsContratos.DataSet.Filtered:=false;

end;

procedure Tfrmbuscacontrato.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin

end;

procedure Tfrmbuscacontrato.EditButton1Change(Sender: TObject);
begin
  //chama a pesquisa de cargo
  Application.CreateForm(TfrmCadastroCargos, frmCadastroCargos);
  frmCadastroCargos.SelecionarAtivo := true; // Habilita botão SELECIONAR
  frmCadastroCargos.showmodal;
  frmCadastroCargos.free;

  //filtra o dscargo para o contrato
  frmContrato.dsContratos.DataSet.Filter := 'codigo_cargo = ''' + EditButton1.text + '''';
  frmContrato.dscargos.DataSet.Filtered := true;
end;

end.

