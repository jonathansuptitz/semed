unit ucontrato;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Ipfilebroker, IpHtml,
 Forms, Controls, Graphics,
  Dialogs, Buttons, ExtCtrls, LCLIntf,
  DbCtrls, StdCtrls, EditBtn, Printers, Grids, LCLType, DBGrids;

type

  { TfrmContrato }

  TfrmContrato = class(TForm)
    Btnadicionalocal: TBitBtn;
    BtnGerarcontrato: TBitBtn;
    btnlimparlocais: TBitBtn;
    BtnVoltar: TBitBtn;
    DBEdthorario: TDBEdit;
    DBComboBox1: TDBComboBox;
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
    procedure DateEditfinalKeyPress(Sender: TObject; var Key: char);
    procedure DateEditinicialKeyPress(Sender: TObject; var Key: char);
    procedure DBEdtAnoseletivoKeyPress(Sender: TObject; var Key: char);
    procedure DBEdtcargoKeyPress(Sender: TObject; var Key: char);
    procedure DBEdtCodcontratoExit(Sender: TObject);
    procedure BtnadicionalocalClick(Sender: TObject);
    procedure BtnGerarcontratoClick(Sender: TObject);
    procedure btnlimparlocaisClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure DBEdtcpftest2Exit(Sender: TObject);
    procedure DBEdtcpftest2KeyPress(Sender: TObject; var Key: char);
    procedure DBEdtcpfteste1EditingDone(Sender: TObject);
    procedure DBEdtcpfteste1KeyPress(Sender: TObject; var Key: char);
    procedure DBEdthorarioKeyPress(Sender: TObject; var Key: char);
    procedure DBEdtJornadaKeyPress(Sender: TObject; var Key: char);
    procedure edtcargoEditingDone(Sender: TObject);
    procedure edtcargoKeyPress(Sender: TObject; var Key: char);
    procedure edtcodigocontratoKeyPress(Sender: TObject; var Key: char);
    procedure edtfuncionarioEditingDone(Sender: TObject);
    procedure edtfuncionarioKeyPress(Sender: TObject; var Key: char);
    procedure edtlocalEditingDone(Sender: TObject);
    procedure FormClose(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgHorariosChangeBounds(Sender: TObject);
    procedure rgHorariosClick(Sender: TObject);
    procedure sbtbuscacintratoClick(Sender: TObject);
    procedure sbtbuscarpessoaClick(Sender: TObject);
    procedure sbtbuscarcargoClick(Sender: TObject);
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
  uPesquisaPessoas, ubuscacontrato, UUtilidades, uhtml , UCadastroLocalTrabalho,
  uCadastroCargos, udmcontratos, ufiltragem;

var
  linhas: byte;
  horarios, numlocal : string;

{$R *.lfm}

{ TfrmContrato }

//frmcontrato close ------------------------------------------------------------
procedure TfrmContrato.BtnVoltarClick(Sender: TObject);
begin
  close;
end;

//btngerarcontrato click -------------------------------------------------------
procedure TfrmContrato.BtnGerarcontratoClick(Sender: TObject);
var
  i : integer;
begin
  if Application.MessageBox('Tem certeza que os campos estão corretos?','Finalizar', MB_OKCANCEL) = idOK then
  begin
    try
      //adiciona demais campos tabela contrato
      with udmcontratos.dmcontratos.zt_contratos do
      begin
        FieldByName('codigo_contrato').Value  := edtcodigocontrato.text;
        FieldByName('codigo_pessoa').Value  := edtfuncionario.text;
        FieldByName('codigo_cargo').value := edtcargo.text;
        FieldByName('periodo_inicial_contrato').Value := DateEditinicial.Text;
        FieldByName('periodo_final_contrato').Value := DateEditfinal.Text;
        FieldByName('data_contrato').Value := FormatDateTime('dd/mm/yyyy', Date);
        FieldByName('salario_contrato').Value := DMcontratos.dscargos.DataSet.FieldByName('salario_hora_cargo').value;
      //
        Post; //posta

        //salva locais do contrato
        for i := 1 to Length(numlocal) do
        begin
          with DMcontratos.dscontratoslocais.DataSet do
          begin
            filtragem.filtrads('codigo_local_trabalho = '''+numlocal[i]+'''','dslocaltrabalho');

            FieldByName('codigo_contrato').value
            := DMcontratos.dscontratos.DataSet.FieldByName('codigo_contrato').value;

            FieldByName('codigo_local_trabalho').value
            := DMcontratos.dslocaltrabalho.DataSet.FieldByName('codigo_contrato').value;

            post;
          end;
        end;
        //
      end;
    finally
      html.editahtml(numlocal, horarios); //chama o preenchimento do html

      //carrega contrato prenchido
      OpenURL(expandLocalHtmlFileName('contratoatual.html'));

      frmContrato.close; //fecha form
    end;
  end
  else
    ShowMessage('Preencha todos os campos!');
end;

//limpar locais da grid locais -------------------------------------------------
procedure TfrmContrato.btnlimparlocaisClick(Sender: TObject);
begin
  StringGrid1.Clean(0,1,1,3,[gznormal]);
  numlocal := '';
  horarios:='';
end;

//adicionar locais a grid locais -----------------------------------------------
procedure TfrmContrato.BtnadicionalocalClick(Sender: TObject);
begin
  //adiociona mais locais de trabalho
  StringGrid1.Cells[0,linhas] := DMcontratos.dslocaltrabalho.DataSet.FieldByName('nome_local_trabalho').value;
  StringGrid1.Cells[1,linhas] := DBEdthorario.text;

  if linhas = 3 then
    linhas := 1
  else
    inc(linhas);

  numlocal:= numlocal + DMcontratos.dslocaltrabalho.DataSet.FieldByName('codigo_local_trabalho').AsString;

  case rgHorarios.ItemIndex of
    0: horarios:= horarios + '1';
    1: horarios:= horarios + '2';
    2: horarios:= horarios + '3';
  end;
end;


//frmcontratos show ------------------------------------------------------------
procedure TfrmContrato.FormShow(Sender: TObject);
begin
  //cria dmcontratos
  Application.CreateForm(TDMcontratos, DMcontratos);
  //ativa table contratos
  DMcontratos.zt_contratos.Active:= true;

  //inicializa variaveis para varios locais
  linhas := 1;
  numlocal := '';
  horarios:='';
  //--

  //prenche combobox de tipo de contrataçao
  with DBComboBox1 do
  begin
    clear;
    Items.Add('Seletivo');
    Items.Add('cadastro RH');
    Items.Add('Contratação direta');
  end;
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

  //filtra ds cargo
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
  utilidades.VerifCPF(DBEdtcpfteste1);
end;

procedure TfrmContrato.DBEdtcpfteste1KeyPress(Sender: TObject; var Key: char);
begin
  utilidades.MascCPF(DBEdtcpfteste1, Key)
end;

procedure TfrmContrato.DBEdthorarioKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil};
end;

procedure TfrmContrato.DateEditfinalKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil};
end;

procedure TfrmContrato.DateEditinicialKeyPress(Sender: TObject; var Key: char);
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
      DBComboBox1.Enabled:=true;
      DBMemoobs.Enabled:=true;
      DBMemovacancia.Enabled:=true;
      DateEditfinal.Enabled:=true;
      DateEditinicial.Enabled:=true;

      DMcontratos.dsContratos.DataSet.Insert;//coloca table em modo de inserçao

      //filtra dspessoa
      filtragem.filtrads('codigo_pessoa = '''+ edtfuncionario.text+'''','dspessoa');

      //ativa tabelas
      DMcontratos.zt_cargos.Active:=true;
      DMcontratos.zt_cidades.Active:=true;
      DMcontratos.zt_contratos_cargos.Active:=true;

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
    DMcontratos.dsContratos.DataSet.Filter := 'codigo_contrato = '''+edtcodigocontrato.text+'''';
    DMcontratos.dsContratos.DataSet.Filtered:=true;

    //senao liberar novo contrato
    if DMcontratos.dsContratos.DataSet.FieldCount <> 0 then
    begin
      DMcontratos.dsContratos.DataSet.Filtered:=false;

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

procedure TfrmContrato.FormClose(Sender: TObject);
begin
  //fecha datamodule de controtos
  DMcontratos.free;
end;

end.

