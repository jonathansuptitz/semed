unit UCadastroMural;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  StdCtrls, ExtCtrls;

type

  { TfrmCadastroMural }

  TfrmCadastroMural = class(TForm)
    DBEdit1: TDBEdit;
    DBMemo1: TDBMemo;
    dsMural: TDatasource;
    BtnSalvar: TImage;
    BtnCancelar: TImage;
    Label1: TLabel;
    Label2: TLabel;
    labelRestantes: TLabel;
    Timer1: TTimer;
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure DBMemo1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCadastroMural: TfrmCadastroMural;

implementation

{$R *.lfm}

{ TfrmCadastroMural }

procedure TfrmCadastroMural.DBMemo1Change(Sender: TObject);
begin
  labelRestantes.Caption := 'Restantes: ' + IntToStr(200 - Length(DBMemo1.Text));
end;

procedure TfrmCadastroMural.FormCreate(Sender: TObject);
begin
  //dsMural.DataSet.Insert;
end;

procedure TfrmCadastroMural.BtnCancelarClick(Sender: TObject);
begin
  dsMural.DataSet.Cancel;
  Self.Close;
end;

procedure TfrmCadastroMural.BtnSalvarClick(Sender: TObject);
begin
  dsMural.DataSet.FieldByName('data_mural').Value := DateToStr(Date) + ' ' + TimeToStr(Time);
  dsMural.DataSet.Post;
end;

end.

