unit uhtml;

{$mode objfpc}{$H+}

interface
uses
  Classes, udmcontratos,  FileUtil, DbCtrls, Printers, IpHtml,
  Ipfilebroker, ExtCtrls, ucontrato, ufiltragem, SysUtils, Controls, LCLIntf;




type
  Thtml = class
  private

  public
    procedure editahtml;
  end;

var
  html: Thtml;

implementation

//prenche contrato em html
procedure Thtml.editahtml;
var
  texto : TStringList;
  pstl : string;
  y, x : integer;
  varlocal, varhorario: string;
begin
  varlocal:= '';
  varhorario:= '';

  //atribui os locais e horarios nas variaveis
  filtragem.filtrads('codigo_contrato = '+ DMcontratos.dscontratos.DataSet.FieldByName('codigo_contrato').AsString, 'dscontratoslocais');

  with DMcontratos.dscontratoslocais.DataSet do
  begin
    for x := 1 to FieldCount do
    begin
      filtragem.filtrads('codigo_local_trabalho = '+ FieldByName('codigo_local_trabalho').AsString, 'dslocaltrabalho');

      varlocal := varlocal+ DMcontratos.dslocaltrabalho.DataSet.FieldByName('nome_local_trabalho').AsString+ ', ';

      varhorario := varhorario + FieldByName('horario_local_trabalho').AsString + ', ';

      Next;
    end;
   end;
  //----
  //substitui variaveis do html
  try
    texto := TStringList.Create;
    texto.LoadFromFile('contrato.html');
    for y := 0 to texto.Count-1 do
    begin
      pstl := texto[y];//atribui uma linha da stringlist  na pstl

      texto[y] := StringReplace(pstl,'varnome',DMcontratos.dspessoa.DataSet.FieldByName('nome_pessoa').AsString,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varcargo',DMcontratos.dscargos.DataSet.FieldByName('nome_cargo').AsString,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varperiodoinicial',DMcontratos.dsContratos.DataSet.FieldByName('periodo_inicial_contrato').AsString,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varperiodofinal',DMcontratos.dsContratos.DataSet.FieldByName('periodo_final_contrato').AsString,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varlocal',varlocal,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varjornada',DMcontratos.dsContratos.DataSet.FieldByName('jornada_trabalho_contrato').AsString,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'vardata',DMcontratos.dsContratos.DataSet.FieldByName('data_contrato').AsString,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varanoseletivo',DMcontratos.dsContratos.DataSet.FieldByName('ano_seletivo_contrato').AsString,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varano',FormatDateTime('yyyy',now),[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varcodigocontrato',DMcontratos.dsContratos.DataSet.FieldByName('codigo_contrato').AsString,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varnacionalidade',DMcontratos.dspessoa.DataSet.FieldByName('nacionalidade_pessoa').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varestadocivil',DMcontratos.dspessoa.DataSet.FieldByName('estado_civil_pessoa').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varrg',DMcontratos.dspessoa.DataSet.FieldByName('rg_pessoa').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varcpf',DMcontratos.dspessoa.DataSet.FieldByName('cpf_pessoa').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varendereco',DMcontratos.dspessoa.DataSet.FieldByName('endereco_pessoa').AsString,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varbairro',DMcontratos.dspessoa.DataSet.FieldByName('bairro_pessoa').AsString,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varcidade',DMcontratos.dscidades.DataSet.FieldByName('nome_cidade').AsString,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varjustificativa',DMcontratos.dsContratos.DataSet.FieldByName('justificativa_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varcargahoraria',DMcontratos.dsContratos.DataSet.FieldByName('jornada_trabalho_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varcpfteste1',DMcontratos.dsContratos.DataSet.FieldByName('cpf_teste_1_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'vartestemunha1',DMcontratos.dsContratos.DataSet.FieldByName('testemunha_1_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varcpfteste2',DMcontratos.dsContratos.DataSet.FieldByName('cpf_teste_2_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'vartestemunha2',DMcontratos.dsContratos.DataSet.FieldByName('testemunha_2_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varclausula',DMcontratos.dscargos.DataSet.FieldByName('clausula_primeira_cargo').value,[rfIgnoreCase,rfReplaceAll]);

      //observaçao contrato
      if DMcontratos.dsContratos.DataSet.FieldByName('obs_contrato').value = Null then
        texto[y] := StringReplace(pstl,'varobs','______________________________'+
        '______________________________________________________________________'+
        '______________________________________________________________________'+
        '______________________________________________________________________'+
        '________',[rfIgnoreCase,rfReplaceAll])
      else
        texto[y] := StringReplace(pstl,'varobs',DMcontratos.dsContratos.DataSet.FieldByName('obs_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      //----

      texto[y] := StringReplace(pstl,'varhorario',varhorario,[rfIgnoreCase,rfReplaceAll]);

      if DMcontratos.dsContratos.DataSet.FieldByName('tipo_contratacao_contrato').AsString = 'Seletivo' then
      begin
        texto[y] := StringReplace(pstl,'var1','X',[rfIgnoreCase,rfReplaceAll]);
        texto[y] := StringReplace(pstl,'var2','  ',[rfIgnoreCase,rfReplaceAll]);
        texto[y] := StringReplace(pstl,'var3','  ',[rfIgnoreCase,rfReplaceAll]);
      end
      else if DMcontratos.dsContratos.DataSet.FieldByName('tipo_contratacao_contrato').AsString = 'Cadastro RH' then
      begin
        texto[y] := StringReplace(pstl,'var1','  ',[rfIgnoreCase,rfReplaceAll]);
        texto[y] := StringReplace(pstl,'var3','  ',[rfIgnoreCase,rfReplaceAll]);
        texto[y] := StringReplace(pstl,'var2','X',[rfIgnoreCase,rfReplaceAll]);
      end
      else if DMcontratos.dsContratos.DataSet.FieldByName('tipo_contratacao_contrato').AsString = 'Contratação Direta' then
      begin
        texto[y] := StringReplace(pstl,'var3','X',[rfIgnoreCase,rfReplaceAll]);
        texto[y] := StringReplace(pstl,'var1','  ',[rfIgnoreCase,rfReplaceAll]);
        texto[y] := StringReplace(pstl,'var2','  ',[rfIgnoreCase,rfReplaceAll]);
      end;

    end;
    texto.SaveToFile('contratoatual.html');

  finally
    texto.Free;

    OpenURL(expandLocalHtmlFileName('contratoatual.html'));
  end;
end;
// FIM -------------------------------------------------------------------------

end.

