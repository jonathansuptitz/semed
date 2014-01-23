unit ucontrato;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, LR_Class, LR_DBSet, LR_Desgn, Forms,
  Controls, Graphics, Dialogs, Buttons, ExtCtrls, DbCtrls, StdCtrls, EditBtn,
  Calendar, ZDataset;

type

  { TfrmContrato }

  TfrmContrato = class(TForm)
    BtnGerarcontrato: TBitBtn;
    BtnVoltar: TBitBtn;
    Button1: TButton;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
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
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure BtnGerarcontratoClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure edtFuncionarioButtonClick(Sender: TObject);
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
  dsContratos.DataSet.FieldByName('periodo_inicial_contrato').Value := DateEditinicial.GetDateFormat;
  dsContratos.DataSet.FieldByName('periodo_final_contrato').Value := DateEditinicial.GetDateFormat;
  //dsContratos.DataSet.FieldByName('data_contrato').Value := FormatDateTime(Now);

  dsContratos.DataSet.Post;

  dsContratos.DataSet.Filter := 'seila';

  //frReport1.LoadFromFile();
  frReport1.ShowPreparedReport;
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

procedure TfrmContrato.FormShow(Sender: TObject);
begin
  dsContratos.DataSet.Active := true;
  dsContratos.DataSet.Insert;
end;

procedure TfrmContrato.SpeedButton2Click(Sender: TObject);
begin
  Application.CreateForm(TfrmPesquisaPessoas, frmPesquisaPessoas);
  frmPesquisaPessoas.showmodal;
  frmPesquisaPessoas.free;
end;

end.

