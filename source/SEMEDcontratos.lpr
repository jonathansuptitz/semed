program SEMEDcontratos;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, Umain, ucontrato, uCadastroPessoas, dmMain,
  SysUtils, Dialogs, uPesquisaPessoas;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  try
    Application.CreateForm(TDM1, DM1);
    Application.Initialize;
    Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TfrmPesquisaPessoas, frmPesquisaPessoas);
    Application.Run;
  except
    on E: exception do
    begin
      ShowMessage('Erro ao abrir sistema! Contate o administrador.');
      Application.Terminate;
    end;
  end;
end.

