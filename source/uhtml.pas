unit uhtml;

{$mode objfpc}{$H+}

interface
uses
  Classes, udmcontratos, ucontrato, SysUtils;

type
  Thtml = class
  private

  public
    procedure editahtml(numlocal: byte);
  end;

var
  html: Thtml;

implementation

//prenche contrato em html
procedure Thtml.editahtml(numlocal: byte);
var
  texto : TStringList;
  pstl : string;
  y : integer;
  varlocal, varhorario : string;
begin

  //para varios locais
  if numlocal = 1 then
  begin
      varhorario := frmContrato.StringGrid1.Cells[1,1];
      varlocal := frmContrato.StringGrid1.Cells[0,1];
  end
  else if numlocal = 2 then
  begin
      varhorario := frmContrato.StringGrid1.Cells[1,1] +', '+ frmContrato.StringGrid1.Cells[1,2];
      varlocal := frmContrato.StringGrid1.Cells[0,1] +', '+ frmContrato.StringGrid1.Cells[0,2];
  end
  else if numlocal = 3 then
  begin
      varhorario := frmContrato.StringGrid1.Cells[1,1] +', '+ frmContrato.StringGrid1.Cells[1,2]
      + ', ' + frmContrato.StringGrid1.Cells[1,3];
      varlocal := frmContrato.StringGrid1.Cells[0,1] +', '+ frmContrato.StringGrid1.Cells[0,2]
      + ', ' + frmContrato.StringGrid1.Cells[0,3];
  end;
  //----
  try
    texto := TStringList.Create;
    texto.LoadFromFile('contrato.html');
    for y := 0 to texto.Count-1 do
    begin
      pstl := texto[y];//atribui uma linha da stringlist  na pstl

      texto[y] := StringReplace(pstl,'varnome',DMcontratos.dspessoa.DataSet.FieldByName('nome_pessoa').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varcargo',DMcontratos.dscargos.DataSet.FieldByName('nome_cargo').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varperiodoinicial',DMcontratos.dsContratos.DataSet.FieldByName('periodo_inicial_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varperiodofinal',DMcontratos.dsContratos.DataSet.FieldByName('periodo_final_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varlocal',varlocal,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varjornada',DMcontratos.dsContratos.DataSet.FieldByName('jornada_trabalho_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'vardata',DMcontratos.dsContratos.DataSet.FieldByName('data_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varanoseletivo',DMcontratos.dsContratos.DataSet.FieldByName('ano_seletivo_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varano',FormatDateTime('yyyy',now),[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varcodigocontrato',DMcontratos.dsContratos.DataSet.FieldByName('codigo_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varnacionalidade',DMcontratos.dspessoa.DataSet.FieldByName('nacionalidade_pessoa').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varestadocivil',DMcontratos.dspessoa.DataSet.FieldByName('estado_civil_pessoa').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varrg',DMcontratos.dspessoa.DataSet.FieldByName('rg_pessoa').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varcpf',DMcontratos.dspessoa.DataSet.FieldByName('cpf_pessoa').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varendereco',DMcontratos.dspessoa.DataSet.FieldByName('endereco_pessoa').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varbairro',DMcontratos.dspessoa.DataSet.FieldByName('bairro_pessoa').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varcidade',DMcontratos.dscidades.DataSet.FieldByName('nome_cidade').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varjustificativa',DMcontratos.dsContratos.DataSet.FieldByName('justificativa_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varcargahoraria',DMcontratos.dsContratos.DataSet.FieldByName('jornada_trabalho_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varcpfteste1',DMcontratos.dsContratos.DataSet.FieldByName('cpf_teste_1_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'vartestemunha1',DMcontratos.dsContratos.DataSet.FieldByName('testemunha_1_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varcpfteste2',DMcontratos.dsContratos.DataSet.FieldByName('cpf_teste_2_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'vartestemunha2',DMcontratos.dsContratos.DataSet.FieldByName('testemunha_2_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varclausula',DMcontratos.dscargos.DataSet.FieldByName('clausula_primeira_cargo').value,[rfIgnoreCase,rfReplaceAll]);

      //observaçao contrato
      if frmContrato.DBMemoobs.text = '' then
        texto[y] := StringReplace(pstl,'varobs','______________________________'+
        '______________________________________________________________________'+
        '______________________________________________________________________'+
        '______________________________________________________________________'+
        '________',[rfIgnoreCase,rfReplaceAll])
      else
        texto[y] := StringReplace(pstl,'varobs',DMcontratos.dsContratos.DataSet.FieldByName('obs_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      //----

      texto[y] := StringReplace(pstl,'varhorario',varhorario,[rfIgnoreCase,rfReplaceAll]);

      if frmContrato.DBComboBox1.Text = 'Seletivo' then
        texto[y] := StringReplace(pstl,'var1','X',[rfIgnoreCase,rfReplaceAll])
      else if frmContrato.DBComboBox1.Text = 'Cadastro RH' then
        texto[y] := StringReplace(pstl,'var2','X',[rfIgnoreCase,rfReplaceAll])
      else if frmContrato.DBComboBox1.Text = 'Contratação Direta' then
        texto[y] := StringReplace(pstl,'var3','X',[rfIgnoreCase,rfReplaceAll]);

    end;
    texto.SaveToFile('contratoatual.html');
  finally
    texto.Free;
  end;
end;
// FIM -------------------------------------------------------------------------

end.

