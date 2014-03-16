unit uCadastroPessoas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  StdCtrls, ExtCtrls, Buttons, LCLType, ZDataset;

type

  { TfrmCadastroPessoas }

  TfrmCadastroPessoas = class(TForm)
    BtnPesquisar: TBitBtn;
    BtnVoltar: TBitBtn;
    BtnEditar: TBitBtn;
    BtnNovo: TBitBtn;
    BtnSalvar: TBitBtn;
    BtnCancelar: TBitBtn;
    BtnApagar: TBitBtn;
    comboEstadoCivil: TDBComboBox;
    DBEdit1: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit21: TDBEdit;
    DBEdit22: TDBEdit;
    DBEdit23: TDBEdit;
    DBEdit24: TDBEdit;
    DBEdit25: TDBEdit;
    DBEdit26: TDBEdit;
    DBEdit27: TDBEdit;
    DBEdit28: TDBEdit;
    DBEdit29: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit31: TDBEdit;
    DBEdit32: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    comboCidade: TDBLookupComboBox;
    DBMemo1: TDBMemo;
    dsCidades: TDatasource;
    dsPessoas: TDatasource;
    GroupBox1: TGroupBox;
    GroupBox10: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
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
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    panelCentro: TPanel;
    ScrollBox1: TScrollBox;
    procedure BtnApagarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure DBEdit11KeyPress(Sender: TObject; var Key: char);
    procedure DBEdit15KeyPress(Sender: TObject; var Key: char);
    procedure DBEdit16KeyPress(Sender: TObject; var Key: char);
    procedure DBEdit20KeyPress(Sender: TObject; var Key: char);
    procedure DBEdit23KeyPress(Sender: TObject; var Key: char);
    procedure DBEdit26KeyPress(Sender: TObject; var Key: char);
    procedure DBEdit29KeyPress(Sender: TObject; var Key: char);
    procedure DBEdit2Exit(Sender: TObject);
    procedure DBEdit2KeyPress(Sender: TObject; var Key: char);
    procedure DBEdit32KeyPress(Sender: TObject; var Key: char);
    procedure DBEdit4KeyPress(Sender: TObject; var Key: char);
    procedure DBEdit6KeyPress(Sender: TObject; var Key: char);
    procedure DBEdit7KeyPress(Sender: TObject; var Key: char);
    procedure DBEdit8KeyPress(Sender: TObject; var Key: char);
    procedure EditON;
    procedure EditOff;
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCadastroPessoas: TfrmCadastroPessoas;

implementation

uses
  dmMain, uPesquisaPessoas, uUtilidades;

{$R *.lfm}

{ TfrmCadastroPessoas }

// INICIO ----------------------------------------------------------------------

procedure TfrmCadastroPessoas.FormCreate(Sender: TObject);
begin
  EditOff;

  dsPessoas.DataSet.Refresh; // Gambiara master para carregar todos os campos
end;

// MASCARAS E VERIFICADORES ----------------------------------------------------
procedure TfrmCadastroPessoas.DBEdit2Exit(Sender: TObject);  // CPF - verif
var
  queryConsultaCPF : TZReadOnlyQuery;
  cpfCadastrado: string;
begin
  if (utilidades.VerifCPF(DBEdit2)) then   // Chama verificador(que trata o erro) e verifica
  begin                                    // para chamar proximo teste
    try
      // Verifica se CPF inserido já existe
      queryConsultaCPF := TZReadOnlyQuery.Create(nil);
      queryConsultaCPF.Connection := DM1.SEMEDconnection;
      // Guarda CPF ja cadastrado
      queryConsultaCPF.SQL.Clear;
      queryConsultaCPF.SQL.Add('SELECT cpf_pessoa FROM tb_pessoas WHERE codigo_pessoa = ' + DBEdit1.Text + '');
      queryConsultaCPF.Open;
      cpfCadastrado := queryConsultaCPF.FieldByName('cpf_pessoa').Value;
      queryConsultaCPF.Close;
      // Verifica de CPF ja existe
      queryConsultaCPF.SQL.Clear;
      queryConsultaCPF.SQL.Add('SELECT cpf_pessoa FROM tb_pessoas WHERE cpf_pessoa = "' + DBEdit2.Text + '"');
      queryConsultaCPF.Open;

      if not (queryConsultaCPF.IsEmpty) and
             (cpfCadastrado <> DBEdit2.Text) then
      begin
        ShowMessage('CPF já cadastrado!');
        DBEdit2.SetFocus;
      end;
    finally
      queryConsultaCPF.Close;
      queryConsultaCPF.Free;
    end;
  end;
end;

procedure TfrmCadastroPessoas.DBEdit2KeyPress(Sender: TObject; var Key: char);  //CPF
begin
  utilidades.MascCPF(DBEdit2, Key);
end;

procedure TfrmCadastroPessoas.DBEdit32KeyPress(Sender: TObject; var Key: char); //CEP
begin
  Utilidades.MascCEP(DBEdit32, Key);
end;

procedure TfrmCadastroPessoas.DBEdit4KeyPress(Sender: TObject; var Key: char);  //RG
begin
  Utilidades.MascRG(Key);
end;

procedure TfrmCadastroPessoas.DBEdit6KeyPress(Sender: TObject; var Key: char);  //Nascimento
begin
  Utilidades.MascData(DBEdit6, Key);
end;

procedure TfrmCadastroPessoas.DBEdit7KeyPress(Sender: TObject; var Key: char);  // Fone 1
begin
  utilidades.MascFone(DBEdit7, Key);
end;

procedure TfrmCadastroPessoas.DBEdit8KeyPress(Sender: TObject; var Key: char);  // Fone 2
begin
  Utilidades.MascFone(DBEdit8, Key);
end;

procedure TfrmCadastroPessoas.DBEdit11KeyPress(Sender: TObject; var Key: char); //Ano medio
begin
  Utilidades.MascAno(DBEdit11, Key);
end;

procedure TfrmCadastroPessoas.DBEdit15KeyPress(Sender: TObject; var Key: char); // Ano grad 1
begin
  Utilidades.MascAno(DBEdit15, Key);
end;

procedure TfrmCadastroPessoas.DBEdit16KeyPress(Sender: TObject; var Key: char); // Ano grad 2
begin
  Utilidades.MascAno(DBEdit16, Key);
end;

procedure TfrmCadastroPessoas.DBEdit20KeyPress(Sender: TObject; var Key: char); // Ano pos 1
begin
  Utilidades.MascAno(DBEdit20, Key);
end;

procedure TfrmCadastroPessoas.DBEdit23KeyPress(Sender: TObject; var Key: char); // Ano pos 2
begin
  Utilidades.MascAno(DBEdit23, Key);
end;

procedure TfrmCadastroPessoas.DBEdit26KeyPress(Sender: TObject; var Key: char); // Ano mestrado
begin
  Utilidades.MascAno(DBEdit26, Key);
end;

procedure TfrmCadastroPessoas.DBEdit29KeyPress(Sender: TObject; var Key: char); // Ano doutorado
begin
  Utilidades.MascAno(DBEdit29, Key);
end;

// PREVISAO DE ERROS -----------------------------------------------------------

procedure TfrmCadastroPessoas.EditON;        // Habilitar Edição
var
  componente: TComponent;
  i: integer;
begin
  for i := 2 to 29 do
  begin
    componente := FindComponent('DBEdit' + IntToStr(i));
    (componente as TDBEdit).ReadOnly := false;
  end;
  DBEdit31.ReadOnly := false;
  DBEdit32.ReadOnly := false;
  comboEstadoCivil.Enabled := true;
  comboCidade.Enabled := true;
  DBMemo1.ReadOnly := false;

  BtnSalvar.Enabled := true;
  BtnCancelar.Enabled := true;
  BtnNovo.Enabled := false;
  BtnEditar.Enabled := false;
  BtnApagar.Enabled := false;
  BtnVoltar.Enabled := false;
  BtnPesquisar.Enabled := false;
end;

procedure TfrmCadastroPessoas.EditOFF;       // Desabilitar Edição
var
  componente: TComponent;
  i: integer;
begin
  for i := 2 to 29 do
  begin
    componente := FindComponent('DBEdit' + IntToStr(i));
    (componente as TDBEdit).ReadOnly := true;
  end;
  DBEdit31.ReadOnly := true;
  DBEdit32.ReadOnly := true;
  comboEstadoCivil.Enabled := false;
  comboCidade.Enabled := false;
  DBMemo1.ReadOnly := true;

  BtnSalvar.Enabled := false;
  BtnCancelar.Enabled := false;
  BtnNovo.Enabled := true;
  BtnEditar.Enabled := true;
  BtnApagar.Enabled := true;
  BtnVoltar.Enabled := true;
  BtnPesquisar.Enabled := true;
end;

// BOTOES MENU -----------------------------------------------------------------
procedure TfrmCadastroPessoas.BtnVoltarClick(Sender: TObject);      // Voltar
begin
  dsPessoas.DataSet.Cancel; // Cancela insert (se houver)
  self.Close;
end;

procedure TfrmCadastroPessoas.BtnNovoClick(Sender: TObject);        // Novo
begin
  dsPessoas.DataSet.Insert;

  EditON;
end;

procedure TfrmCadastroPessoas.BtnPesquisarClick(Sender: TObject);   // Pesquisar
begin
  EditOff;
  Application.CreateForm(TfrmPesquisaPessoas, frmPesquisaPessoas);
  frmPesquisaPessoas.BtnNovo.Visible := false;  //Desabilita botão de novo cadastro
  frmPesquisaPessoas.ShowModal;                 // na pesquisa. para evitar suplicação de tela
  frmPesquisaPessoas.Free;
end;

procedure TfrmCadastroPessoas.BtnSalvarClick(Sender: TObject);      // Salvar
var
  componente: TComponent;
  i: integer;
  editFormacaoLimpos: boolean;
begin
  editFormacaoLimpos := true;

  for i := 10 to 29 do             // Verrifica de se pelo menos 1 campo de formação
  begin                            // academica foi preenchido
    componente := FindComponent('DBEdit' + IntToStr(i));
    if (componente as TDBEdit).Text <> '' then
      editFormacaoLimpos := false;
  end;

  if (DBEdit2.Text = '') or (DBEdit3.Text = '') or (DBEdit4.Text = '') or       // Se campos principais nao
      (DBEdit5.Text = '') or (DBEdit6.Text = '') or (DBEdit7.Text = '') or      // estiverem preenchidos
      (DBEdit31.Text = '') or (DBEdit32.Text = '') or (comboEstadoCivil.Text = '') or
      (comboCidade.Text = '') or (DBMemo1.Text = '') then
    ShowMessage('Os campos * são obrigatorios!')
  else if editFormacaoLimpos then                                               // Se nenhum campo de formacao
  begin                                                                         // estiver preenchido
    if Application.MessageBox('É recomendado preencher os campos sobre "Formação Academica".'+
                              'Deseja continuar mesmo assim?','Formação Academica', MB_YESNO) = idYES then
    begin
      dsPessoas.DataSet.Post;
      EditOff;
      ShowMessage('Registro salvo com sucesso!');
    end
    else
      abort;
  end
  else
  begin
    dsPessoas.DataSet.Post;
    EditOff;
    ShowMessage('Registro salvo com sucesso!');
  end;
end;

procedure TfrmCadastroPessoas.BtnEditarClick(Sender: TObject);      // Editar
begin
  dsPessoas.DataSet.Edit;

  EditON;
end;

procedure TfrmCadastroPessoas.BtnApagarClick(Sender: TObject);      // Apagar
begin
  if Application.MessageBox('Deseja realmente apagar o registro?','Apagar registro', MB_YESNO) = idYES then
  begin
    dsPessoas.DataSet.Delete;
    ShowMessage('Registro apagado com sucesso!');

    EditOff;
  end;
end;

procedure TfrmCadastroPessoas.BtnCancelarClick(Sender: TObject);    // Cancelar
begin
  dsPessoas.DataSet.Cancel;

  EditOff;
end;
// -----------------------------------------------------------------------------

end.

