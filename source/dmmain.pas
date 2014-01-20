unit dmMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, ZConnection, ZDataset,
  Forms, Controls, Graphics, Dialogs;

type

  { TDM1 }

  TDM1 = class(TDataModule)
    SEMEDconnection: TZConnection;
    tb_pessoas: TZTable;
    tb_pessoasano_doutorado_pessoa: TLongintField;
    tb_pessoasano_graduacao1_pessoa: TLongintField;
    tb_pessoasano_graduacao2_pessoa: TLongintField;
    tb_pessoasano_medio_pessoa: TLongintField;
    tb_pessoasano_mestrado_pessoa: TLongintField;
    tb_pessoasano_pos1_pessoa: TLongintField;
    tb_pessoasano_pos2_pessoa: TLongintField;
    tb_pessoasbairro_pessoa: TStringField;
    tb_pessoascep_pessoa: TStringField;
    tb_pessoascodigo_cidade: TLongintField;
    tb_pessoascodigo_pessoa: TLongintField;
    tb_pessoascpf_pessoa: TStringField;
    tb_pessoasdesc_doutorado_pessoa: TStringField;
    tb_pessoasdesc_graduacao1_pessoa: TStringField;
    tb_pessoasdesc_graduacao2_pessoa: TStringField;
    tb_pessoasdesc_mestrado_pessoa: TStringField;
    tb_pessoasdesc_pos1_pessoa: TStringField;
    tb_pessoasdesc_pos2_pessoa: TStringField;
    tb_pessoasemail_pessoa: TStringField;
    tb_pessoasendereco_pessoa: TStringField;
    tb_pessoasestado_civil_pessoa: TStringField;
    tb_pessoasinst_doutorado_pessoa: TStringField;
    tb_pessoasinst_graduacao1_pessoa: TStringField;
    tb_pessoasinst_graduacao2_pessoa: TStringField;
    tb_pessoasinst_medio_pessoa: TStringField;
    tb_pessoasinst_mestrado_pessoa: TStringField;
    tb_pessoasinst_pos1_pessoa: TStringField;
    tb_pessoasinst_pos2_pessoa: TStringField;
    tb_pessoasnacionalidade_pessoa: TStringField;
    tb_pessoasnascimento_pessoa: TStringField;
    tb_pessoasnome_pessoa: TStringField;
    tb_pessoasrg_pessoa: TStringField;
    tb_pessoastelefone1_pessoa: TStringField;
    tb_pessoastelefone2_pessoa: TStringField;
    queryCADASTROPESSOAScidades: TZReadOnlyQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DM1: TDM1;

implementation

{$R *.lfm}

{ TDM1 }

procedure TDM1.DataModuleCreate(Sender: TObject);
var
  SLcfg : TStringList;
begin
  try
    // Carrega arquivo cfg
    SLcfg := TStringList.Create;
    SLcfg.LoadFromFile('conf/db.cfg');
    // Le informações
    SEMEDconnection.Database := SLcfg[0];
    SEMEDconnection.HostName := SLcfg[1];
    SEMEDconnection.User := SLcfg[2];
    SEMEDconnection.Password := SLcfg[3];
    // Conecta ao banco
    SEMEDconnection.Connected := true;
  finally
    SLcfg.Free;
  end;
end;

end.

