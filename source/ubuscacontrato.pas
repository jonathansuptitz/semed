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


{
  //filtra o dspessoa para o contrato
  dspessoa.DataSet.Filter:='codigo_pessoa = '''+EdtFuncionario.text+'''';
  dspessoa.DataSet.Filtered:=true;

  //filtra a cidade da pessoa
  dscidades.DataSet.Filter:='codigo_cidade = '''+dspessoa.DataSet.FieldByName('codigo_cidade').asstring+'''';
  dscidades.DataSet.Filtered:=true;

  //filtra cargo
  dscargos.DataSet.Filter := 'codigo_cargo = ''' + DBEdtcargo.text + '''';
  dscargos.DataSet.Filtered := true;

  //filtra o dspessoa para o contrato
  dspessoa.DataSet.Filter:='codigo_pessoa = '''+EdtFuncionario.text+'''';
  dspessoa.DataSet.Filtered:=true;

  //filtra a cidade da pessoa
  dscidades.DataSet.Filter:='codigo_cidade = '''+dspessoa.DataSet.FieldByName('codigo_cidade').asstring+'''';
  dscidades.DataSet.Filtered:=true;

  //filtra o dslocal para o contrato
  dslocal.DataSet.Filter := 'nome_local_trabalho = ''' + edtlocal.text + '''';
  dslocal.DataSet.Filtered := true;
}
end.

