unit uusuarios;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids, Buttons, DbCtrls, LCLType;

type

  { TfrmUsuarios }

  TfrmUsuarios = class(TForm)
    BtnApagar: TBitBtn;
    BtnCancelar: TBitBtn;
    BtnEditar: TBitBtn;
    BtnNovo: TBitBtn;
    BtnSalvar: TBitBtn;
    BtnVoltar: TBitBtn;
    comboNivelAcesso: TDBComboBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBGrid1: TDBGrid;
    dsUsuarios: TDatasource;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BtnApagarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure comboNivelAcessoChange(Sender: TObject);
    procedure DBEdit1Change(Sender: TObject);
    procedure EditON;
    procedure EditOFF;
    procedure FormClose(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmUsuarios: TfrmUsuarios;

implementation

{$R *.lfm}

// INICIO ----------------------------------------------------------------------

procedure TfrmUsuarios.FormShow(Sender: TObject);
begin
  EditOFF;
end;

// PROCEDURES ------------------------------------------------------------------

procedure TfrmUsuarios.DBEdit1Change(Sender: TObject);      // Atualizar label do
begin                                                       // comboBox nivel_acesso
  if comboNivelAcesso.Text = '1' then
    Label7.Caption := 'Administrador'
  else if comboNivelAcesso.Text = '2' then
    Label7.Caption := 'Usuario';
end;

procedure TfrmUsuarios.comboNivelAcessoChange(Sender: TObject);  // Atualizar label do
begin                                                            // comboBox nivel_acesso
  if comboNivelAcesso.Text = '1' then
    Label7.Caption := 'Administrador'
  else if comboNivelAcesso.Text = '2' then
    Label7.Caption := 'Usuario';
end;

procedure TfrmUsuarios.EditON;
begin
  DBEdit2.ReadOnly := false;
  DBEdit3.ReadOnly := false;
  DBEdit4.ReadOnly := false;
  BtnNovo.Enabled := false;
  BtnEditar.Enabled := false;
  BtnApagar.Enabled := false;
  BtnSalvar.Enabled := true;
  BtnCancelar.Enabled := true;
  BtnVoltar.Enabled := false;
  comboNivelAcesso.Enabled := true;
end;

procedure TfrmUsuarios.EditOFF;
begin
  DBEdit2.ReadOnly := true;
  DBEdit3.ReadOnly := true;
  DBEdit4.ReadOnly := true;
  BtnNovo.Enabled := true;
  BtnEditar.Enabled := true;
  BtnApagar.Enabled := true;
  BtnSalvar.Enabled := false;
  BtnCancelar.Enabled := false;
  BtnVoltar.Enabled := true;
  comboNivelAcesso.Enabled := false;
end;

// MENU ------------------------------------------------------------------------

procedure TfrmUsuarios.BtnNovoClick(Sender: TObject);            // Novo
begin
  dsUsuarios.DataSet.Insert;
  EditON;
end;

procedure TfrmUsuarios.BtnSalvarClick(Sender: TObject);          // Salvar
begin
  if (DBEdit2.Text <> '') and (DBEdit3.Text <> '') and
     (DBEdit4.Text <> '') and (comboNivelAcesso.Text <> '') then
  begin
    dsUsuarios.DataSet.Post;
    EditOFF;
    ShowMessage('Cadastro salvo com sucesso!');
  end
  else
    ShowMessage('Todos os campos são obrigatorios!');
end;

procedure TfrmUsuarios.BtnVoltarClick(Sender: TObject);          // Voltar
begin
  Close;
end;

procedure TfrmUsuarios.BtnEditarClick(Sender: TObject);          // Editar
begin
  dsUsuarios.DataSet.Edit;
  EditON;
end;

procedure TfrmUsuarios.BtnApagarClick(Sender: TObject);          // Apagar
begin
  if Application.MessageBox('Deseja realmente apagar o registro?','Apagar registro', MB_YESNO) = idYES then
  begin
    dsUsuarios.DataSet.Delete;
    ShowMessage('Registro apagado com sucesso!');
    EditOFF;
  end;
end;

procedure TfrmUsuarios.BtnCancelarClick(Sender: TObject);        // Cancelar
begin
  dsUsuarios.DataSet.Cancel;
  EditOFF;
end;

// FIM -------------------------------------------------------------------------

procedure TfrmUsuarios.FormClose(Sender: TObject);
begin
  dsUsuarios.DataSet.Cancel;
end;

end.

