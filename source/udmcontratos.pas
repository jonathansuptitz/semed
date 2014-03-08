unit udmcontratos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, ZDataset, ZConnection, ZConnectionGroup,
  ZGroupedConnection, ZSequence, ZSqlProcessor;

type

  { TDMcontratos }

  TDMcontratos = class(TDataModule)
    dscontratoslocais: TDatasource;
    dscargos: TDatasource;
    dscontratocargos: TDatasource;
    dscidades: TDatasource;
    dsContratos: TDatasource;
    dslocaltrabalho: TDatasource;
    dspessoa: TDatasource;
    contratoconection: TZConnection;
    zt_contatros_locais: TZTable;
    zt_cargosclausula_primeira_cargo: TStringField;
    zt_cargoscodigo_cargo: TLongintField;
    zt_cargosgrupo_ocupacional_cargo: TStringField;
    zt_cargosnome_cargo: TStringField;
    zt_cargossalario_hora_cargo: TFloatField;
    zt_cidadescodigo_cidade: TLongintField;
    zt_cidadesnome_cidade: TStringField;
    zt_contratosano_seletivo_contrato: TLongintField;
    zt_contratoscodigo_cargo: TLongintField;
    zt_contratoscodigo_contrato: TLongintField;
    zt_contratoscodigo_pessoa: TLongintField;
    zt_contratoscpf_teste_1_contrato: TStringField;
    zt_contratoscpf_teste_2_contrato: TStringField;
    zt_contratosdata_contrato: TStringField;
    zt_contratosjornada_trabalho_contrato: TLongintField;
    zt_contratosjustificativa_contrato: TStringField;
    zt_contratosobs_contrato: TStringField;
    zt_contratosperiodo_final_contrato: TStringField;
    zt_contratosperiodo_inicial_contrato: TStringField;
    zt_contratossalario_contrato: TFloatField;
    zt_contratostestemunha_1_contrato: TStringField;
    zt_contratostestemunha_2_contrato: TStringField;
    zt_contratostipo_contratacao_contrato: TStringField;
    zt_contratos_cargoscodigo_contrato: TLongintField;
    zt_contratos_cargoscodigo_local_trabalho: TLongintField;
    zt_local_trabalho: TZTable;
    zt_local_trabalhocodigo_local_trabalho: TLongintField;
    zt_local_trabalhohorario_matutino_trabalho: TStringField;
    zt_local_trabalhohorario_noturno_trabalho: TStringField;
    zt_local_trabalhohorario_vespertino_trabalho: TStringField;
    zt_local_trabalhonome_local_trabalho: TStringField;
    zt_local_trabalhoresponsavel_local_trabalho: TStringField;
    zt_local_trabalhotelefone_local_trabalho: TStringField;
    zt_pessoas: TZTable;
    zt_cargos: TZTable;
    zt_cidades: TZTable;
    zt_contratos: TZTable;
    zt_contratos_cargos: TZTable;
    zt_pessoasano_doutorado_pessoa: TLongintField;
    zt_pessoasano_graduacao1_pessoa: TLongintField;
    zt_pessoasano_graduacao2_pessoa: TLongintField;
    zt_pessoasano_medio_pessoa: TLongintField;
    zt_pessoasano_mestrado_pessoa: TLongintField;
    zt_pessoasano_pos1_pessoa: TLongintField;
    zt_pessoasano_pos2_pessoa: TLongintField;
    zt_pessoasbairro_pessoa: TStringField;
    zt_pessoascep_pessoa: TStringField;
    zt_pessoascodigo_cidade: TLongintField;
    zt_pessoascodigo_pessoa: TLongintField;
    zt_pessoascpf_pessoa: TStringField;
    zt_pessoasdesc_doutorado_pessoa: TStringField;
    zt_pessoasdesc_graduacao1_pessoa: TStringField;
    zt_pessoasdesc_graduacao2_pessoa: TStringField;
    zt_pessoasdesc_mestrado_pessoa: TStringField;
    zt_pessoasdesc_pos1_pessoa: TStringField;
    zt_pessoasdesc_pos2_pessoa: TStringField;
    zt_pessoasemail_pessoa: TStringField;
    zt_pessoasendereco_pessoa: TStringField;
    zt_pessoasestado_civil_pessoa: TStringField;
    zt_pessoasinst_doutorado_pessoa: TStringField;
    zt_pessoasinst_graduacao1_pessoa: TStringField;
    zt_pessoasinst_graduacao2_pessoa: TStringField;
    zt_pessoasinst_medio_pessoa: TStringField;
    zt_pessoasinst_mestrado_pessoa: TStringField;
    zt_pessoasinst_pos1_pessoa: TStringField;
    zt_pessoasinst_pos2_pessoa: TStringField;
    zt_pessoasnacionalidade_pessoa: TStringField;
    zt_pessoasnascimento_pessoa: TStringField;
    zt_pessoasnome_pessoa: TStringField;
    zt_pessoasrg_pessoa: TStringField;
    zt_pessoastelefone1_pessoa: TStringField;
    zt_pessoastelefone2_pessoa: TStringField;
    procedure dscontratocargosDataChange(Sender: TObject; Field: TField);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DMcontratos: TDMcontratos;

implementation

uses dmMain;

{ TDMcontratos }

procedure TDMcontratos.dscontratocargosDataChange(Sender: TObject; Field: TField
  );
begin

end;

{$R *.lfm}

end.

