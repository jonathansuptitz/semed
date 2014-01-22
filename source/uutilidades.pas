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

      procedure VerifCPF(campo : Tcomponent);  {Verrificar CPF, parametros: componente.
                Utilizar no evento "OnExit"    ex: utilidades.VerifCPF(Edit2);
                                               }

      procedure MascCPF(campo : TComponent; var Key : char); {Mascara CPF, parametros: componente,
                Utilizar no evento "OnKeyPress"               Key do procedure.
                                                              ex: utilidades.MascCPF(Edit1, Key);
                                                              }

      procedure MascFone(campo : Tcomponent; var Key : char); {Mascara FONE, parametros: componente,
                Utilizar no evento "OnKeyPress"               Key do procedure.
                                                              ex: utilidades.MascFone(Edit2, Key);
                                                              }

      procedure MascRG(campo : Tcomponent; var Key : char);   {Mascara RG, parametros: componente,
                Utilizar no evento "OnKeyPress"               Key do procedure.
                                                              ex: utilidades.MascRG(Edit2, Key);
                                                              }

      procedure MascData(campo : Tcomponent; var key : char); {Mascara Data, parametros: componente,
                Utilizar no evento "OnKeyPress"               Key do procedure.
                                                              ex: utilidades.MascDATA(Edit2, Key);
                                                              }

      procedure MascAno(campo : Tcomponent; var key : char); {Mascara Ano, parametros: componente,
                Utilizar no evento "OnKeyPress"               Key do procedure.
                                                              ex: utilidades.MascAno(Edit2, Key);
                                                              }

      procedure MascCEP(campo : Tcomponent; var key : char); {Mascara CEP, parametros: componente,
                Utilizar no evento "OnKeyPress"               Key do procedure.
                                                              ex: utilidades.MascCEP(Edit2, Key);
                                                              }

  end;

var
  Utilidades : TUtilidades;

implementation

procedure TUtilidades.VerifCPF(campo : Tcomponent);
var
  x : byte;
  z, primeiro, segundo : integer;
  a, numero : string;
begin
  // Se componente for DBedit
  if campo.ClassName = 'TDBEdit' then
  begin
    numero := (campo as TDBEdit).Text;
    if not (numero = '') then
    begin
      if (LengTh(numero) < 14) then
      begin
        (campo as TDBEdit).Color := clRed;
        ShowMessage('CPF incorreto!');
        (campo as TDBEdit).SetFocus;
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
        begin        {DVs nao conferem}
          (campo as TDBEdit).Color := clRed;
          ShowMessage('CPF incorreto!');
          (campo as TDBEdit).SetFocus;
        end
        else         {DV OK}
          (campo as TDBEdit).Color := clDefault;
      end;
    end;
  end
  // Se componente for Edit
  else if campo.ClassName = 'TEdit' then
  begin
    numero := (campo as TEdit).Text;
    if not (numero = '') then
    begin
      if (LengTh(numero) < 14) then
      begin
        (campo as TEdit).Color := clRed;
        ShowMessage('CPF incorreto!');
        (campo as TEdit).SetFocus;
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
        begin        {DVs nao conferem}
          (campo as TEdit).Color := clRed;
          ShowMessage('CPF incorreto!');
          (campo as TEdit).SetFocus;
        end
        else         {DV OK}
          (campo as TEdit).Color := clDefault;
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
        (campo as TDBEdit).text := (campo as TDBEdit).text + '.'
      else if LengTh((campo as TDBEdit).text) = 7 then
        (campo as TDBEdit).text := (campo as TDBEdit).text + '.'
      else if LengTh((campo as TDBEdit).text) = 11 then
        (campo as TDBEdit).text := (campo as TDBEdit).text + '-'
      else if (LengTh((campo as TDBEdit).text) = 14) then
        Key := #0{nil};
    end
    else if campo.ClassName = 'TEdit' then                      // Edit
    begin
      if LengTh((campo as TEdit).text) = 3 then
        (campo as TEdit).text := (campo as TEdit).text + '.'
      else if LengTh((campo as TEdit).text) = 7 then
        (campo as TEdit).text := (campo as TEdit).text + '.'
      else if LengTh((campo as TEdit).text) = 11 then
        (campo as TEdit).text := (campo as TEdit).text + '-'
      else if (LengTh((campo as TEdit).text) = 14) then
        Key := #0{nil};
    end;

    (campo as TDBEdit).SelStart := LengTh((campo as TDBEdit).Text);
  end;
end;

procedure TUtilidades.MascFone(campo : Tcomponent; var Key : char);
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil};
  //
  if (Key <> #8{backspace}) then
  begin
    if campo.ClassName = 'TDBEdit' then
    begin
      if LengTh((campo as TDBEdit).text) = 0 then
        (campo as TDBEdit).text := (campo as TDBEdit).text + '('
      else if LengTh((campo as TDBEdit).text) = 3 then
        (campo as TDBEdit).text := (campo as TDBEdit).text + ')'
      else if LengTh((campo as TDBEdit).text) = 8 then
        (campo as TDBEdit).text := (campo as TDBEdit).text + '-'
      else if LengTh((campo as TDBEdit).text) = 14 then
        Key := #0 {nil};
    end
    else if campo.ClassName = 'TEdit' then
    begin
      if LengTh((campo as TEdit).text) = 0 then
        (campo as TEdit).text := (campo as TEdit).text + '('
      else if LengTh((campo as TEdit).text) = 3 then
        (campo as TEdit).text := (campo as TEdit).text + ')'
      else if LengTh((campo as TEdit).text) = 8 then
        (campo as TEdit).text := (campo as TEdit).text + '-'
      else if LengTh((campo as TEdit).text) = 14 then
        Key := #0 {nil};
    end;

    (campo as TDBEdit).SelStart := LengTh((campo as TDBEdit).Text);
  end;
end;

procedure TUtilidades.MascRG(campo : Tcomponent; var Key : char);
begin
  if not (Key in ['0'..'9', #8{backspace}, '.', '-', '/']) then
    Key := #0{nil};
end;

procedure TUtilidades.MascData(campo : Tcomponent; var key : char);
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil};
  //
  if (Key <> #8{backspace}) then
  begin
    if campo.ClassName = 'TDBEdit' then
    begin
      if LengTh((campo as TDBEdit).text) = 2 then
        (campo as TDBEdit).text := (campo as TDBEdit).text + '/'
      else if LengTh((campo as TDBEdit).text) = 5 then
        (campo as TDBEdit).text := (campo as TDBEdit).text + '/'
      else if LengTh((campo as TDBEdit).text) = 10 then
        Key := #0 {nil};
    end
    else if campo.ClassName = 'TEdit' then
    begin
      if LengTh((campo as TEdit).text) = 2 then
        (campo as TEdit).text := (campo as TEdit).text + '/'
      else if LengTh((campo as TEdit).text) = 5 then
        (campo as TEdit).text := (campo as TEdit).text + '/'
      else if LengTh((campo as TEdit).text) = 10 then
        Key := #0 {nil};
    end;

    (campo as TDBEdit).SelStart := LengTh((campo as TDBEdit).Text);
  end;
end;

procedure TUtilidades.MascAno(campo : Tcomponent; var key : char);
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil}
  else
  begin
    if campo.ClassName = 'TDBEdit' then
    begin
      if LengTh((campo as TDBEdit).text) = 4 then
        Key := #0{nil};
    end
    else if campo.ClassName = 'TEdit' then
    begin
      if LengTh((campo as TEdit).text) = 4 then
        Key := #0{nil};
    end;
  end;
end;

procedure TUtilidades.MascCEP(campo : Tcomponent; var key : char);
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil};
  //
  if (Key <> #8{backspace}) then
  begin
    if campo.ClassName = 'TDBEdit' then
    begin
      if LengTh((campo as TDBEdit).text) = 5 then
        (campo as TDBEdit).text := (campo as TDBEdit).text + '-'
      else if (LengTh((campo as TDBEdit).text) = 9) then
        Key := #0{nil};
    end
    else if campo.ClassName = 'TEdit' then
    begin
      if LengTh((campo as TEdit).text) = 5 then
        (campo as TEdit).text := (campo as TEdit).text + '-'
      else if (LengTh((campo as TEdit).text) = 9) then
        Key := #0{nil};
    end;

    (campo as TDBEdit).SelStart := LengTh((campo as TDBEdit).Text);
  end;
end;

end.

