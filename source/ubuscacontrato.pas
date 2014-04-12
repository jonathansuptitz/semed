unit ubuscacontrato;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, EditBtn, LCLType, Buttons, Ipfilebroker, ExtCtrls, LCLIntf,
  DbCtrls, Printers, IpHtml;



type

  { Tfrmbuscacontrato }

  Tfrmbuscacontrato = class(TForm)
    btnSair: TBitBtn;
    btnGeracontrato: TBitBtn;
    DateEdit1: TDateEdit;
    DBGrid1: TDBGrid;
    edtcodigo: TEdit;
    edtfuncionario: TEditButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure btnGeracontratoClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure DateEdit1Change(Sender: TObject);
    procedure DateEdit1Enter(Sender: TObject);
    procedure DateEdit1Exit(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edtcodigoChange(Sender: TObject);
    procedure edtcodigoEditingDone(Sender: TObject);
    procedure edtcodigoEnter(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtfuncionarioButtonClick(Sender: TObject);
    procedure edtfuncionarioChange(Sender: TObject);
    procedure edtfuncionarioEnter(Sender: TObject);
    procedure edtfuncionarioExit(Sender: TObject);
    procedure FormClose(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmbuscacontrato: Tfrmbuscacontrato;

implementation

uses uhtml, ufiltragem, uCadastroCargos,UCadastroLocalTrabalho,
  uPesquisaPessoas, udmcontratos;

{$R *.lfm}

{ Tfrmbuscacontrato }

procedure Tfrmbuscacontrato.edtCodigoExit(Sender: TObject);
begin
  if Length(edtcodigo.text) <> 0 then
    filtragem.filtrads('codigo_contrato = '''  + edtCodigo.text+'''', 'dscontratos')
  else
    DMcontratos.dsContratos.DataSet.Filtered:=false;
end;

procedure Tfrmbuscacontrato.edtfuncionarioButtonClick(Sender: TObject);
begin
  //chama a pesquisa de pessoa
  Application.CreateForm(TfrmPesquisaPessoas, frmPesquisaPessoas);
  frmPesquisaPessoas.showmodal;
  frmPesquisaPessoas.free;

  //coloca codigo funcionario em seu respectivo edit
  edtfuncionario.text:= DMcontratos.dspessoa.DataSet.FieldByName('codigo_pessoa').value;

  //filtra ds pessoa
  filtragem.filtrads('codigo_pessoa = '''  + edtfuncionario.text+'''', 'dspessoa');
  filtragem.filtrads('codigo_pessoa = '''  + edtfuncionario.text+'''', 'dscontratos');
end;

procedure Tfrmbuscacontrato.edtfuncionarioChange(Sender: TObject);
begin
  if (edtfuncionario.Text <> '') then
  begin
    DateEdit1.Enabled:= false;
    edtcodigo.Enabled:= false;
  end
  else
  begin
    DateEdit1.Enabled:= true;
    edtcodigo.Enabled:= true;
  end;
end;

procedure Tfrmbuscacontrato.edtfuncionarioEnter(Sender: TObject);
begin
  edtcodigo.clear;
  DateEdit1.clear;
end;

procedure Tfrmbuscacontrato.edtfuncionarioExit(Sender: TObject);
begin
  if Length(edtfuncionario.text) <> 0 then
    filtragem.filtrads('codigo_pessoa like '  + QuotedStr('*'+edtfuncionario.text+'*'), 'dscontratos')
  else
    DMcontratos.dsContratos.DataSet.Filtered:=false;
end;

procedure Tfrmbuscacontrato.FormClose(Sender: TObject);
begin
   DMcontratos.zt_contratos.Active:=false;
end;

procedure Tfrmbuscacontrato.FormShow(Sender: TObject);
begin
 DMcontratos.zt_contratos.Active:=true;
end;

procedure Tfrmbuscacontrato.btnGeracontratoClick(Sender: TObject);
begin
  html.editahtml;//chama o gera html
end;

procedure Tfrmbuscacontrato.btnSairClick(Sender: TObject);
begin
 close;
end;

procedure Tfrmbuscacontrato.DateEdit1Change(Sender: TObject);
begin
  if Length(DateEdit1.Text) <> 0 then
    filtragem.filtrads('data_contrato like ' + QuotedStr('*'+DateEdit1.text+'*'), 'dscontratos')
  else
    DMcontratos.dsContratos.DataSet.Filtered:=false;

  if (DateEdit1.Text <> '') then
  begin
    edtfuncionario.Enabled:= false;
    edtcodigo.Enabled:= false;
  end
  else
  begin
    edtfuncionario.Enabled:= true;
    edtcodigo.Enabled:= true;
  end;
end;

procedure Tfrmbuscacontrato.DateEdit1Enter(Sender: TObject);
begin
  edtfuncionario.clear;
  edtcodigo.clear;
end;

procedure Tfrmbuscacontrato.DateEdit1Exit(Sender: TObject);
begin
 if Length(DateEdit1.Text) <> 0 then
  filtragem.filtrads('data_contrato like ' + QuotedStr('*'+DateEdit1.text+'*'), 'dscontratos')
 else
  DMcontratos.dsContratos.DataSet.Filtered:=false;
end;

procedure Tfrmbuscacontrato.DBGrid1DblClick(Sender: TObject);
begin
  html.editahtml;//chama o gerador de contrato
end;

procedure Tfrmbuscacontrato.edtcodigoChange(Sender: TObject);
begin
  if (edtcodigo.Text <> '') then
  begin
    edtfuncionario.Enabled:= false;
    DateEdit1.Enabled:= false;
  end
  else
  begin
    edtfuncionario.Enabled:= true;
    DateEdit1.Enabled:= true;
  end;
end;

procedure Tfrmbuscacontrato.edtcodigoEditingDone(Sender: TObject);
begin

end;

procedure Tfrmbuscacontrato.edtcodigoEnter(Sender: TObject);
begin
  edtfuncionario.Clear;
  DateEdit1.Clear;
end;


end.

