unit udmcontratos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, ZDataset;

type

  { TDMcontratos }

  TDMcontratos = class(TDataModule)
    dscargos: TDatasource;
    dscontratocargos: TDatasource;
    dshorario: TDatasource;
    dscidades: TDatasource;
    dsContratos: TDatasource;
    dslocaltrabalho: TDatasource;
    dspessoa: TDatasource;
    zt_horario: TZTable;
    zt_local_trabalho: TZTable;
    zt_pessoas: TZTable;
    zt_cargos: TZTable;
    zt_cidades: TZTable;
    zt_contratos: TZTable;
    zt_contratos_cargos: TZTable;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DMcontratos: TDMcontratos;

implementation

{$R *.lfm}

end.

