unit UCadastroMural;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  StdCtrls, ExtCtrls, LCLType, dateutils;

type

  { TfrmCadastroMural }

  TfrmCadastroMural = class(TForm)
    DBEdit1: TDBEdit;
    DBMemo1: TDBMemo;
    dsMural: TDatasource;
    BtnSalvar: TImage;
    BtnCancelar: TImage;
    Label1: TLabel;
    Label2: TLabel;
    labelRestantes: TLabel;
    Timer1: TTimer;
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure DBMemo1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure LimparRegistrosAntigos;
    procedure AtualizarMural;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCadastroMural: TfrmCadastroMural;
  UltimoRegistro: integer;

implementation

uses
  Umain;

{$R *.lfm}

{ TfrmCadastroMural }

// INICIO ----------------------------------------------------------------------

procedure TfrmCadastroMural.FormCreate(Sender: TObject);
begin
  dsMural.DataSet.Last;                  // Salva codigo do utimo registro
  UltimoRegistro := dsMural.DataSet.FieldByName('codigo_mural').AsInteger;

  dsMural.DataSet.Insert;
end;

// UTILIDADES ------------------------------------------------------------------

procedure TfrmCadastroMural.AtualizarMural;     // Atualiza Mural
begin
  LimparRegistrosAntigos;  // Apaga registros anteriores a -14 dias

  with FrmMain do
  begin
    dsMural.DataSet.First;

    memoMural.Lines.Clear;        // Limpa MEMO
    memoMural.Lines.Add('----- INICIO DOS REGISTROS -----');
    memoMural.Lines.Add('');

    while not (dsMural.DataSet.EOF) do  //Enquanto nao for fim dos registros
    begin
      memoMural.Lines.Add('* ' + dsMural.DataSet.FieldByName('data_mural').Value +   // Escreve data e nome
                          ', por ' + dsMural.DataSet.FieldByName('usuario_mural').Value + ':');
      memoMural.Lines.Add(dsMural.DataSet.FieldByName('conteudo_mural').Value);  // Escreve conteudo
      memoMural.Lines.Add('');                                                   // Pula linha

      if not (dsMural.DataSet.EOF) then   // Se nao for ultimo registro, passa para proximo
        dsMural.DataSet.Next;
    end;
  end;
end;

procedure TfrmCadastroMural.LimparRegistrosAntigos;     // Apaga registros anteriores a -14 dias
var
  dataRegistro, data: string;
  tamanhoData: integer;
begin
  FrmMain.dsMural.DataSet.First;
  while not (FrmMain.dsMural.DataSet.EOF) do  //Enquanto nao for fim dos registros
  begin
    dataRegistro := FrmMain.dsMural.DataSet.FieldByName('data_mural').Value;

    tamanhoData := 8; // Tamanho da data para copiar
    if dataRegistro[3] = '/' then    // Caso o dia possua 2 carac.
    begin
      inc(tamanhoData);
      if dataRegistro[6] = '/' then  // Caso o dia e o mes possuam 2 carac.
        inc(tamanhoData);
    end
    else if dataregistro[5] = '/' then  // Caso o mes possua 2 carac.
      inc(tamanhoData);

    data := Copy(dataRegistro, 1, tamanhoData); // Copia apenas data para variavel

    if (StrToDate(data) < IncDay(Date, -14)) then // verifica se data é mais antiga que 14 dias
    begin
      FrmMain.dsMural.DataSet.Delete; // Apaga registro
    end;

    if not (FrmMain.dsMural.DataSet.EOF) then   // Se nao for ultimo registro, passa para proximo
      FrmMain.dsMural.DataSet.Next;
  end;
end;

procedure TfrmCadastroMural.DBMemo1Change(Sender: TObject); // Atualiza marcador de
begin                                                       // caracteres restantes
  labelRestantes.Caption := 'Restantes: ' + IntToStr(200 - Length(DBMemo1.Text));
end;

// BOTOES ----------------------------------------------------------------------

procedure TfrmCadastroMural.BtnCancelarClick(Sender: TObject);  // Cancelar
begin
  Self.Close;
end;

procedure TfrmCadastroMural.BtnSalvarClick(Sender: TObject);    // Salvar
begin
  if (DBMemo1.Text = '') or (DBEdit1.Text = '') then  // Verifica se campos estão preenchidos
    ShowMessage('Todos os campos são obrigatorios!')
  else
  begin
    if Application.MessageBox('O recado não pode ser apagado! Deseja continuar?','Inserir recado', MB_YESNO) = idYES then
    begin
      dsMural.DataSet.FieldByName('codigo_mural').Value := UltimoRegistro + 1;
      dsMural.DataSet.FieldByName('data_mural').Value := DateToStr(Date) + ' ' + TimeToStr(Time); //Insere data e hora
      dsMural.DataSet.Post;   // Salva
                                                             // Exibe mensagem de aviso
      ShowMessage('Recado salvo com sucesso! O mesmo será automaticamente apagado após 14 dias.');

      AtualizarMural; // Atualiza o MEMO
      self.Close;  // Fecha o form
    end;
  end;
end;

// FIM -------------------------------------------------------------------------

procedure TfrmCadastroMural.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  dsMural.DataSet.Cancel;
end;

end.

