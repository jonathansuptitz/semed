program SEMEDcontratos;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, printer4lazarus, ULogin, uusuarios, uhtml, ubuscacontrato,
  udmcontratos, ufiltragem;

{$R *.res}

begin
  Application.Initialize;
  RequireDerivedFormResource := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmUsuarios, frmUsuarios);
  Application.Run;
end.
