unit uCadastroPessoas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  StdCtrls, ExtCtrls, Buttons;

type

  { TfrmCadastroPessoas }

  TfrmCadastroPessoas = class(TForm)
    BtnVoltar: TBitBtn;
    comboUF: TComboBox;
    DBEdit32: TDBEdit;
    DBMemo1: TDBMemo;
    dsCidades: TDatasource;
    DBComboBox1: TDBComboBox;
    DBEdit1: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit21: TDBEdit;
    DBEdit22: TDBEdit;
    DBEdit23: TDBEdit;
    DBEdit24: TDBEdit;
    DBEdit25: TDBEdit;
    DBEdit26: TDBEdit;
    DBEdit27: TDBEdit;
    DBEdit28: TDBEdit;
    DBEdit29: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit31: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    dsPessoas: TDatasource;
    GroupBox1: TGroupBox;
    GroupBox10: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    procedure BtnVoltarClick(Sender: TObject);
    procedure comboUFChange(Sender: TObject);
    procedure GroupBox3Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCadastroPessoas: TfrmCadastroPessoas;

implementation

uses
  dmMain;

{$R *.lfm}

{ TfrmCadastroPessoas }

// Carrega Lista de Cidades comforme UF
procedure TfrmCadastroPessoas.comboUFChange(Sender: TObject);
begin
  try
    try
      DM1.queryCADASTROPESSOAScidades.Active := true;
    except
      ShowMessage('Erro ao abrir tela!');
      frmCadastroPessoas.Close;
    end;
    DM1.queryCADASTROPESSOAScidades.Close;
    DM1.queryCADASTROPESSOAScidades.SQL.Clear;
    DM1.queryCADASTROPESSOAScidades.SQL.Add('SELECT * FROM tb_cidades WHERE uf_cidade = "'+comboUF.Text+'"');
    DM1.queryCADASTROPESSOAScidades.Open;
  except
    ShowMessage('Erro ao abrir tela!');
    frmCadastroPessoas.Close;
  end;
end;

procedure TfrmCadastroPessoas.BtnVoltarClick(Sender: TObject);
begin
  self.Close;
end;

end.

