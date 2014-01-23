unit ucontrato;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, LR_Class, LR_DBSet, LR_Desgn, lr_e_pdf,
  Forms, Controls, Graphics, Dialogs, Buttons, ExtCtrls, DbCtrls, StdCtrls,
  EditBtn;

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
    procedure Button1Click(Sender: TObject);
    procedure edtFuncionarioButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
  //adiciona periodos do contrato
  dsContratos.DataSet.FieldByName('periodo_inicial_contrato').Value := DateEditinicial.GetDateFormat;
  dsContratos.DataSet.FieldByName('periodo_final_contrato').Value := DateEditinicial.GetDateFormat;

  //pegar ano atual
  dsContratos.DataSet.FieldByName('data_contrato').Value := FormatDateTime('aaaa', Date);

  dsContratos.DataSet.Post;

  //cria o contrato
  frReport1.LoadFromFile('contrato.lrf');
  frReport1.PrepareReport;
  frReport1.ShowPreparedReport;

  //salva copia pdf
  frReport1.SavePreparedReport(frmPesquisaPessoas.dsPessoas.DataSet.FieldByName('nome_pessoa').value + FormatDateTime('aaaa', Date)+'.pdf');
end;

procedure TfrmContrato.Button1Click(Sender: TObject);
begin
  frReport1.DesignReport;
end;

procedure TfrmContrato.edtFuncionarioButtonClick(Sender: TObject);
begin
  application.CreateForm(TfrmPesquisaPessoas, frmPesquisaPessoas);
  frmPesquisaPessoas.showmodal;
  frmPesquisaPessoas.free;
end;

procedure TfrmContrato.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  dsContratos.DataSet.Cancel;
end;

procedure TfrmContrato.FormCreate(Sender: TObject);
begin

end;

procedure TfrmContrato.FormShow(Sender: TObject);
begin
  dsContratos.DataSet.Active := true;
  dsContratos.DataSet.Append;

  DBEdit4.Text := '2012'; //ano padrao seletivo
end;

procedure TfrmContrato.SpeedButton2Click(Sender: TObject);
begin
  Application.CreateForm(TfrmPesquisaPessoas, frmPesquisaPessoas);
  frmPesquisaPessoas.showmodal;
  frmPesquisaPessoas.free;
end;

end.

