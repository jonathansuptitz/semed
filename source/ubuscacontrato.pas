unit ubuscacontrato;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, EditBtn, LCLType, Buttons;

type

  { Tfrmbuscacontrato }

  Tfrmbuscacontrato = class(TForm)
    btnGeracontrato: TBitBtn;
    DateEdit1: TDateEdit;
    DBGrid1: TDBGrid;
    edtlocal: TEditButton;
    edtCodigo: TEditButton;
    edtfuncionario: TEditButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure btnGeracontratoClick(Sender: TObject);
    procedure edtCodigoButtonClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtfuncionarioButtonClick(Sender: TObject);
    procedure edtfuncionarioExit(Sender: TObject);
    procedure edtlocalButtonClick(Sender: TObject);
    procedure edtlocalExit(Sender: TObject);
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
  filtragem.filtrads('codigo_contrato = '''  + edtCodigo.text+'''', 'dscontrato');
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
  filtragem.filtrads('codigo_pessoa = '''  + edtfuncionario.text+'''', 'dspessoa');
  filtragem.filtrads('codigo_pessoa = '''  + edtfuncionario.text+'''', 'dscontrato');
end;

procedure Tfrmbuscacontrato.edtlocalButtonClick(Sender: TObject);
begin
  //chama a pesquisa de local
     DMcontratos.dslocaltrabalho.DataSet.Active:=true;

     Application.CreateForm(TfrmCadastroLocalTrabalho, frmCadastroLocalTrabalho);
     frmCadastroLocalTrabalho.SelecionarAtivo := true;
     frmCadastroLocalTrabalho.showmodal;
     frmCadastroLocalTrabalho.free;

     edtlocal.Text := DMcontratos.dslocaltrabalho.DataSet.FieldByName('codigo_local_trabalho').AsString;

     filtragem.filtrads('codigo_local_trabalho = '''  + edtlocal.text+'''', 'dscontrato');
end;

procedure Tfrmbuscacontrato.edtlocalExit(Sender: TObject);
begin
  filtragem.filtrads('codigo_local_trabalho = '''  + edtlocal.text+'''', 'dscontrato');
end;

procedure Tfrmbuscacontrato.FormShow(Sender: TObject);
begin

end;

procedure Tfrmbuscacontrato.edtCodigoButtonClick(Sender: TObject);
begin
  filtragem.filtrads('codigo_contrato = '''  + edtCodigo.text+'''', 'dscontrato');
end;

procedure Tfrmbuscacontrato.btnGeracontratoClick(Sender: TObject);
begin
  filtragem.filtrads('codigo_contrato = '''
  +DMcontratos.dsContratos.DataSet.FieldByName('codigo_contrato').value
  +'''', 'dscontratoslocais');

  html.editahtml();
end;


end.

