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
    Btnadicionalocal: TBitBtn;
    BtnGerarcontrato: TBitBtn;
    btnlimparlocais: TBitBtn;
    BtnVoltar: TBitBtn;
    DBEdthorario: TDBEdit;
    dscidades: TDatasource;
    DBComboBox1: TDBComboBox;
    DBEdtcargo: TDBEdit;
    DBEdtcpftest2: TDBEdit;
    DBEdtcpfteste1: TDBEdit;
    DBEdttest2: TDBEdit;
    DBEdtteste1: TDBEdit;
    dspessoa: TDatasource;
    dslocal: TDatasource;
    dscargos: TDatasource;
    DBEdtJornada: TDBEdit;
    DBEdtAnoseletivo: TDBEdit;
    DBMemovacancia: TDBMemo;
    dsContratos: TDatasource;
    DateEditfinal: TDateEdit;
    DateEditinicial: TDateEdit;
    DBMemoobs: TDBMemo;
    edtfuncionario: TEdit;
    edtcodigocontrato: TEdit;
    edtlocal: TEdit;
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
    RadioGroup1: TRadioGroup;
    Radiomanha: TRadioButton;
    Radionoite: TRadioButton;
    Radiotarde: TRadioButton;
    sbtlocal: TSpeedButton;
    sbtpessoa: TSpeedButton;
    sbtcargo: TSpeedButton;
    SpeedButton1: TSpeedButton;
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
    procedure edtcodigocontratoKeyPress(Sender: TObject; var Key: char);
    procedure edtfuncionarioEditingDone(Sender: TObject);
    procedure edtfuncionarioKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure sbtpessoaClick(Sender: TObject);
    procedure RadiomanhaChange(Sender: TObject);
    procedure RadionoiteChange(Sender: TObject);
    procedure RadiotardeChange(Sender: TObject);
    procedure sbtcargoClick(Sender: TObject);
    procedure sbtlocalClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
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
  uCadastroCargos;

var
  linhas, numlocal: byte;

{$R *.lfm}

{ TfrmContrato }

procedure TfrmContrato.BtnVoltarClick(Sender: TObject);
begin
  close;
end;

procedure TfrmContrato.BtnGerarcontratoClick(Sender: TObject);
begin
    if not((DBEdtJornada.text = '') or (DBEdtAnoseletivo.text = '') or
    (DBEdtJornada.text = '')) then
    begin
      if Application.MessageBox('Tem certeza que os campos estão corretos?','Finalizar', MB_OKCANCEL) = idOK then
      begin
        try
          //adiciona demais campos tabela contrato
          dsContratos.DataSet.FieldByName('codigo_contrato').Value  := edtcodigocontrato.text;
          dsContratos.DataSet.FieldByName('codigo_pessoa').Value  := edtfuncionario.text;
          dsContratos.DataSet.FieldByName('periodo_inicial_contrato').Value := DateEditinicial.Text;
          dsContratos.DataSet.FieldByName('periodo_final_contrato').Value := DateEditfinal.Text;
          dsContratos.DataSet.FieldByName('data_contrato').Value := FormatDateTime('dd/mm/yyyy', Date);
          dsContratos.DataSet.FieldByName('salario_contrato').Value := dscargos.DataSet.FieldByName('salario_hora_cargo').value;

          dsContratos.DataSet.Post; //posta
        finally
          html.editahtml(numlocal); //chama o preenchimento do html

          //carrega contrato prenchido
          OpenURL(expandLocalHtmlFileName('contratoatual.html'));

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
end;

procedure TfrmContrato.sbtpessoaClick(Sender: TObject);
begin
  //chama a pesquisa de pessoa
  Application.CreateForm(TfrmPesquisaPessoas, frmPesquisaPessoas);
  frmPesquisaPessoas.showmodal;
  frmPesquisaPessoas.free;

  //filtra o dspessoa para o contrato
  dspessoa.DataSet.Filtered:=false;
  dspessoa.DataSet.Filter:='codigo_pessoa = '''+EdtFuncionario.text+'''';
  dspessoa.DataSet.Filtered:=true;

  //filtra a cidade da pessoa
  dscidades.DataSet.Filtered:=false;
  dscidades.DataSet.Filter:='codigo_cidade = '''+dspessoa.DataSet.FieldByName('codigo_cidade').asstring+'''';
  DBEdtcargo.SetFocus;
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

procedure TfrmContrato.SpeedButton1Click(Sender: TObject);
begin
  dsContratos.DataSet.Active:=true;
  Application.CreateForm(Tfrmbuscacontrato, frmbuscacontrato);
  frmbuscacontrato.ShowModal;
  frmbuscacontrato.Free;
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

procedure TfrmContrato.edtcodigocontratoKeyPress(Sender: TObject; var Key: char
  );
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil};
end;

procedure TfrmContrato.edtfuncionarioEditingDone(Sender: TObject);
begin
  //libera campos apenas se funcionario nao contratado
if edtfuncionario.text <> '' then
begin
  if not dsContratos.DataSet.Locate('codigo_pessoa', EdtFuncionario.Text,[]) then
  begin
    DBEdtJornada.Enabled:=true;
    sbtcargo.Enabled:=true;
    DBEdtcargo.Enabled:=true;
    DBEdtAnoseletivo.Enabled:=true;
    DBEdthorario.Enabled:=true;
    Panel1.Enabled:=true;
    Panel2.Enabled:=true;
    DBComboBox1.Enabled:=true;
    DBMemoobs.Enabled:=true;
    DBMemovacancia.Enabled:=true;
    DateEditfinal.Enabled:=true;
    DateEditinicial.Enabled:=true;

    dsContratos.DataSet.Insert;//coloca table em modo de inserçao
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
dsContratos.Enabled:=true;

  if not(dsContratos.DataSet.Locate('codigo_contrato', edtcodigocontrato.text,[])) then
  begin
    edtcodigocontrato.Enabled:=false;

    edtfuncionario.Enabled:=true;

    sbtpessoa.Enabled:=true;
  end
  else
    ShowMessage('Contrato já existente!');
end;

procedure TfrmContrato.edtfuncionarioKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8{backspace}]) then
    Key := #0{nil};
end;
end.

