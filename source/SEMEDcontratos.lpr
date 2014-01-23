program SEMEDcontratos;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Umain, dmMain, lazreportpdfexport, UCadastroLocalTrabalho;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.CreateForm(TDM1, DM1);
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TfrmCadastroLocalTrabalho, frmCadastroLocalTrabalho);
  Application.Run;
end.
