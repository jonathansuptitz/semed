unit ucontrato;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, LR_Class, LR_DBSet, LR_Desgn, lr_e_pdf,
  Forms, Controls, Graphics, Dialogs, Buttons, ExtCtrls, DbCtrls, StdCtrls,
  EditBtn, Calendar, ZDataset;

type

  { TfrmContrato }

  TfrmContrato = class(TForm)
    BtnGerarcontrato: TBitBtn;
    BtnVoltar: TBitBtn;
    dslocal: TDatasource;
    DBBoxCargo: TDBComboBox;
    DBLookupBoxLocal: TDBLookupComboBox;
    dscargos: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBMemo2: TDBMemo;
    dsContratos: TDatasource;
    DateEditfinal: TDateEdit;
    DateEditinicial: TDateEdit;
    DBEdtCodcontrato: TDBEdit;
    DBMemo1: TDBMemo;
    frDBDataSet1: TfrDBDataSet;
    frDesigner1: TfrDesigner;
    frReport1: TfrReport;
    frTNPDFExport1: TfrTNPDFExport;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panelprincipal: TPanel;
    PanelBotoes: TPanel;
    btnBuscarpessoa: TSpeedButton;
    procedure BtnGerarcontratoClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure DBBoxCargoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnBuscarpessoaClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmContrato: TfrmContrato;

implementation
uses
  uPesquisaPessoas;

{$R *.lfm}

{ TfrmContrato }

procedure TfrmContrato.BtnVoltarClick(Sender: TObject);
begin
  close;
end;

procedure TfrmContrato.DBBoxCargoChange(Sender: TObject);
begin
  dscargos.DataSet.Filtered := true;
  dscargos.DataSet.Filter := 'nome_cargo like '+ DBBoxCargo.text;
end;

procedure TfrmContrato.BtnGerarcontratoClick(Sender: TObject);
begin
  //adiciona demais campos tabela contrato
  dsContratos.DataSet.FieldByName('periodo_inicial_contrato').Value := DateEditinicial.GetDateFormat;
  dsContratos.DataSet.FieldByName('periodo_final_contrato').Value := DateEditinicial.GetDateFormat;
  dsContratos.DataSet.FieldByName('data_contrato').Value := FormatDateTime('aaaa', Date);
  dsContratos.DataSet.Post; //posta

  frReport1.Variables.Add('VarDatainicial');//criar variavel data inicial
  frReport1.Variables.Add('VarDatafinal');//criar variavel data final

  frVariables['VarDatainicial']:= DateEditinicial.text; //atribui valor a variavel
  frVariables['VarDatafinal']:= DateEditinicial.text; //atribui valor a variavel


  frReport1.LoadFromFile('contrato.lrf');//carrega o contrato padrão

  frReport1.PrepareReport;//prepara o contrato

  // salva em pdf
  frReport1.SavePreparedReport('contratos/'+ frmPesquisaPessoas.dsPessoas.DataSet.FieldByName('nome_pessoa').Value+'.pdf');

  frReport1.ShowPreparedReport;//exibi preview do contrato
end;

procedure TfrmContrato.FormShow(Sender: TObject);
begin
  //ativa query e coloca em mode de inserção
  dsContratos.DataSet.Active := true;
  dsContratos.DataSet.Insert;
end;

procedure TfrmContrato.btnBuscarpessoaClick(Sender: TObject);
begin
  //chama a pesquisa de pessoa
  Application.CreateForm(TfrmPesquisaPessoas, frmPesquisaPessoas);
  frmPesquisaPessoas.showmodal;
  frmPesquisaPessoas.free;
end;

end.

