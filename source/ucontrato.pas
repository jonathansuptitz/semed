unit ucontrato;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Ipfilebroker, IpHtml,
 Forms, Controls, Graphics,
  Dialogs, Buttons, ExtCtrls, LCLIntf,
  DbCtrls, StdCtrls, EditBtn, Printers, Grids, LCLType;

type

  { TfrmContrato }

  TfrmContrato = class(TForm)
    Btnadicionalocal: TBitBtn;
    BtnGerarcontrato: TBitBtn;
    btnlimparlocais: TBitBtn;
    BtnSair: TBitBtn;
    cboxtipo: TComboBox;
    DBEdthorario: TDBEdit;
    DBEdtcpftest2: TDBEdit;
    DBEdtcpfteste1: TDBEdit;
    DBEdttest2: TDBEdit;
    DBEdtteste1: TDBEdit;
    DBEdtJornada: TDBEdit;
    DBEdtAnoseletivo: TDBEdit;
    DBMemovacancia: TDBMemo;
    DateEditfinal: TDateEdit;
    DateEditinicial: TDateEdit;
    DBMemoobs: TDBMemo;
    edtlocal: TEdit;
    edtcargo: TEdit;
    edtfuncionario: TEdit;
    edtcodigocontrato: TEdit;
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
    rgHorarios: TRadioGroup;
    sbtlocal: TSpeedButton;
    sbtbuscarpessoa: TSpeedButton;
    sbtbuscarcargo: TSpeedButton;
    sbtbuscacintrato: TSpeedButton;
    StringGrid1: TStringGrid;
    procedure DateEditfinalChange(Sender: TObject);
    procedure DateEditfinalExit(Sender: TObject);
    procedure DateEditfinalKeyPress(Sender: TObject; var Key: char);
    procedure DateEditinicialExit(Sender: TObject);
    procedure DateEditinicialKeyPress(Sender: TObject; var Key: char);
    procedure DBComboBox1Exit(Sender: TObject);
    procedure DBEdtAnoseletivoExit(Sender: TObject);
    procedure DBEdtAnoseletivoKeyPress(Sender: TObject; var Key: char);
    procedure DBEdtcargoKeyPress(Sender: TObject; var Key: char);
    procedure DBEdtCodcontratoExit(Sender: TObject);
    procedure BtnadicionalocalClick(Sender: TObject);
    procedure BtnGerarcontratoClick(Sender: TObject);
    procedure btnlimparlocaisClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure DBEdtcpftest2EditingDone(Sender: TObject);
    procedure DBEdtcpftest2Exit(Sender: TObject);
    procedure DBEdtcpftest2KeyPress(Sender: TObject; var Key: char);
    procedure DBEdtcpfteste1EditingDone(Sender: TObject);
    procedure DBEdtcpfteste1KeyPress(Sender: TObject; var Key: char);
    procedure DBEdthorarioKeyPress(Sender: TObject; var Key: char);
    procedure DBEdtJornadaEditingDone(Sender: TObject);
    procedure DBEdtJornadaKeyPress(Sender: TObject; var Key: char);
    procedure DBEdttest2EditingDone(Sender: TObject);
    procedure DBEdtteste1Exit(Sender: TObject);
    procedure DBMemovacanciaExit(Sender: TObject);
    procedure edtcargoEditingDone(Sender: TObject);
    procedure edtcargoKeyPress(Sender: TObject; var Key: char);
    procedure edtcodigocontratoKeyPress(Sender: TObject; var Key: char);
    procedure edtfuncionarioEditingDone(Sender: TObject);
    procedure edtfuncionarioKeyPress(Sender: TObject; var Key: char);
    procedure edtlocalEditingDone(Sender: TObject);
    procedure FormClose(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
    procedure rgHorariosChangeBounds(Sender: TObject);
    procedure rgHorariosClick(Sender: TObject);
    procedure sbtbuscacintratoClick(Sender: TObject);
    procedure sbtbuscarpessoaClick(Sender: TObject);
    procedure sbtbuscarcargoClick(Sender: TObject);
    procedure sbtlocalClick(Sender: TObject);
    procedure StringGrid1Exit(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmContrato: TfrmContrato;

implementation
uses
  uPesquisaPessoas, ubuscacontrato, UUtilidades, uhtml , UCadastroLocalTrabalho,
  uCadastroCargos, udmcontratos, ufiltragem;

var
  linhas: byte;
  horarios: array[1..3] of string;
  numlocal : array[1..3] of integer;
{$R *.lfm}

{ TfrmContrato }

//frmcontrato close ------------------------------------------------------------
procedure TfrmContrato.BtnSairClick(Sender: TObject);
begin
  close;
end;

//btngerarcontrato click -------------------------------------------------------
procedure TfrmContrato.BtnGerarcontratoClick(Sender: TObject);
var
  i : integer;
begin
if (Length(edtcargo.text) <> 0) and (Length(DBEdtJornada.text) <> 0) and
    (Length(DateEditfinal.text) <> 0) and (Length(DateEditinicial.text) <> 0) and
    (Length(DBMemovacancia.text) <> 0) and (Length(DBEdtAnoseletivo.text) <> 0) and
    (Length(cboxtipo.text) <> 0) and (Length(DBEdtteste1.text) <> 0) and
    (Length(DBEdttest2.text) <> 0) and (Length(DBEdtcpfteste1.text) <> 0) and
    (Length(DBEdtcpftest2.text) <> 0) and  (StringGrid1.Rows[1].Text <> '') then
begin
  if Application.MessageBox('Tem certeza que os campos estão corretos?','Finalizar', MB_OKCANCEL) = idOK then
  begin
    try
      //adiciona demais campos tabela contrato
      with udmcontratos.dmcontratos.zt_contratos do
      begin
        FieldByName('tipo_contratacao_contrato').value := cboxtipo.Text;
        FieldByName('codigo_contrato').Value  := edtcodigocontrato.text;
        FieldByName('codigo_pessoa').Value  := edtfuncionario.text;
        FieldByName('codigo_cargo').value := edtcargo.text;
        FieldByName('periodo_inicial_contrato').Value := DateEditinicial.Text;
        FieldByName('periodo_final_contrato').Value := DateEditfinal.Text;
        FieldByName('data_contrato').Value := FormatDateTime('dd/mm/yyyy', Date);
        FieldByName('salario_contrato').Value := DMcontratos.dscargos.DataSet.FieldByName('salario_hora_cargo').value;
      //
        Post; //posta

        DMcontratos.dscontratoslocais.DataSet.Active:=true;
        //salva locais do contrato
        for i := 1 to linhas -1 do
        begin
          with DMcontratos.dscontratoslocais.DataSet do
          begin
            insert;

            FieldByName('codigo_contrato').value := DMcontratos.dscontratos.DataSet.FieldByName('codigo_contrato').value;

            FieldByName('codigo_local_trabalho').value := numlocal[i];

            FieldByName('horario_local_trabalho').value:= horarios[i];

            post;
          end;
        end;
        //
      end;
    finally
      html.editahtml; //chama o preenchimento do html
    end;
  end;
end
else
  ShowMessage('Preencha todos os campos!');
end;

//limpar locais da grid locais -------------------------------------------------
procedure TfrmContrato.btnlimparlocaisClick(Sender: TObject);
var
  x:integer;
begin
  linhas:=1;

  StringGrid1.Clean(0,1,1,3,[gznormal]);

  for x := 1 to 3 do
  begin
    numlocal[x] := 0;
    horarios[x]:='';
  end;
end;

//adicionar locais a grid locais -----------------------------------------------
procedure TfrmContrato.BtnadicionalocalClick(Sender: TObject);
begin
  if Length(edtlocal.Text) <> 0 then
  begin
    //adiociona mais locais de trabalho
    StringGrid1.Cells[0,linhas] := DMcontratos.dslocaltrabalho.DataSet.FieldByName('nome_local_trabalho').value;
    StringGrid1.Cells[1,linhas] := DBEdthorario.text;
    horarios[linhas] := DBEdthorario.text;

    numlocal[linhas]:= DMcontratos.dslocaltrabalho.DataSet.FieldByName('codigo_local_trabalho').value;

    inc(linhas);
  end;
end;


//frmcontratos show ------------------------------------------------------------
procedure TfrmContrato.FormShow(Sender: TObject);
var
  x:integer;
begin
  //cria dmcontratos
  Application.CreateForm(TDMcontratos, DMcontratos);

  CreateDir('c:\temp\');//cria pasta temporaria para o contrato

  //inicializa variaveis para varios locais
  linhas := 1;

  for x := 1 to 3 do
  begin
    numlocal[x] := 0;
    horarios[x]:='';
  end;
  //--
end;

procedure TfrmContrato.Panel3Click(Sender: TObject);
begin

end;

procedure TfrmContrato.rgHorariosChangeBounds(Sender: TObject);
begin

end;

//Rghorarios selectio ----------------------------------------------------------
procedure TfrmContrato.rgHorariosClick(Sender: TObject);
begin
    case rgHorarios.ItemIndex of
    0: DBedtHorario.DataField:= 'horario_matutino_trabalho';
    1: DBedtHorario.DataField:= 'horario_vespertino_trabalho';
    2: DBedtHorario.DataField:= 'horario_noturno_trabalho';
  end;

end;

//sbtbuscacontrato -------------------------------------------------------------
procedure TfrmContrato.sbtbuscacintratoClick(Sender: TObject);
begin
  //cria form de busca de contratos
  Application.CreateForm(Tfrmbuscacontrato, frmbuscacontrato);
  frmbuscacontrato.ShowModal;
  frmbuscacontrato.Free;
end;

//sbtbuscarpessoa ---------------------------------------------------------------
procedure TfrmContrato.sbtbuscarpessoaClick(Sender: TObject);
begin
  //chama a pesquisa de pessoa
  Application.CreateForm(TfrmPesquisaPessoas, frmPesquisaPessoas);
  frmPesquisaPessoas.showmodal;
  frmPesquisaPessoas.free;

  //coloca codigo funcionario em seu respectivo edit
  edtfuncionario.text:= DMcontratos.dspessoa.DataSet.FieldByName('codigo_pessoa').value;

  //filtra dspessoa
  filtragem.filtrads('codigo_pessoa = '''  + edtfuncionario.text+'''', 'dspessoa');
end;

//sbtbuscarcargo ---------------------------------------------------------------
procedure TfrmContrato.sbtbuscarcargoClick(Sender: TObject);
begin
   //chama a pesquisa de cargo
  Application.CreateForm(TfrmCadastroCargos, frmCadastroCargos);
  frmCadastroCargos.SelecionarAtivo := true; // Habilita botão SELECIONAR
  frmCadastroCargos.showmodal;
  frmCadastroCargos.free;

  edtcargo.text := DMcontratos.dsContratos.DataSet.FieldByName('codigo_cargo').AsString;

  //filtra ds cargo
  filtragem.filtrads('codigo_cargo = ''' + edtcargo.text+'''', 'dscargos');

end;

//sbtbuscarlocal ---------------------------------------------------------------
procedure TfrmContrato.sbtlocalClick(Sender: TObject);
begin
  //chama a pesquisa de local
  DMcontratos.dslocaltrabalho.DataSet.Active:=true;

  Application.CreateForm(TfrmCadastroLocalTrabalho, frmCadastroLocalTrabalho);
  frmCadastroLocalTrabalho.SelecionarAtivo := true;
  frmCadastroLocalTrabalho.showmodal;
  frmCadastroLocalTrabalho.free;

  edtlocal.Text := DMcontratos.dslocaltrabalho.DataSet.FieldByName('codigo_local_trabalho').AsString;
end;

procedure TfrmContrato.StringGrid1Exit(Sender: TObject);
begin

end;

//PREVISAO DE ERROS-------------------------------------------------------------

procedure TfrmContrato.DBEdtcpftest2Exit(Sender: TObject);
begin
  utilidades.VerifCPF(DBEdtcpftest2);
end;

procedure TfrmContrato.DBEdtcpftest2KeyPress(Sender: TObject; var Key: char);
begin
  utilidades.MascCPF(DBEdtcpftest2, Key)
end;

procedure TfrmContrato.DBEdtcpfteste1EditingDone(Sender: TObject);
begin

end;

procedure TfrmContrato.DBEdtcpfteste1KeyPress(Sender: TObject; var Key: char);
begin
    utilidades.MascCPF(DBEdtcpfteste1, Key);
end;

procedure TfrmContrato.DBEdthorarioKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil};
end;

procedure TfrmContrato.DBEdtJornadaEditingDone(Sender: TObject);
begin

end;

procedure TfrmContrato.DateEditfinalKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil};
end;

procedure TfrmContrato.DateEditfinalChange(Sender: TObject);
begin

end;

procedure TfrmContrato.DateEditfinalExit(Sender: TObject);
begin

end;

procedure TfrmContrato.DateEditinicialExit(Sender: TObject);
begin

end;

procedure TfrmContrato.DateEditinicialKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil};
end;

procedure TfrmContrato.DBComboBox1Exit(Sender: TObject);
begin

end;

procedure TfrmContrato.DBEdtAnoseletivoExit(Sender: TObject);
begin

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

procedure TfrmContrato.DBEdttest2EditingDone(Sender: TObject);
begin

end;

procedure TfrmContrato.DBEdtteste1Exit(Sender: TObject);
begin

end;

procedure TfrmContrato.DBMemovacanciaExit(Sender: TObject);
begin

end;

procedure TfrmContrato.edtcargoEditingDone(Sender: TObject);
begin
  //filtra ds cargo
  if Length(edtcargo.text) <> 0 then
    filtragem.filtrads('codigo_cargo = ''' + edtcargo.text+'''', 'dscargos');
end;

procedure TfrmContrato.edtcargoKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil};
end;

procedure TfrmContrato.edtcodigocontratoKeyPress(Sender: TObject; var Key: char
  );
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil};
end;

procedure TfrmContrato.edtfuncionarioEditingDone(Sender: TObject);
begin
  //libera campos apenas se funcionario nao contratado
  if Length(edtfuncionario.text) <> 0 then
  begin
    if not DMcontratos.dsContratos.DataSet.Locate('codigo_pessoa', EdtFuncionario.Text,[]) then
    begin
      edtfuncionario.Enabled:=false;
      sbtbuscarpessoa.Enabled:=false;

      sbtbuscarcargo.Enabled:=true;
      DBEdtJornada.Enabled:=true;
      sbtbuscarcargo.Enabled:=true;
      edtcargo.Enabled:=true;
      DBEdtAnoseletivo.Enabled:=true;
      Panel1.Enabled:=true;
      Panel2.Enabled:=true;
      cboxtipo.Enabled:=true;
      DBMemoobs.Enabled:=true;
      DBMemovacancia.Enabled:=true;
      DateEditfinal.Enabled:=true;
      DateEditinicial.Enabled:=true;

      BtnGerarcontrato.Enabled:=true;

      DMcontratos.dsContratos.DataSet.Insert;//coloca table em modo de inserçao

      //filtra dspessoa
      filtragem.filtrads('codigo_pessoa = '''+ edtfuncionario.text+'''','dspessoa');


      //ativa tabelas
      DMcontratos.zt_cargos.Active:=true;
      DMcontratos.zt_cidades.Active:=true;
      DMcontratos.zt_contratos_cargos.Active:=true;

      filtragem.filtrads('codigo_cidade = '''+DMcontratos.dspessoa.DataSet.FieldByName('codigo_cidade').AsString +'''', 'dscidades');

      edtcargo.SetFocus;
    end
    else
    begin
      edtfuncionario.Clear;
      ShowMessage('Funcionário já contratado!');
    end;
  end;
end;

procedure TfrmContrato.DBEdtCodcontratoExit(Sender: TObject);
begin
  //libera novo comtrato apenas se codigo contrato nao existir
  if Length(edtcodigocontrato.text) <> 0 then
  begin
    //buscar se contrato existe
    DMcontratos.zt_contratos.Active:= true;

    filtragem.filtrads('codigo_contrato = '''+edtcodigocontrato.text+'''', 'dscontratos');

    //senao liberar novo contrato
    if DMcontratos.dsContratos.DataSet.RecordCount = 0 then
    begin
      edtcodigocontrato.Enabled:=false;
      sbtbuscacintrato.Enabled:=false;

      edtfuncionario.Enabled:=true;
      sbtbuscarpessoa.Enabled:=true;

      DMcontratos.zt_pessoas.Active:=true;
    end
    else
      ShowMessage('Contrato já existente!');
  end;
end;

procedure TfrmContrato.edtfuncionarioKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil};
end;

procedure TfrmContrato.edtlocalEditingDone(Sender: TObject);
begin
  if Length(edtlocal.text) <> 0 then
    filtragem.filtrads('codigo_local_trabalho = '''+ edtlocal.text+'''','dslocaltrabalho');
end;

procedure TfrmContrato.DBEdtcpftest2EditingDone(Sender: TObject);
begin

end;

procedure TfrmContrato.FormClose(Sender: TObject);
begin
  DeleteDirectory('c:\temp\',false);  //deleta pasta temporaria do contrato

  DMcontratos.free;  //fecha datamodule de controtos
end;



end.

