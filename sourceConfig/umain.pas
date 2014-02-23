unit UMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    BtnSalvar: TBitBtn;
    BtnCancelar: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Panel2: TPanel;
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure Criptografar;
    procedure Descriptografar;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmMain: TfrmMain;
  SL, SLdescript: TStringList;

implementation

{$R *.lfm}

{ TfrmMain }

// INICIO ----------------------------------------------------------------------

procedure TfrmMain.FormShow(Sender: TObject);
begin
  SLdescript := TStringList.Create;
  SL := TStringList.Create;
  SL.LoadFromFile('conf/db.cfg');

  Descriptografar;
end;

// BOTOES ----------------------------------------------------------------------

procedure TfrmMain.BtnSalvarClick(Sender: TObject);           // Salvar
begin
  Criptografar;
  ShowMessage('Configurações salvas com sucesso!');
end;

procedure TfrmMain.BtnCancelarClick(Sender: TObject);         // Cancelar
begin
  Descriptografar;
end;

// PROCEDURES ------------------------------------------------------------------

procedure TfrmMain.Criptografar;                      // Criptografar
var
  i, x, caracCript : integer;
  linha, linhaCript: string;
begin
  SLdescript.Clear;
  SLdescript.Add(Edit1.Text);
  SLdescript.Add(Edit2.Text);
  SLdescript.Add(Edit3.Text);
  SLdescript.Add(Edit4.Text);

  for x := 0 to SLdescript.Count - 1 do // Varre linha a linha
  begin
    caracCript := 0;
    linhaCript := '';
    for i := 1 to Length(SLdescript[x]) do  // Varre caracter a caracter
    begin
      linha := SLdescript[x];

      // Descriptografa caractere
      caracCript := (Ord(linha[i]) +3) *3;
      //Adiciona a linha geral
      linhaCript := linhaCript + IntTOStr(caracCript) + ';';
    end;
    SL.Add(linhaCript);
  end;

  DeleteFile('conf/db.cfg');
  SL.SaveToFile('conf/db.cfg');
end;

procedure TfrmMain.Descriptografar;                   // Descriptografar
var
  i, x : integer;
  caracCript, linha, linhaDescript : string;
  caracDescript : char;
begin
  for x := 0 to SL.Count - 1 do // Varre linha a linha
  begin
    caracCript := '';
    caracDescript := #0;
    linhaDescript := '';
    for i := 1 to Length(SL[x]) do  // Varre caracter a caracter
    begin
      linha := SL[x];

      if linha[i] = ';' then   // Se for ";" converte para char
      begin
        // Descriptografa caractere
        caracDescript := Char(trunc((StrToInt(caracCript) / 3) - 3));
        //Adiciona a linha geral
        linhaDescript := linhaDescript + caracDescript;
        // Zera var que junta numeros que formam asc
        caracCript := '';
      end
      else
      begin
        caracCript := caracCript + linha[i]; // junta numeros ate encontrar ";"
      end;
    end;
    SLDescript.Add(linhaDescript);
  end;

  Edit1.Text := SLDescript[0];
  Edit2.Text := SLDescript[1];
  Edit3.Text := SLDescript[2];
  Edit4.Text := SLDescript[3];
end;

// FIM -------------------------------------------------------------------------

procedure TfrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SLdescript.Free;
  SL.Free;
  Application.Terminate;
end;

end.

