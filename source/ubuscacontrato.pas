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
    procedure DateEdit1Exit(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edtCodigoButtonClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtfuncionarioButtonClick(Sender: TObject);
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
   if Length(edtcodigo.text) <>0 then
  begin
    filtragem.filtrads('codigo_contrato = '''  + edtCodigo.text+'''', 'dscontrato');
  end;
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
  filtragem.filtrads('codigo_pessoa = '''  + edtfuncionario.text+'''', 'dscontrato');
end;

procedure Tfrmbuscacontrato.edtfuncionarioExit(Sender: TObject);
begin
  if Length(edtfuncionario.text) <> 0 then
  begin
    filtragem.filtrads('codigo_pessoa = '''  + edtfuncionario.text+'''', 'dscontrato');
  end;
end;

procedure Tfrmbuscacontrato.FormClose(Sender: TObject);
begin
   DMcontratos.zt_contratos.Active:=false;
end;

procedure Tfrmbuscacontrato.FormShow(Sender: TObject);
begin
 DMcontratos.zt_contratos.Active:=true;
end;

procedure Tfrmbuscacontrato.edtCodigoButtonClick(Sender: TObject);
begin
  filtragem.filtrads('codigo_contrato = '''  + edtCodigo.text+'''', 'dscontrato');
end;

procedure Tfrmbuscacontrato.btnGeracontratoClick(Sender: TObject);
begin
  html.editahtml;//chama o gera html
end;

procedure Tfrmbuscacontrato.btnSairClick(Sender: TObject);
begin
 close;
end;

procedure Tfrmbuscacontrato.DateEdit1Exit(Sender: TObject);
begin
  filtragem.filtrads('data_contrato = '''  + DateEdit1.text+'''', 'dscontrato');
end;

procedure Tfrmbuscacontrato.DBGrid1DblClick(Sender: TObject);
begin
  html.editahtml;//chama o gerador de contrato
end;


end.

