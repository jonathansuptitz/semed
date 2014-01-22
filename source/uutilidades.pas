unit UUtilidades;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, DbCtrls, StdCtrls;

type
  TUtilidades = class
    private
      { private declarations }
    public
      { public declarations }

      function VerifCPF(numero : string) : boolean;  {Verrificar CPF, parametros: string a ser testado.
                Utilizar no evento "OnExit"           ex: utilidades.VerifCPF(Edit1.text);
                A ser implementado                    }

      procedure MascCPF(campo : TComponent; var Key : char); {Mascara CPF, parametros: componente,
                Utilizar no evento "OnKeyPress"               Key do procedure.
                                                              ex: utilidades.MascCPF(Edit1, Key);
                                                              }
  end;

var
  Utilidades : TUtilidades;

implementation

function TUtilidades.VerifCPF(numero : string) : boolean;
var
  x : byte;
  z, primeiro, segundo : integer;
  a : string;
begin
  if not (numero = '') then
  begin
    if (LengTh(numero) < 14) then
    begin
      Result := false;
    end
    else
    begin
      // Primeiro DV ----------------------------------------
      primeiro := 0;
      z := 1;
      for x := 1 to 11 do
      begin
        a := Copy(numero, x, 1);
        if (a <> '.') and (a <> '-') then
        begin
          primeiro := primeiro + (StrToInt(a) * z);
          z := z + 1;
        end;
      end;
      primeiro := primeiro mod 11;
      if primeiro = 10 then
        primeiro := 0;
      //
      // Segundo DV ------------------------------------------
      segundo := 0;
      z := 0;
      for x := 1 to 11 do
      begin
        a := Copy(numero, x, 1);
        if (a <> '.') and (a <> '-') then
        begin
          segundo := segundo + (StrToInt(a) * z);
          z := z + 1;
        end;
      end;
      segundo := (segundo + (primeiro * 9)) mod 11;
      if segundo = 10 then
        segundo := 0;
      //
      // Verificação ------------------------------------------
      if (primeiro <> StrToInt(numero[13])) or (segundo <> StrToInt(numero[14])) then
      begin
        Result := false;
      end
      else
      begin
        Result := true;
      end;
    end;
  end;
end;

procedure TUtilidades.MascCPF(campo : TComponent; var Key : char);
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil};
  //
  if (Key <> #8{backspace}) then
  begin
    if campo.ClassName = 'TDBEdit' then                         // Verifica tipo de campo : DBEdit
      begin
      if LengTh((campo as TDBEdit).text) = 3 then
      begin
        (campo as TDBEdit).text := (campo as TDBEdit).text + '.';
        (campo as TDBEdit).SelStart := LengTh((campo as TDBEdit).Text);
      end
      else if LengTh((campo as TDBEdit).text) = 7 then
      begin
        (campo as TDBEdit).text := (campo as TDBEdit).text + '.';
        (campo as TDBEdit).SelStart := LengTh((campo as TDBEdit).Text);
      end
      else if LengTh((campo as TDBEdit).text) = 11 then
      begin
        (campo as TDBEdit).text := (campo as TDBEdit).text + '-';
        (campo as TDBEdit).SelStart := LengTh((campo as TDBEdit).Text);
      end
      else if (LengTh((campo as TDBEdit).text) = 14) then
      begin
        Key := #0{nil};
      end;
    end
    else if campo.ClassName = 'TEdit' then                        // Edit
      begin
      if LengTh((campo as TEdit).text) = 3 then
      begin
        (campo as TEdit).text := (campo as TEdit).text + '.';
        (campo as TEdit).SelStart := LengTh((campo as TEdit).Text);
      end
      else if LengTh((campo as TEdit).text) = 7 then
      begin
        (campo as TEdit).text := (campo as TEdit).text + '.';
        (campo as TEdit).SelStart := LengTh((campo as TEdit).Text);
      end
      else if LengTh((campo as TEdit).text) = 11 then
      begin
        (campo as TEdit).text := (campo as TEdit).text + '-';
        (campo as TEdit).SelStart := LengTh((campo as TEdit).Text);
      end
      else if (LengTh((campo as TEdit).text) = 14) then
      begin
        Key := #0{nil};
      end;
    end;
  end;
end;

end.

