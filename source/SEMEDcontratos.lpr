program SEMEDcontratos;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, ULogin, uhtml;

{$R *.res}

begin
  Application.Initialize;
  RequireDerivedFormResource := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
