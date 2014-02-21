unit uhtml;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Ipfilebroker, IpHtml, Forms, Controls, Graphics,
  Dialogs, ExtCtrls;

type

  { Tfrmhtml }

  Tfrmhtml = class(TForm)
    IpFileDataProvider1: TIpFileDataProvider;
    IpHtmlPanel1: TIpHtmlPanel;
    Panel1: TPanel;
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
  IpHtmlPanel1.OpenURL(expandLocalHtmlFileName('cotrato.html'));
end;

end.

