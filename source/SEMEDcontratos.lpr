program SEMEDcontratos;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, umain, dmMain, lazreportpdfexport;

{$R *.res}

begin
  Application.Initialize;
  RequireDerivedFormResource := True;
  Application.CreateForm(TDM1, DM1);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
