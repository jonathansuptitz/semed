unit dmMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection, ZDataset,
  Forms, Controls, Graphics, Dialogs;

type

  { TDM1 }

  TDM1 = class(TDataModule)
    SEMEDconnection: TZConnection;
    tb_pessoas: TZTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DM1: TDM1;

implementation

{$R *.lfm}

{ TDM1 }


{
procedure TDM1.DataModuleCreate(Sender: TObject);
begin
  try
    SEMEDconnection.Connect;
  except
    on E: Exception do
    begin
        if (E.ClassName = 'EZSQLException') then
        begin
          E.Message:='Erro ao conectar ao Banco de dados! Contate o administrador do sistema.';
          ShowMessage('teste');
        end;
    end;
  end;
end;
}

procedure TDM1.DataModuleCreate(Sender: TObject);
var
  SLcfg : TStringList;
begin
  try
    // Carrega arquivo cfg
    SLcfg := TStringList.Create;
    SLcfg.LoadFromFile('conf/db.cfg');
    // Le informações
    SEMEDconnection.Database := SLcfg[0];
    SEMEDconnection.HostName := SLcfg[1];
    SEMEDconnection.User := SLcfg[2];
    SEMEDconnection.Password := SLcfg[3];
    // Conecta ao banco
    SEMEDconnection.Connected := true;
  finally
    SLcfg.Free;
  end;
end;

end.

