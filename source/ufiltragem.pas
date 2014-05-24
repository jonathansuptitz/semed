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

{ filtra as tables do dmcontrato,
  'dsnome': o nome do  data source a ser filtrado,
  'parametro': a string passada para a opçao filter do datasource

  ex. filtragem.filtrads('codigo_contrato = ''' + edt1.text + '''', 'dscontrato')}

procedure Tfiltragem.filtrads(parametro: string; dsnome : string);
var
  ds : TDataSource;
begin
  ds := TDataSource.Create(nil);
  ds := TDataSource(DMcontratos.FindComponent(dsnome));

  ds.dataset.active:= true;
  ds.DataSet.Refresh;

  ds.dataset.filter := parametro;
  ds.DataSet.Filtered:=true;
end;

end.

