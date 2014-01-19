unit dmMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection;

type

  { TDM1 }

  TDM1 = class(TDataModule)
    SEMEDconnection: TZConnection;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DM1: TDM1;

implementation

{$R *.lfm}

end.

