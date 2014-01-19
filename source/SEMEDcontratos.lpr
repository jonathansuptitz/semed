program SEMEDcontratos;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, Umain, ucontrato, uCadastroPessoas, dmMain, SysUtils;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.CreateForm(TDM1, DM1);
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.

