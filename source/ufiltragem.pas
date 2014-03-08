unit ufiltragem;

{$mode objfpc}{$H+}

interface

uses
  Classes, db, SysUtils;

type
  Tfiltragem = class

  private

  public
    procedure filtrads(parametro: string; dsnome : string);
  end;

var
  filtragem : Tfiltragem;

implementation

uses udmcontratos;

// filtra campos do contrato q nao estao na table contrato
procedure Tfiltragem.filtrads(parametro: string; dsnome : string);
var
  ds : TDataSource;
begin
  ds.FindComponent('DMcontratos.'+dsnome);

  ds.dataset.active:= true;

  ds.dataset.filter := parametro;
  ds.DataSet.Filtered:=true;
end;

end.

