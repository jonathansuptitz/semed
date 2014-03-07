unit ULogin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, ExtCtrls, Buttons, db;

type

  { TfrmLogin }

  TfrmLogin = class(TForm)
    BtnEntrar: TBitBtn;
    BtnSair: TBitBtn;
    dsUsuarios: TDatasource;
    Image1: TImage;
    labelUsuario: TEdit;
    labelSenha: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    labelLoading: TLabel;
    ProgressBar1: TProgressBar;
    procedure BtnEntrarClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
    procedure IniciarSistema;
  public
    { public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  dmMain, Umain, UCadastroMural;

{$R *.lfm}

{ TfrmLogin }

// INICIO ----------------------------------------------------------------------

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  // Cria DM e conecta tabela
  Application.CreateForm(TDM1, DM1);
  DM1.tb_usuarios.Active := true;
end;

// BOTOES ----------------------------------------------------------------------

procedure TfrmLogin.BtnEntrarClick(Sender: TObject);         // Entrar
begin
  // Autentica usuário
  if dsUsuarios.DataSet.Locate('login_usuario', labelUsuario.Text, []) then
  begin
    if (dsUsuarios.DataSet.FieldByName('senha_usuario').Value = labelSenha.Text) then
    begin
      ProgressBar1.StepBy(0);
      labelLoading.Caption := 'Pesquisando usuário...';
      Update;
      //Sleep(500);
      IniciarSistema;
    end
    else
      ShowMessage('Usuário ou senha não encontrado!');
  end
  else
    ShowMessage('Usuário ou senha não encontrado!');
end;

procedure TfrmLogin.BtnSairClick(Sender: TObject);           // Sair
begin
  Application.Terminate;
end;

// INICIAR SISTEMA -------------------------------------------------------------

procedure TfrmLogin.IniciarSistema;                 // Inicia Sistema
var
  SL, SLdescript : TStringList;
  i, x : integer;
  caracCript, linha, linhaDescript : string;
  caracDescript : char;

  DBnome, DBip, DBusu, DBsenha : string;
begin
  // BANCO DE DADOS ------------------------------------------------------------
  // Ler CFG --------------------------
  ProgressBar1.StepIt;
  labelLoading.Caption := 'Descriptografando arquivos de configuração...';
  Update;
  //Sleep(500);
  try
      // Cria SL
      SLdescript := TStringList.Create;
      SL := TStringList.Create;
      // Carrega arquivo cfg
      SL.LoadFromFile('conf/db.cfg');

      // Descriptografa
      for x := 0 to SL.Count - 1 do // Varre linha a linha
      begin
        caracCript := '';
        caracDescript := #0;
        linhaDescript := '';
        for i := 1 to Length(SL[x]) do  // Varre caracter a caracter
        begin
          linha := SL[x];

          if linha[i] = ';' then   // Se for ";" converte para char
          begin
            // Descriptografa caractere
            caracDescript := Char(trunc((StrToInt(caracCript) / 3) - 3));
            //Adiciona a linha geral
            linhaDescript := linhaDescript + caracDescript;
            // Zera var que junta numeros que formam asc
            caracCript := '';
          end
          else
          begin
            caracCript := caracCript + linha[i]; // junta numeros ate encontrar ";"
          end;
        end;
        SLDescript.Add(linhaDescript);
      end;

      // Grava informações na memoria
      DBnome := SLdescript[0];
      DBip := SLdescript[0];
      DBusu := SLdescript[0];
      DBsenha := SLdescript[0];

    finally
      SL.Free;
      SLDescript.Free;
    end;


  // Conectar -------------------------
  ProgressBar1.StepIt;                                     // ---
  labelLoading.Caption := 'Conectando ao Banco de Dados...';
  Update;
  //Sleep(500);
  with DM1 do
  begin
    // Le informações
    SEMEDconnection.Database := DBnome;
    SEMEDconnection.HostName := DBip;
    SEMEDconnection.User := DBusu;
    SEMEDconnection.Password := DBsenha;
    // Conecta ao banco
    SEMEDconnection.Connected := true;

    ProgressBar1.StepIt;                                     // ---
    labelLoading.Caption := 'Realizando ligações...';
    frmLogin.Update;
    //Sleep(500);

    //Habilita tabelas
    tb_cidades.Active := true;
    tb_pessoas.Active := true;
    tb_local_trabalho.Active := true;
    querycontratos.Active := true;
    tb_cargos.Active := true;
    tb_mural.Active := true;
  end;

  // MURAL ---------------------------------------------------------------------
  ProgressBar1.StepIt;                                     // ---
  labelLoading.Caption := 'Atualizando Mural de Recados...';
  Update;
  //Sleep(500);

  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TfrmCadastroMural, frmCadastroMural);
  frmCadastroMural.AtualizarMural;

  // BARRA de STATUS -----------------------------------------------------------

  FrmMain.StatusBar.Panels[3].Text := dsUsuarios.DataSet.FieldByName('nome_usuario').Value;

  // INICIAR -------------------------------------------------------------------
  ProgressBar1.StepIt;                                     // ---
  labelLoading.Caption := 'Criando Interface de usuário...';
  Update;
  //Sleep(500);

  FrmMain.Show;

  self.Hide;
end;

end.

