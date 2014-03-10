unit ubuscacontrato;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, EditBtn, LCLType;

type

  { Tfrmbuscacontrato }

  Tfrmbuscacontrato = class(TForm)
    ComboBox1: TComboBox;
    DateEdit1: TDateEdit;
    DBGrid1: TDBGrid;
    EditButton1: TEditButton;
    edtbusca: TEdit;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    procedure ComboBox1Change(Sender: TObject);
    procedure EditButton1Change(Sender: TObject);
    procedure edtbuscaChange(Sender: TObject);
    procedure edtbuscaExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmbuscacontrato: Tfrmbuscacontrato;

implementation

uses uhtml,ufiltragem, uCadastroCargos, udmcontratos;

{$R *.lfm}

{ Tfrmbuscacontrato }

procedure Tfrmbuscacontrato.edtbuscaChange(Sender: TObject);
begin
  if Length(edtbusca.text) <> 0 then
  begin
    DMcontratos.dsContratos.DataSet.Filter:= 'codigo_pessoa like '+QuotedStr('*'+edtbusca.text+'*');
    DMcontratos.dsContratos.DataSet.Filtered:=true;
  end
  else
    DMcontratos.dsContratos.DataSet.Filtered:=false;
end;

procedure Tfrmbuscacontrato.edtbuscaExit(Sender: TObject);
begin
  if Length(edtbusca.text) <> 0 then
    case ComboBox1.ItemIndex of
    0:
      filtragem.filtrads('codigo_contrato = '''+ edtbusca.text+'''','dscontratos');
    1:
      begin
        filtragem.filtrads('nome_pessoa = '''+edtbusca.text+'''','dspessoa');

        filtragem.filtrads('codigo_pessoa = '''
        + DMcontratos.dspessoa.DataSet.FieldByName('codigo_pessoa').value+'''','dscontratos');
      end;
    2: filtragem.filtrads('codigo_pessoa = '''+edtbusca.text +'''','dscontratos');
    end;

end;

procedure Tfrmbuscacontrato.FormShow(Sender: TObject);
begin

end;

procedure Tfrmbuscacontrato.EditButton1Change(Sender: TObject);
begin
  //chama a pesquisa de cargo
  Application.CreateForm(TfrmCadastroCargos, frmCadastroCargos);
  frmCadastroCargos.SelecionarAtivo := true; // Habilita botão SELECIONAR
  frmCadastroCargos.showmodal;
  frmCadastroCargos.free;
end;

procedure Tfrmbuscacontrato.ComboBox1Change(Sender: TObject);
begin

end;

end.

