unit ucontrato;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Ipfilebroker, IpHtml, Forms, Controls, Graphics,
  Dialogs, Buttons, ExtCtrls, LCLIntf, DBCtrls, StdCtrls, EditBtn, Printers,
  Grids, LCLType, Menus, ZDataset;

type

  { TfrmContrato }

  TfrmContrato = class(TForm)
    BtnCancelarContrato: TBitBtn;
    Btnadicionalocal: TBitBtn;
    BtnBuscaContrato: TBitBtn;
    BtnGerarcontrato: TBitBtn;
    btnlimparlocais: TBitBtn;
    BtnSair: TBitBtn;
    cboxtipo: TComboBox;
    DateEditfinal: TDateEdit;
    DateEditinicial: TDateEdit;
    DBEdtAnoseletivo: TDBEdit;
    DBEdtcpftest2: TDBEdit;
    DBEdtcpfteste1: TDBEdit;
    DBEdthorario: TDBEdit;
    DBEdtJornada: TDBEdit;
    DBEdttest2: TDBEdit;
    DBEdtteste1: TDBEdit;
    DBMemoobs: TDBMemo;
    DBMemovacancia: TDBMemo;
    edtcargo: TEdit;
    edtfuncionario: TEdit;
    edtcodigocontrato: TEdit;
    edtlocal: TEdit;
    gbContrato: TGroupBox;
    gbLocalTrabalho: TGroupBox;
    gbInformacoesAdicionais: TGroupBox;
    gbTestemunhas: TGroupBox;
    gbTestemunha1: TGroupBox;
    gbTestemunha2: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    lblFuncionario: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblCargo: TLabel;
    lblLocalTrabalho: TLabel;
    MenuItem1: TMenuItem;
    Panel3: TPanel;
    Panelprincipal: TPanel;
    PanelBotoes: TPanel;
    popJornadaSemanal: TPopupMenu;
    rgHorarios: TRadioGroup;
    sbtbuscarcargo: TSpeedButton;
    sbtbuscarpessoa: TSpeedButton;
    sbtlocal: TSpeedButton;
    sbtJornadaSemanal: TSpeedButton;
    StringGrid1: TStringGrid;
    procedure BtnBuscaContratoClick(Sender: TObject);
    procedure BtnCancelarContratoClick(Sender: TObject);
    procedure DBEdtAnoseletivoKeyPress(Sender: TObject; var Key: char);
    procedure DBEdtcargoKeyPress(Sender: TObject; var Key: char);
    procedure DBEdtCodcontratoExit(Sender: TObject);
    procedure BtnadicionalocalClick(Sender: TObject);
    procedure BtnGerarcontratoClick(Sender: TObject);
    procedure btnlimparlocaisClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure DBEdtcpftest2Exit(Sender: TObject);
    procedure DBEdtcpftest2KeyPress(Sender: TObject; var Key: char);
    procedure DBEdtcpfteste1Exit(Sender: TObject);
    procedure DBEdtcpfteste1KeyPress(Sender: TObject; var Key: char);
    procedure DBEdthorarioKeyPress(Sender: TObject; var Key: char);
    procedure DBEdtJornadaKeyPress(Sender: TObject; var Key: char);
    procedure edtcargoEditingDone(Sender: TObject);
    procedure edtcargoExit(Sender: TObject);
    procedure edtcargoKeyPress(Sender: TObject; var Key: char);
    procedure edtcodigocontratoKeyPress(Sender: TObject; var Key: char);
    procedure edtfuncionarioEditingDone(Sender: TObject);
    procedure edtfuncionarioKeyPress(Sender: TObject; var Key: char);
    procedure edtlocalEditingDone(Sender: TObject);
    procedure edtlocalExit(Sender: TObject);
    procedure FormClose(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgHorariosClick(Sender: TObject);
    procedure sbtbuscarpessoaClick(Sender: TObject);
    procedure sbtbuscarcargoClick(Sender: TObject);
    procedure sbtJornadaSemanalClick(Sender: TObject);
    procedure sbtlocalClick(Sender: TObject);
    procedure limparCampos;
    procedure limpaLocal;

  private
    { private declarations }
    function verificarCodigo(var edit1: TEdit; var labelDesc: TLabel;
      tabela, campoCodigo, campoNome: string): boolean;
  public
    { public declarations }
  end;

const
  local = 'c:\temp\';//local de salvamento do contrato

var
  frmContrato: TfrmContrato;

implementation

uses
  uPesquisaPessoas, ubuscacontrato, UUtilidades, uhtml, UCadastroLocalTrabalho,
  uCadastroCargos, udmcontratos, ufiltragem, dmMain;

var
  linhas: byte;
  horarios: array[1..3] of integer;
  numlocal: integer;
  m,v,n : boolean;

{$R *.lfm}

{ TfrmContrato }

// INICIO - frmcontratos show ---------------------------------------------------
procedure TfrmContrato.FormShow(Sender: TObject);
begin
  //cria dmcontratos
  Application.CreateForm(TDMcontratos, DMcontratos);

  CreateDir(local);//cria pasta temporaria para o contrato

  limpaLocal;
end;

// PROCEDURE verificadora de Codigos (preenche também os labels com os nomes ao lado)
function TfrmContrato.verificarCodigo(var edit1: TEdit; var labelDesc: TLabel;
  tabela, campoCodigo, campoNome: string): boolean;
var
  query: TZQuery;
begin
  if Length(edit1.Text) <> 0 then
  begin
    try
      query := TZQuery.Create(self);
      query.Connection := DM1.SEMEDconnection;
      query.SQL.Clear;
      query.SQL.Add('SELECT ' + campoNome + ' FROM ' + tabela + ' WHERE ' + campoCodigo +
        ' = "' + edit1.Text + '";');
      query.Open;
      if not (query.IsEmpty) then   // Se nao retornar nenhum valor
      begin
        edit1.Color := clDefault;
        labelDesc.Caption := query.FieldByName(campoNome).Value;
        Result := True;
      end
      else
      begin
        edit1.Color := clRed;       // Se retornar valor (codigo é valido)
        edit1.SetFocus;
        labelDesc.Caption := 'Registro não encontrado!';
        Result := False;
      end;
    finally
      query.Close;
      query.Free;
    end;
  end;
end;

// MENU lateral ----------------------------------------------------------------

//Botão Buscar Contratos ---
procedure TfrmContrato.BtnBuscaContratoClick(Sender: TObject);
begin
  //cria form de busca de contratos
  Application.CreateForm(Tfrmbuscacontrato, frmbuscacontrato);
  frmbuscacontrato.ShowModal;
  frmbuscacontrato.Free;
end;

//btngerarcontrato click ---
procedure TfrmContrato.BtnGerarcontratoClick(Sender: TObject);
var
  i: integer;
begin
  if (Length(edtcargo.Text) <> 0) and (Length(DBEdtJornada.Text) <> 0) and
    (Length(DateEditfinal.Text) <> 0) and (Length(DateEditinicial.Text) <> 0) and
    (Length(DBMemovacancia.Text) <> 0) and (Length(DBEdtAnoseletivo.Text) <> 0) and
    (Length(cboxtipo.Text) <> 0) and (Length(DBEdtteste1.Text) <> 0) and
    (Length(DBEdttest2.Text) <> 0) and (Length(DBEdtcpfteste1.Text) <> 0) and
    (Length(DBEdtcpftest2.Text) <> 0) and (StringGrid1.Rows[1].Text <> '') then
  begin
    if Application.MessageBox('Tem certeza que os campos estão corretos?', 'Finalizar',
      MB_OKCANCEL) = idOk then
    begin
      try
        //adiciona demais campos tabela contrato
        with udmcontratos.dmcontratos.zt_contratos do
        begin
          FieldByName('tipo_contratacao_contrato').Value := cboxtipo.Text;
          FieldByName('codigo_contrato').Value := edtcodigocontrato.Text;
          FieldByName('codigo_pessoa').Value := edtfuncionario.Text;
          FieldByName('codigo_cargo').Value := edtcargo.Text;
          FieldByName('periodo_inicial_contrato').Value := DateEditinicial.Text;
          FieldByName('periodo_final_contrato').Value := DateEditfinal.Text;
          FieldByName('data_contrato').Value := DateToStr(date);
          FieldByName('salario_contrato').Value :=
            DMcontratos.dscargos.DataSet.FieldByName('salario_hora_cargo').Value;

          Post; //posta

          //salva locais do contrato
          with DMcontratos.dscontratoslocais.DataSet do
          begin
            Active := True;
            insert;

            FieldByName('codigo_contrato').Value :=
              DMcontratos.dscontratos.DataSet.FieldByName('codigo_contrato').Value;
            FieldByName('codigo_local_trabalho').Value := numlocal;

            // 0 = false/ 1 = true
            FieldByName('matutino').Value := 0;
            FieldByName('vespertino').Value := 0;
            FieldByName('noturno').Value := 0;

            for i := 0 to linhas - 1 do
            begin
              //defini os horaios para false para setar true nos que foram selecionados
              case horarios[i] of
                1: FieldByName('matutino').Value := 1;
                2: FieldByName('vespertino').Value := 1;
                3: FieldByName('noturno').Value := 1;
              end;

            end;
            //fim for ----
            post;
          end;
          //fim with ----
        end;
      finally
        html.editahtml; //chama o preenchimento do html
        limparCampos;
      end;
    end;
  end
  else
    ShowMessage('Preencha todos os campos!');
end;

// Botão Cancelar Contrato -----------------------------------------------------

procedure TfrmContrato.BtnCancelarContratoClick(Sender: TObject);
begin
  limparCampos;
end;

procedure TfrmContrato.limparCampos;
begin
  edtcodigocontrato.Text := '';
  edtcodigocontrato.Enabled := True;
  BtnCancelarContrato.Enabled := False;
  edtcodigocontrato.SetFocus;
  lblFuncionario.Caption := 'Funcionário';

  edtfuncionario.Enabled := False;
  sbtbuscarpessoa.Enabled := False;
  edtfuncionario.Text := '';

  BtnBuscaContrato.Enabled := True;
  BtnGerarcontrato.Enabled := False;

  gbLocalTrabalho.Enabled := False;
  gbInformacoesAdicionais.Enabled := False;
  gbTestemunhas.Enabled := False;
  gbContrato.Enabled := False;

  edtcargo.Text := '';
  DateEditinicial.Text := '';
  DateEditfinal.Text := '';
  DBEdtJornada.Text := '';

  limpaLocal;
  edtlocal.Text := '';

  DBMemoobs.Text := '';
  DBMemovacancia.Text := '';
  DBEdtAnoseletivo.Text := '';
  cboxtipo.Text := '';

  DBEdtteste1.Text := '';
  DBEdtcpfteste1.Text := '';
  DBEdttest2.Text := '';
  DBEdtcpftest2.Text := '';

  DMcontratos.dsContratos.DataSet.Cancel;
  DMcontratos.dsContratos.DataSet.Filtered:= false;
  DMcontratos.dsContratos.DataSet.Active:=false;

  DMcontratos.dspessoa.DataSet.Active := False;
  DMcontratos.dscargos.DataSet.Active := False;
  DMcontratos.dscidades.DataSet.Active := False;
  DMcontratos.dscontratoslocais.DataSet.Active := False;
end;

//limpar locais da grid locais -------------------------------------------------
procedure TfrmContrato.btnlimparlocaisClick(Sender: TObject);
begin
  limpaLocal;
end;

procedure TfrmContrato.limpaLocal;
var
  x: integer;
begin
  //variavel se hora foi adicionada
  m := false;
  v := false;
  n := false;

  linhas := 1;

  DBEdthorario.Clear;

  StringGrid1.Clean(0, 1, 1, 3, [gznormal]);

  for x := 1 to 3 do
  begin
    numlocal := 0;
    horarios[x] := 0;
  end;

  // ---
  rgHorarios.Items[0] := 'Maturino';
  rgHorarios.Items[1] := 'Vespertino';
  rgHorarios.Items[2] := 'Noturno';
  //---
end;

//adicionar locais a grid locais -----------------------------------------------
procedure TfrmContrato.BtnadicionalocalClick(Sender: TObject);
begin
  if (Length(edtlocal.Text) <> 0) and (Length(DBEdthorario.Text) <> 0) then
  begin
    //adiociona mais locais de trabalho
    StringGrid1.Cells[0, linhas] :=
      DMcontratos.dslocaltrabalho.DataSet.FieldByName('nome_local_trabalho').Value;
    StringGrid1.Cells[1, linhas] := DBEdthorario.Text;

    numlocal := DMcontratos.dslocaltrabalho.DataSet.FieldByName(
      'codigo_local_trabalho').Value;

    Inc(linhas);
    DBedtHorario.Clear;
  end;
end;

//Rghorarios selection ---------------------------------------------------------
procedure TfrmContrato.rgHorariosClick(Sender: TObject);
begin
  case rgHorarios.ItemIndex of
    0:
    begin
      if (rgHorarios.Items[0] <> ' - ') and (not(m))  then
      begin
        DBedtHorario.DataField := 'horario_matutino_trabalho';
        horarios[linhas] := 1;
        m := true;
      end
      else
        DBedtHorario.DataField := '';
    end;

    1:
    begin
      if (rgHorarios.Items[1] <> ' - ') and ( not(v) ) then
      begin
        DBedtHorario.DataField := 'horario_vespertino_trabalho';
        horarios[linhas] := 2;
        v := true;
      end
      else
        DBedtHorario.DataField := '';
    end;

    2:
    begin
      if (rgHorarios.Items[2] <> ' - ') and ( not(n) ) then
      begin
        DBedtHorario.DataField := 'horario_noturno_trabalho';
        horarios[linhas] := 3;
        n := true;
      end
      else
        DBedtHorario.DataField := '';
    end;
  end;
end;

//sbtbuscarpessoa ---------------------------------------------------------------
procedure TfrmContrato.sbtbuscarpessoaClick(Sender: TObject);
begin
  //chama a pesquisa de pessoa
  Application.CreateForm(TfrmPesquisaPessoas, frmPesquisaPessoas);
  frmPesquisaPessoas.showmodal;
  frmPesquisaPessoas.Free;

  //coloca codigo funcionario em seu respectivo edit
  edtfuncionario.Text := DMcontratos.dspessoa.DataSet.FieldByName('codigo_pessoa').Value;

  //filtra dspessoa
  filtragem.filtrads('codigo_pessoa = ''' + edtfuncionario.Text + '''', 'dspessoa');

  edtfuncionario.SetFocus;
end;

//sbtbuscarcargo ---------------------------------------------------------------
procedure TfrmContrato.sbtbuscarcargoClick(Sender: TObject);
begin
  //chama a pesquisa de cargo
  Application.CreateForm(TfrmCadastroCargos, frmCadastroCargos);
  frmCadastroCargos.SelecionarAtivo := True; // Habilita botão SELECIONAR
  frmCadastroCargos.showmodal;
  frmCadastroCargos.Free;

  edtcargo.Text := DMcontratos.dsContratos.DataSet.FieldByName('codigo_cargo').AsString;

  //filtra ds cargo
  filtragem.filtrads('codigo_cargo = ''' + edtcargo.Text + '''', 'dscargos');

  edtcargo.SetFocus;
end;

//sbtbuscarlocal ---------------------------------------------------------------
procedure TfrmContrato.sbtlocalClick(Sender: TObject);
begin
  limpaLocal;

  //chama a pesquisa de local
  DMcontratos.dslocaltrabalho.DataSet.Active := True;

  Application.CreateForm(TfrmCadastroLocalTrabalho, frmCadastroLocalTrabalho);
  frmCadastroLocalTrabalho.SelecionarAtivo := True;
  frmCadastroLocalTrabalho.showmodal;
  frmCadastroLocalTrabalho.Free;

  edtlocal.Text := DMcontratos.dslocaltrabalho.DataSet.FieldByName(
    'codigo_local_trabalho').AsString;

  if DMcontratos.dslocaltrabalho.DataSet.FieldByName('horario_matutino_trabalho').Value =
    ' - ' then
    rgHorarios.Items[0] := ' - ';
  if DMcontratos.dslocaltrabalho.DataSet.FieldByName( 'horario_vespertino_trabalho').Value =
    ' - ' then
    rgHorarios.Items[1] := ' - ';
  if DMcontratos.dslocaltrabalho.DataSet.FieldByName('horario_noturno_trabalho').Value =
    ' - ' then
    rgHorarios.Items[2] := ' - ';

  edtlocal.SetFocus;
end;

//sbtJornadaSemanal ------------------------------------------------------------
procedure TfrmContrato.sbtJornadaSemanalClick(Sender: TObject);
begin
  popJornadaSemanal.PopUp;
end;

//PREVISAO DE ERROS-------------------------------------------------------------

// Ao sair dos campos codigo de algo

procedure TfrmContrato.edtcargoExit(Sender: TObject);               // Cargos
begin
  verificarCodigo(edtcargo, lblCargo, 'tb_cargos', 'codigo_cargo', 'nome_cargo');
end;

procedure TfrmContrato.edtlocalExit(Sender: TObject);               // Locais de Trabalho
begin
  limpaLocal;

  verificarCodigo(edtlocal, lblLocalTrabalho, 'tb_local_trabalho',
    'codigo_local_trabalho', 'nome_local_trabalho');

  if DMcontratos.dslocaltrabalho.DataSet.FieldByName('horario_matutino_trabalho').Value =
    ' - ' then
    rgHorarios.Items[0] := ' - ';
  if DMcontratos.dslocaltrabalho.DataSet.FieldByName(
    'horario_vespertino_trabalho').Value = ' - ' then
    rgHorarios.Items[1] := ' - ';
  if DMcontratos.dslocaltrabalho.DataSet.FieldByName('horario_noturno_trabalho').Value =
    ' - ' then
    rgHorarios.Items[2] := ' - ';
end;

// Verificadores e marcaras
procedure TfrmContrato.DBEdtcpftest2Exit(Sender: TObject);  // CPF testemunha 2
begin
  utilidades.VerifCPF(DBEdtcpftest2);
end;

procedure TfrmContrato.DBEdtcpftest2KeyPress(Sender: TObject; var Key: char);
begin
  utilidades.MascCPF(DBEdtcpftest2, Key);
end;
// CPF testemunha 1
procedure TfrmContrato.DBEdtcpfteste1Exit(Sender: TObject);
begin
  Utilidades.VerifCPF(DBEdtcpfteste1);
end;

procedure TfrmContrato.DBEdtcpfteste1KeyPress(Sender: TObject; var Key: char);
begin
  utilidades.MascCPF(DBEdtcpfteste1, Key);
end;
// horario
procedure TfrmContrato.DBEdthorarioKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil};
end;

procedure TfrmContrato.DBEdtAnoseletivoKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil};
end;

procedure TfrmContrato.DBEdtcargoKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil};
end;

procedure TfrmContrato.DBEdtJornadaKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil};
end;

procedure TfrmContrato.edtcargoEditingDone(Sender: TObject);
begin
  //filtra ds cargo
  if Length(edtcargo.Text) <> 0 then
    filtragem.filtrads('codigo_cargo = ''' + edtcargo.Text + '''', 'dscargos');
end;

procedure TfrmContrato.edtcargoKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil};
end;

procedure TfrmContrato.edtcodigocontratoKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil};
end;

procedure TfrmContrato.edtfuncionarioEditingDone(Sender: TObject);
begin
  //libera campos apenas se funcionario nao contratado
  if (Length(edtfuncionario.Text) <> 0) and
    (verificarCodigo(edtfuncionario, lblFuncionario, 'tb_pessoas',
    'codigo_pessoa', 'nome_pessoa')) then
  begin
    if not DMcontratos.dsContratos.DataSet.Locate('codigo_pessoa',
      EdtFuncionario.Text, []) then
    begin
      gbLocalTrabalho.Enabled := True;
      gbInformacoesAdicionais.Enabled := True;
      gbTestemunhas.Enabled := True;
      gbContrato.Enabled := True;

      BtnGerarcontrato.Enabled := True;

      edtfuncionario.Enabled := False;
      sbtbuscarpessoa.Enabled := False;

      DMcontratos.dsContratos.DataSet.Insert;//coloca table em modo de inserçao

      //filtra dspessoa
      filtragem.filtrads('codigo_pessoa = ''' + edtfuncionario.Text + '''', 'dspessoa');


      //ativa tabelas
      DMcontratos.zt_cargos.Active := True;
      DMcontratos.zt_cidades.Active := True;
      DMcontratos.zt_contratos_cargos.Active := True;

      filtragem.filtrads('codigo_cidade = ''' + DMcontratos.dspessoa.DataSet.FieldByName(
        'codigo_cidade').AsString + '''', 'dscidades');

      edtcargo.SetFocus;
    end
    else
    begin
      gbLocalTrabalho.Enabled := False;
      gbInformacoesAdicionais.Enabled := False;
      gbTestemunhas.Enabled := False;
      gbContrato.Enabled := False;

      BtnGerarcontrato.Enabled := False;

      edtfuncionario.Clear;
      ShowMessage('Funcionário número' + edtfuncionario.Text + ' já contratado!');
    end;
  end;
end;

procedure TfrmContrato.DBEdtCodcontratoExit(Sender: TObject);
begin
  //libera novo comtrato apenas se codigo contrato nao existir
  if Length(edtcodigocontrato.Text) <> 0 then
  begin
    //buscar se contrato existe
    DMcontratos.zt_contratos.Active := True;

    filtragem.filtrads('codigo_contrato = ''' + edtcodigocontrato.Text + '''',
      'dscontratos');

    //liberar novo contrato
    if DMcontratos.dsContratos.DataSet.RecordCount = 0 then
    begin
      edtfuncionario.Enabled := True;
      sbtbuscarpessoa.Enabled := True;

      edtcodigocontrato.Enabled := False;
      BtnCancelarContrato.Enabled := True;
      edtfuncionario.SetFocus;

      BtnBuscaContrato.Enabled := False;

      DMcontratos.zt_pessoas.Active := True;
    end
    else
      //não liberar novo contrato
    begin
      ShowMessage('Código ' + edtcodigocontrato.Text + ' já existente!');
      edtcodigocontrato.Clear;
      DMcontratos.zt_contratos.Active := False;
      DMcontratos.zt_pessoas.Active := False;
    end;
  end;
end;

procedure TfrmContrato.edtfuncionarioKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil};
end;

procedure TfrmContrato.edtlocalEditingDone(Sender: TObject);
begin
  if Length(edtlocal.Text) <> 0 then
    filtragem.filtrads('codigo_local_trabalho = ''' +
      edtlocal.Text + '''', 'dslocaltrabalho');
end;

procedure TfrmContrato.FormClose(Sender: TObject);
begin
  DeleteDirectory('c:\temp\', False);  //deleta pasta temporaria do contrato

  DMcontratos.Free;  //fecha datamodule de controtos
end;

// FIM - frmcontrato close ------------------------------------------------------
procedure TfrmContrato.BtnSairClick(Sender: TObject);
begin
  Close;
end;

end.
