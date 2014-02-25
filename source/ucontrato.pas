unit ucontrato;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Ipfilebroker, IpHtml,
 Forms, Controls, Graphics,
  Dialogs, Buttons, ExtCtrls, LCLIntf,
  DbCtrls, StdCtrls, EditBtn, Printers, Grids, LCLType;

type

  { TfrmContrato }

  TfrmContrato = class(TForm)
    BtnGerarcontrato: TBitBtn;
    btnlimparlocais: TBitBtn;
    Btnadicionalocal: TBitBtn;
    BtnVoltar: TBitBtn;
    Button1: TButton;
    dscidades: TDatasource;
    DBComboBox1: TDBComboBox;
    DBEdtcargo: TDBEdit;
    DBEdtcpftest2: TDBEdit;
    DBEdtcpfteste1: TDBEdit;
    DBEdttest2: TDBEdit;
    DBEdtteste1: TDBEdit;
    DBEdthorario: TDBEdit;
    dspessoa: TDatasource;
    dslocal: TDatasource;
    dscargos: TDatasource;
    DBEdtJornada: TDBEdit;
    DBEdtFuncionario: TDBEdit;
    DBEdtAnoseletivo: TDBEdit;
    DBMemovacancia: TDBMemo;
    dsContratos: TDatasource;
    DateEditfinal: TDateEdit;
    DateEditinicial: TDateEdit;
    DBEdtCodcontrato: TDBEdit;
    DBMemoobs: TDBMemo;
    edtlocal: TEdit;
    Image1: TImage;
    IpFileDataProvider1: TIpFileDataProvider;
    IpHtmlPanel1: TIpHtmlPanel;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panelprincipal: TPanel;
    PanelBotoes: TPanel;
    sbtpessoa: TSpeedButton;
    RadioGroup1: TRadioGroup;
    Radiomanha: TRadioButton;
    Radionoite: TRadioButton;
    Radiotarde: TRadioButton;
    sbtcargo: TSpeedButton;
    sbtlocal: TSpeedButton;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure editahtml;
    procedure BtnadicionalocalClick(Sender: TObject);
    procedure BtnGerarcontratoClick(Sender: TObject);
    procedure btnlimparlocaisClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbtpessoaClick(Sender: TObject);
    procedure RadiomanhaChange(Sender: TObject);
    procedure RadionoiteChange(Sender: TObject);
    procedure RadiotardeChange(Sender: TObject);
    procedure sbtcargoClick(Sender: TObject);
    procedure sbtlocalClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmContrato: TfrmContrato;

implementation
uses
  uPesquisaPessoas,UCadastroLocalTrabalho, uCadastroCargos;

var
  linhas, numlocal: integer;

{$R *.lfm}

{ TfrmContrato }

procedure TfrmContrato.BtnVoltarClick(Sender: TObject);
begin
  close;
end;

procedure TfrmContrato.BtnGerarcontratoClick(Sender: TObject);
begin
    if not((DBEdtJornada.text = '') or (DBEdtCodcontrato.text = '') or
          (DBEdtAnoseletivo.text = '') or (DBEdtJornada.text = '') or
          (DBEdtFuncionario.text = '')) then
    begin
      if Application.MessageBox('Tem certeza que os campos estão corretos?','Finalizar', MB_OKCANCEL) = idOK then
      begin
        try
          //adiciona demais campos tabela contrato
          dsContratos.DataSet.FieldByName('periodo_inicial_contrato').Value := DateEditinicial.Text;
          dsContratos.DataSet.FieldByName('periodo_final_contrato').Value := DateEditfinal.Text;
          dsContratos.DataSet.FieldByName('data_contrato').Value := FormatDateTime('dd/mm/yyyy', Date);
          dsContratos.DataSet.FieldByName('salario_contrato').Value := dscargos.DataSet.FieldByName('salario_hora_cargo').value;

          dsContratos.DataSet.Post; //posta
        finally
          editahtml; //chama o preenchimento do html

          //carrega contrato prenchido
          IpHtmlPanel1.OpenURL(expandLocalHtmlFileName('contratoatual.html'));
          IpHtmlPanel1.PrintPreview;

          frmContrato.close;
        end;
      end
      else
        abort;
    end
    else
      ShowMessage('Preencha todos os campos!');
end;

procedure TfrmContrato.btnlimparlocaisClick(Sender: TObject);
begin
  StringGrid1.Clean(0,1,1,3,[gznormal]);
  numlocal := 0;
end;

procedure TfrmContrato.BtnadicionalocalClick(Sender: TObject);
begin
  //adiociona mais locais de trabalho
  StringGrid1.Cells[0,linhas] := edtlocal.text;
  StringGrid1.Cells[1,linhas] := DBEdthorario.text;

  if linhas = 3 then
    linhas := 1
  else
    inc(linhas);

  inc(numlocal);
end;

procedure TfrmContrato.FormShow(Sender: TObject);
begin
  //ativa query e coloca em mode de inserção
  dsContratos.DataSet.Active := true;

  //para varios locais
  linhas := 1;
  numlocal := 0;
  //--

  with DBComboBox1 do
  begin
    clear;
    Items.Add('Seletivo');
    Items.Add('cadastro RH');
    Items.Add('Contratação direta');
  end;

  dsContratos.DataSet.Insert;//contro em modo de insecao
end;

procedure TfrmContrato.sbtpessoaClick(Sender: TObject);
begin
  //chama a pesquisa de pessoa
  Application.CreateForm(TfrmPesquisaPessoas, frmPesquisaPessoas);
  frmPesquisaPessoas.showmodal;
  frmPesquisaPessoas.free;

  //filtra o dspessoa para o contrato
  dspessoa.DataSet.Filtered:=false;
  dspessoa.DataSet.Filter:='codigo_pessoa = '''+DBEdtFuncionario.text+'''';
  dspessoa.DataSet.Filtered:=true;

  //filtra a cidade da pessoa
  dscidades.DataSet.Filtered:=false;
  dscidades.DataSet.Filter:='codigo_cidade = '''+dspessoa.DataSet.FieldByName('codigo_cidade').asstring+'''';
  dscidades.DataSet.Filtered:=true;
end;

procedure TfrmContrato.RadiomanhaChange(Sender: TObject);
begin
    if Radiomanha.Checked then
      DBedtHorario.DataField:= 'horario_matutino_trabalho';
end;

procedure TfrmContrato.RadionoiteChange(Sender: TObject);
begin
    if Radionoite.Checked then
      DBedtHorario.DataField:= 'horario_noturno_trabalho';
end;

procedure TfrmContrato.RadiotardeChange(Sender: TObject);
begin
    if Radiotarde.Checked then
      DBedtHorario.DataField:= 'horario_vespertino_trabalho';
end;

procedure TfrmContrato.sbtcargoClick(Sender: TObject);
begin
   //chama a pesquisa de cargo
  Application.CreateForm(TfrmCadastroCargos, frmCadastroCargos);
  frmCadastroCargos.SelecionarAtivo := true; // Habilita botão SELECIONAR
  frmCadastroCargos.showmodal;
  frmCadastroCargos.free;

  //filtra o dscargo para o contrato
  dscargos.DataSet.Filter := 'codigo_cargo = ''' + DBEdtcargo.text + '''';
  dscargos.DataSet.Filtered := true;
end;

procedure TfrmContrato.sbtlocalClick(Sender: TObject);
begin
  //chama a pesquisa de local
  Application.CreateForm(TfrmCadastroLocalTrabalho, frmCadastroLocalTrabalho);
  frmCadastroLocalTrabalho.SelecionarAtivo := true;
  frmCadastroLocalTrabalho.showmodal;
  frmCadastroLocalTrabalho.free;

  //filtra o dslocal para o contrato
  dslocal.DataSet.Filter := 'nome_local_trabalho = ''' + edtlocal.text + '''';
  dslocal.DataSet.Filtered := true;
end;


//prenche contrato em html
procedure TfrmContrato.editahtml;
var
  texto : TStringList;
  pstl : string;
  y : integer;
  varlocal, varhorario : string;
begin

  //para varios locais
  if numlocal = 1 then
  begin
      varhorario := StringGrid1.Cells[1,1];
      varlocal := StringGrid1.Cells[0,1];
  end
  else if numlocal = 2 then
  begin
      varhorario := StringGrid1.Cells[1,1] +', '+ StringGrid1.Cells[1,2];
      varlocal := StringGrid1.Cells[0,1] +', '+ StringGrid1.Cells[0,2];
  end
  else if numlocal = 3 then
  begin
      varhorario := StringGrid1.Cells[1,1] +', '+ StringGrid1.Cells[1,2]
      + ', ' + StringGrid1.Cells[1,3];
      varlocal := StringGrid1.Cells[0,1] +', '+ StringGrid1.Cells[0,2]
      + ', ' + StringGrid1.Cells[0,3];
  end;
  //----
  try
    texto := TStringList.Create;
    texto.LoadFromFile('contrato.html');
    for y := 0 to texto.Count-1 do
    begin
      pstl := texto[y];//atribui uma linha da stringlist  na pstl

      texto[y] := StringReplace(pstl,'varnome',dspessoa.DataSet.FieldByName('nome_pessoa').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varcargo',dscargos.DataSet.FieldByName('nome_cargo').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varperiodoinicial',dsContratos.DataSet.FieldByName('periodo_inicial_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varperiodofinal',dsContratos.DataSet.FieldByName('periodo_final_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varlocal',varlocal,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varjornada',dsContratos.DataSet.FieldByName('jornada_trabalho_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'vardata',dsContratos.DataSet.FieldByName('data_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varanoseletivo',dsContratos.DataSet.FieldByName('ano_seletivo_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varano',FormatDateTime('yyyy',now),[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varcodigocontrato',dsContratos.DataSet.FieldByName('codigo_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varnacionalidade',dspessoa.DataSet.FieldByName('nacionalidade_pessoa').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varestadocivil',dspessoa.DataSet.FieldByName('estado_civil_pessoa').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varrg',dspessoa.DataSet.FieldByName('rg_pessoa').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varcpf',dspessoa.DataSet.FieldByName('cpf_pessoa').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varendereco',dspessoa.DataSet.FieldByName('endereco_pessoa').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varbairro',dspessoa.DataSet.FieldByName('bairro_pessoa').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varcidade',dscidades.DataSet.FieldByName('nome_cidade').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varjustificativa',dsContratos.DataSet.FieldByName('justificativa_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varcargahoraria',dsContratos.DataSet.FieldByName('jornada_trabalho_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varcpfteste1',dsContratos.DataSet.FieldByName('cpf_teste_1_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'vartestemunha1',dsContratos.DataSet.FieldByName('testemunha_1_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'varcpfteste2',dsContratos.DataSet.FieldByName('cpf_teste_2_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      texto[y] := StringReplace(pstl,'vartestemunha2',dsContratos.DataSet.FieldByName('testemunha_2_contrato').value,[rfIgnoreCase,rfReplaceAll]);

      //observaçao contrato
      if DBMemoobs.text = '' then
        texto[y] := StringReplace(pstl,'varobs','______________________________'+
        '______________________________________________________________________'+
        '______________________________________________________________________'+
        '______________________________________________________________________'+
        '________',[rfIgnoreCase,rfReplaceAll])
      else
        texto[y] := StringReplace(pstl,'varobs',dsContratos.DataSet.FieldByName('obs_contrato').value,[rfIgnoreCase,rfReplaceAll]);
      //----

      texto[y] := StringReplace(pstl,'varhorario',varhorario,[rfIgnoreCase,rfReplaceAll]);

      if DBComboBox1.Text = 'Seletivo' then
        texto[y] := StringReplace(pstl,'var1','X',[rfIgnoreCase,rfReplaceAll])
      else if DBComboBox1.Text = 'Cadastro RH' then
        texto[y] := StringReplace(pstl,'var2','X',[rfIgnoreCase,rfReplaceAll])
      else if DBComboBox1.Text = 'Contratação Direta' then
        texto[y] := StringReplace(pstl,'var3','X',[rfIgnoreCase,rfReplaceAll]);

    end;
    texto.SaveToFile('contratoatual.html');
  finally
    texto.Free;
  end;
end;
// FIM -------------------------------------------------------------------------
procedure TfrmContrato.Button1Click(Sender: TObject);
begin
  OpenURL(expandLocalHtmlFileName('contrato.html'));
  //IpHtmlPanel1.OpenURL();
  //IpHtmlPanel1.PrintPreview;
end;

end.

