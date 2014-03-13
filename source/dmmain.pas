unit dmMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, ZConnection, ZDataset,
  Forms, Controls, Graphics, Dialogs;

type

  { TDM1 }

  TDM1 = class(TDataModule)
    queryCADASTROPESSOAScidadescodigo_cidade: TLongintField;
    queryCADASTROPESSOAScidadesnome_cidade: TStringField;
    queryCADASTROPESSOAScidadesuf_cidade: TStringField;
    querycontratosano_seletivo_contrato: TLongintField;
    querycontratoscodigo_cargo: TLongintField;
    querycontratoscodigo_contrato: TLongintField;
    querycontratoscodigo_pessoa: TLongintField;
    querycontratoscpf_teste_1_contrato: TStringField;
    querycontratoscpf_teste_2_contrato: TStringField;
    querycontratosdata_contrato: TStringField;
    querycontratosjornada_trabalho_contrato: TLongintField;
    querycontratosjustificativa_contrato: TStringField;
    querycontratosobs_contrato: TStringField;
    querycontratosperiodo_final_contrato: TStringField;
    querycontratosperiodo_inicial_contrato: TStringField;
    querycontratossalario_contrato: TFloatField;
    querycontratostestemunha_1_contrato: TStringField;
    querycontratostestemunha_2_contrato: TStringField;
    querycontratostipo_contratacao_contrato: TStringField;
    SEMEDconnection: TZConnection;
    StringField1: TStringField;
    tb_cargosclausula_primeira_cargo: TStringField;
    tb_cargoscodigo_cargo: TLongintField;
    tb_cargosgrupo_ocupacional_cargo: TStringField;
    tb_cargosnome_cargo: TStringField;
    tb_cargossalario_hora_cargo: TFloatField;
    tb_cidadescodigo_cidade: TLongintField;
    tb_cidadesnome_cidade: TStringField;
    tb_horarioscodigo_horario: TLongintField;
    tb_horariosdescricao_periodo_horario: TStringField;
    tb_horarioshorario_periodo_horario: TStringField;
    tb_horarios_local_trabalhocodigo_horario: TLongintField;
    tb_horarios_local_trabalhocodigo_local_trabalho: TLongintField;
    tb_local_trabalhocodigo_local_trabalho: TLongintField;
    tb_local_trabalhohorario_matutino_trabalho: TStringField;
    tb_local_trabalhohorario_noturno_trabalho: TStringField;
    tb_local_trabalhohorario_vespertino_trabalho: TStringField;
    tb_local_trabalhonome_local_trabalho: TStringField;
    tb_local_trabalhoresponsavel_local_trabalho: TStringField;
    tb_local_trabalhotelefone_local_trabalho: TStringField;
    tb_muralcodigo_mural: TLongintField;
    tb_muralconteudo_mural: TStringField;
    tb_muraldata_mural: TStringField;
    tb_muralusuario_mural: TStringField;
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
    tb_local_trabalho: TZQuery;
    tb_usuarioscodigo_usuario: TLongintField;
    tb_usuarioslogin_usuario: TStringField;
    tb_usuariosnome_usuario: TStringField;
    tb_usuariossenha_usuario: TStringField;
    ZReadOnlyQuery1codigo_cidade: TLongintField;
    ZReadOnlyQuery1nome_cidade: TStringField;
    ZReadOnlyQuery1uf_cidade: TStringField;
    tb_cargos: TZTable;
    tb_mural: TZTable;
    tb_usuarios: TZTable;
    tb_cidades: TZTable;
    ZTable1codigo_cidade: TLongintField;
    ZTable1nome_cidade: TStringField;
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

end.

