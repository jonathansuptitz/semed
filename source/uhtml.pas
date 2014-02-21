unit uhtml;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Ipfilebroker, IpHtml, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,OSPrinters,printers , PrintersDlgs, Buttons;

type

  { Tfrmhtml }

  Tfrmhtml = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    btnimprimir: TBitBtn;
    IpFileDataProvider1: TIpFileDataProvider;
    IpHtmlPanel1: TIpHtmlPanel;
    Panel1: TPanel;
    PrinterSetupDialog1: TPrinterSetupDialog;
    procedure BitBtn2Click(Sender: TObject);
    procedure btnimprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmhtml: Tfrmhtml;

implementation

{$R *.lfm}

{ Tfrmhtml }

procedure Tfrmhtml.FormShow(Sender: TObject);
begin

end;

procedure Tfrmhtml.BitBtn2Click(Sender: TObject);
begin
  frmhtml.close;
end;

procedure Tfrmhtml.btnimprimirClick(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    IpHtmlPanel1.PrintPreview;
end;

end.

