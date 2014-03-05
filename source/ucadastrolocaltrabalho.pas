unit UCadastroLocalTrabalho;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  DBGrids, StdCtrls, ExtCtrls, Buttons, Menus, LCLType;

type

  {Quando esse form for chamado por outro por motivo de pesquisa(como buscar o codigo),
   deve-se habilitar o botão "Selecionar", que passa o valor do código para o form
   que o chamou (implementar para cada pesquisa).
   ex: Application.CreateForm(TfrmCadastroLocaltrabalho, frmCadastroLocaltrabalho);
       frmCadastroLocaltrabalho.SelecionarATIVO := true;
       frmCadastroLocaltrabalho.ShowModal;
       frmCadastroLocaltrabalho.Free;

   Caso o form seja aberto pela tela
   principal, o SELECIONAR deve permanecer desabilitado}

  { TfrmCadastroLocalTrabalho }

  TfrmCadastroLocalTrabalho = class(TForm)
    BtnSelecionar: TBitBtn;
    BtnApagar: TBitBtn;
    BtnCancelar: TBitBtn;
    BtnEditar: TBitBtn;
    BtnNovo: TBitBtn;
    BtnSalvar: TBitBtn;
    BtnVoltar: TBitBtn;
    ComboBox1: TComboBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBGrid1: TDBGrid;
    dsLocal_trabalho: TDatasource;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    editPesquisa: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
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
    procedure BtnApagarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnSelecionarClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure DBEdit1Change(Sender: TObject);
    procedure DBEdit3KeyPress(Sender: TObject; var Key: char);
    procedure DBGrid1Enter(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure Edit2KeyPress(Sender: TObject; var Key: char);
    procedure Edit3KeyPress(Sender: TObject; var Key: char);
    procedure Edit4KeyPress(Sender: TObject; var Key: char);
    procedure Edit5KeyPress(Sender: TObject; var Key: char);
    procedure Edit6KeyPress(Sender: TObject; var Key: char);
    procedure editPesquisaChange(Sender: TObject);
    procedure editPesquisaKeyPress(Sender: TObject);
    procedure FormClose(Sender: TObject);
    procedure EditON;
    procedure EditOFF;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    SelecionarAtivo: boolean;
  end;

var
  frmCadastroLocalTrabalho: TfrmCadastroLocalTrabalho;
  campoBusca: string;

implementation

uses
  dmMain,ucontrato, UUtilidades;

{ TfrmCadastroLocalTrabalho }

// INICIO ----------------------------------------------------------------------
procedure TfrmCadastroLocalTrabalho.FormCreate(Sender: TObject);
begin
  SelecionarAtivo := false;    // Atribui valor inicial para depois verificar
end;

procedure TfrmCadastroLocalTrabalho.FormShow(Sender: TObject);
begin
  campoBusca := 'nome_local_trabalho';
  EditOFF;
end;

procedure TfrmCadastroLocalTrabalho.editPesquisaKeyPress(Sender: TObject); // Limpa campo quando usuario
begin                                                                      // começa a digitar
  if (editPesquisa.Text = 'Digite para pesquisar...') then
    editPesquisa.Text := '';
end;

procedure TfrmCadastroLocalTrabalho.DBEdit1Change(Sender: TObject); // Carrega campos de horarios
var
  horario, hMat : string;
  i : integer;
begin
  if (DBEdit1.Text <> '') then
  begin
    // Carrega horarios para campos
      // Matutino
    hMat := dsLocal_trabalho.DataSet.FieldByName('horario_matutino_trabalho').Value;

    horario := '';
    for i := 1 to Length(hMat) do
    begin
      if hmat[i] <> '-' then
      begin
        horario := horario + hMat[i];
      end
      else
      begin
        Edit1.Text := horario;
        horario := '';
      end;
    end;
    Edit2.Text := horario;

      // Vespertino
    hMat := dsLocal_trabalho.DataSet.FieldByName('horario_vespertino_trabalho').Value;

    horario := '';
    for i := 1 to Length(hMat) do
    begin
      if hmat[i] <> '-' then
      begin
        horario := horario + hMat[i];
      end
      else
      begin
        Edit3.Text := horario;
        horario := '';
      end;
    end;
    Edit4.Text := horario;

      // Noturno
    hMat := dsLocal_trabalho.DataSet.FieldByName('horario_noturno_trabalho').Value;

    horario := '';
    for i := 1 to Length(hMat) do
    begin
      if hmat[i] <> '-' then
      begin
        horario := horario + hMat[i];
      end
      else
      begin
        Edit5.Text := horario;
        horario := '';
      end;
    end;
    Edit6.Text := horario;
  end
  else
  begin                    // Limpa campos
    Edit1.Text := '';
    Edit2.Text := '';
    Edit3.Text := '';
    Edit4.Text := '';
    Edit5.Text := '';
    Edit6.Text := '';
  end;
end;

// PREVISAO DE ERROS -----------------------------------------------------------
procedure TfrmCadastroLocalTrabalho.EditON;        // Habilitar Edição
begin
  DBEdit2.ReadOnly := false;
  DBEdit3.ReadOnly := false;
  DBEdit4.ReadOnly := false;
  Edit1.ReadOnly := false;
  Edit2.ReadOnly := false;
  Edit3.ReadOnly := false;
  Edit4.ReadOnly := false;
  Edit5.ReadOnly := false;
  Edit6.ReadOnly := false;

  BtnSalvar.Enabled := true;
  BtnCancelar.Enabled := true;
  BtnNovo.Enabled := false;
  BtnEditar.Enabled := false;
  BtnApagar.Enabled := false;
  BtnSelecionar.Enabled := false;
  BtnVoltar.Enabled := false;
end;

procedure TfrmCadastroLocalTrabalho.EditOFF;       // Desabilitar Edição
begin
  DBEdit2.ReadOnly := true;
  DBEdit3.ReadOnly := true;
  DBEdit4.ReadOnly := true;
  Edit1.ReadOnly := true;
  Edit2.ReadOnly := true;
  Edit3.ReadOnly := true;
  Edit4.ReadOnly := true;
  Edit5.ReadOnly := true;
  Edit6.ReadOnly := true;

  BtnSalvar.Enabled := false;
  BtnCancelar.Enabled := false;
  BtnNovo.Enabled := true;
  BtnEditar.Enabled := true;
  BtnApagar.Enabled := true;
  BtnVoltar.Enabled := true;
  if SelecionarAtivo then  // Verifica se BtnSelecionar esava ativo inicialmente
    BtnSelecionar.Enabled := true;
end;

procedure TfrmCadastroLocalTrabalho.DBGrid1Enter(Sender: TObject); // Ao entrar GRID
begin
  EditOFF;
end;

procedure TfrmCadastroLocalTrabalho.Edit1KeyPress(Sender: TObject; var Key: char
  );                                                               // MASC Horario
begin
  Utilidades.MascHorario(Edit1, Key);
end;

procedure TfrmCadastroLocalTrabalho.Edit2KeyPress(Sender: TObject; var Key: char
  );                                                               // MASC Horario
begin
  Utilidades.MascHorario(Edit2, Key);
end;

procedure TfrmCadastroLocalTrabalho.Edit3KeyPress(Sender: TObject; var Key: char
  );                                                               // MASC Horario
begin
  Utilidades.MascHorario(Edit3, Key);
end;

procedure TfrmCadastroLocalTrabalho.Edit4KeyPress(Sender: TObject; var Key: char
  );                                                               // MASC Horario
begin
  Utilidades.MascHorario(Edit4, Key);
end;

procedure TfrmCadastroLocalTrabalho.Edit5KeyPress(Sender: TObject; var Key: char
  );                                                               // MASC Horario
begin
  Utilidades.MascHorario(Edit5, Key);
end;

procedure TfrmCadastroLocalTrabalho.Edit6KeyPress(Sender: TObject; var Key: char
  );                                                               // MASC Horario
begin
  Utilidades.MascHorario(Edit6, Key);
end;

procedure TfrmCadastroLocalTrabalho.DBEdit3KeyPress(Sender: TObject; // Masc Telefone
  var Key: char);
begin
  Utilidades.MascFone(DBEdit3, Key);
end;

// PESQUISA --------------------------------------------------------------------
procedure TfrmCadastroLocalTrabalho.editPesquisaChange(Sender: TObject); // Atualiza pesquisa
begin
  if (campoBusca = 'codigo_local_trabalho') then     // Se opção selecionada for código
  begin
    if (Length(editPesquisa.Text) = 0) then             // Se usuario apagar todos os caracteres do campo
      DM1.tb_local_trabalho.Filtered := false             // Desabilita filtro para evitar erro
    else
    begin                                                 // Senao executa filtro normalmente
      DM1.tb_local_trabalho.Filter := campoBusca+' = '+ editPesquisa.Text;
      DM1.tb_local_trabalho.Filtered := true; {Pesquisa para código apenas com "="}
    end;
  end
  else
  begin                                              // Se opção selecionada for código -> executa filtro normalmente
    DM1.tb_local_trabalho.Filter := campoBusca+' LIKE '+ QuotedStr('*' + editPesquisa.Text + '*');
    DM1.tb_local_trabalho.Filtered := true;
  end;

  EditOFF;
end;

procedure TfrmCadastroLocalTrabalho.ComboBox1Change(Sender: TObject);
begin
  if (ComboBox1.Text = 'Nome') then                // Altera var com o valor do
    campoBusca := 'nome_local_trabalho'            // campo a ser pesquisado quando
  else                                             // usuario muda comboBox
    campoBusca := 'codigo_local_trabalho';

  EditOFF;
end;

//MENU -------------------------------------------------------------------------
procedure TfrmCadastroLocalTrabalho.BtnSelecionarClick(Sender: TObject);  // Selecionar
begin     // Trocar linha por comando valido
  frmContrato.edtlocal.text := dsLocal_trabalho.DataSet.FieldByName('nome_local_trabalho').value;
  Close;
end;

procedure TfrmCadastroLocalTrabalho.BtnNovoClick(Sender: TObject);    // Novo
begin
  dsLocal_trabalho.DataSet.Insert;

  EditON;
end;

procedure TfrmCadastroLocalTrabalho.BtnSalvarClick(Sender: TObject);  // Salvar
begin
  if (DBEdit2.Text = '') or (DBEdit3.Text = '') or (DBEdit4.Text = '') then  // Se campos principais nao
    ShowMessage('Os campos * são obrigatorios!')                             // estiverem preenchidos
  else if ((Edit1.Text = '') or (Edit2.Text = '')) and ((Edit3.Text = '') or (Edit4.Text = ''))
            and ((Edit5.Text = '') or (Edit6.Text = '')) then                   // Se nenhum campo de horario
    ShowMessage('No minimo um campo de horário deve ser preenchido!')        // estiver preenchido
  else
  begin
    dsLocal_trabalho.DataSet.FieldByName('horario_matutino_trabalho').Value := Edit1.Text +
                                          ' - ' + Edit2.Text;
    dsLocal_trabalho.DataSet.FieldByName('horario_vespertino_trabalho').Value := Edit3.Text +
                                          ' - ' + Edit4.Text;
    dsLocal_trabalho.DataSet.FieldByName('horario_noturno_trabalho').Value := Edit5.Text +
                                          ' - ' + Edit6.Text;

    dsLocal_trabalho.DataSet.Post;    // Salva
    ShowMessage('Registro salvo com sucesso!');

    EditOFF;
  end;
end;

procedure TfrmCadastroLocalTrabalho.BtnVoltarClick(Sender: TObject);  // Voltar
begin
  self.Close;
end;

procedure TfrmCadastroLocalTrabalho.BtnEditarClick(Sender: TObject);  //Editar
begin
  dsLocal_trabalho.DataSet.Edit;

  EditON;
end;

procedure TfrmCadastroLocalTrabalho.BtnApagarClick(Sender: TObject);  // Apagar
begin
  if Application.MessageBox('Deseja realmente apagar o registro?','Apagar registro', MB_YESNO) = idYES then
  begin
    dsLocal_trabalho.DataSet.Delete;
    ShowMessage('Registro apagado com sucesso!');

    EditOFF;
  end;
end;

procedure TfrmCadastroLocalTrabalho.BtnCancelarClick(Sender: TObject);// Cancelar
begin
  dsLocal_trabalho.DataSet.Cancel;

  EditOFF;
end;

// FIM -------------------------------------------------------------------------
procedure TfrmCadastroLocalTrabalho.FormClose(Sender: TObject);     //OnClose
begin
  dsLocal_trabalho.DataSet.Cancel;   // Cancela INSERT se houver

  DM1.tb_local_trabalho.Filtered := false;  // Cancela filtro para não prejudcar outros processos.
end;                                        // Registro selecionado se mantém.

{$R *.lfm}

end.

