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
    DBComboBox1: TDBComboBox;
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
    SpeedButton2: TSpeedButton;
    procedure BtnGerarcontratoClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure edtFuncionarioButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure frReport1GetValue(const ParName: String; var ParValue: Variant);
    procedure SpeedButton2Click(Sender: TObject);
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

procedure TfrmContrato.BtnGerarcontratoClick(Sender: TObject);
begin
  //adiciona demais campos tabela contrato
  //dsContratos.DataSet.FieldByName('periodo_inicial_contrato').Value := DateEditinicial.GetDateFormat;
  //dsContratos.DataSet.FieldByName('periodo_final_contrato').Value := DateEditinicial.GetDateFormat;
  //dsContratos.DataSet.FieldByName('data_contrato').Value := FormatDateTime('aaaa', Date);

  //dsContratos.DataSet.Post; //posta

  frReport1.Variables.Add('VarDatainicial');
  frVariables['VarDatainicial']:= DateEditinicial.text;

  frReport1.LoadFromFile('contrato.lrf');
  frReport1.PrepareReport;
  //frReport1.SavePreparedReport(frmPesquisaPessoas.dsPessoas.DataSet.FieldByName('nome_pessoa').Value+'.pdf');
  frReport1.ShowPreparedReport;

end;

procedure TfrmContrato.edtFuncionarioButtonClick(Sender: TObject);
begin
  application.CreateForm(TfrmPesquisaPessoas, frmPesquisaPessoas);
  frmPesquisaPessoas.showmodal;
  frmPesquisaPessoas.free;
end;

procedure TfrmContrato.FormShow(Sender: TObject);
begin
  dsContratos.DataSet.Active := true;
  dsContratos.DataSet.Insert;
end;

procedure TfrmContrato.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
    if ParName = 'VarDatainicial' then
      ParValue := DateEditinicial.text;
end;

procedure TfrmContrato.SpeedButton2Click(Sender: TObject);
begin
  Application.CreateForm(TfrmPesquisaPessoas, frmPesquisaPessoas);
  frmPesquisaPessoas.showmodal;
  frmPesquisaPessoas.free;
end;

end.

