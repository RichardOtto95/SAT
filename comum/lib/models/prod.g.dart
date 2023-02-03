// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prod _$ProdFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['cod'],
    disallowNullValues: const [
      'dtalteracaopvend',
      'datadainclusaodoproduto',
      'datadoultimopedido',
      'dataultimaalteracao'
    ],
  );
  return Prod(
    json['cod'] as int,
  )
    ..pvend = (json['pvend'] as num?)?.toDouble() ?? 0
    ..m3 = (json['m3'] as num?)?.toDouble() ?? 0
    ..obs = json['obs'] as String? ?? ''
    ..urlimagem = json['urlimagem'] as String? ?? ''
    ..pcif = (json['pcif'] as num?)?.toDouble() ?? 0
    ..usuarioalteracaopvend = json['usuarioalteracaopvend'] as String? ?? ''
    ..produto = json['produto'] as String? ?? ''
    ..codestruturamercadologica =
        json['codestruturamercadologica'] as String? ?? ''
    ..permitirquantidadefracionada =
        json['permitirquantidadefracionada'] as String? ?? 'F'
    ..capturarpesonocaixa = json['capturarpesonocaixa'] as String? ?? 'F'
    ..geradoporbalanca = json['geradoporbalanca'] as String? ?? 'F'
    ..permitirmaisqueduascasas =
        json['permitirmaisqueduascasas'] as String? ?? 'F'
    ..naoenviarparafranquia = json['naoenviarparafranquia'] as String? ?? 'F'
    ..neg = json['neg'] as String? ?? 'F'
    ..permitirmultiplicacaonopdv =
        json['permitirmultiplicacaonopdv'] as String? ?? 'F'
    ..checkinserircodigodebarrasnoxml =
        json['checkinserircodigodebarrasnoxml'] as String? ?? 'F'
    ..selecionadoparadevolucao =
        json['selecionadoparadevolucao'] as String? ?? 'F'
    ..tempre = json['tempre'] as String? ?? 'F'
    ..medicamentospreencherlotenanfe =
        json['medicamentospreencherlotenanfe'] as String? ?? 'F'
    ..dispnoecommerce = json['dispnoecommerce'] as String? ?? 'F'
    ..destnoecommerce = json['destnoecommerce'] as String? ?? 'F'
    ..alterarnoecommerce = json['alterarnoecommerce'] as String? ?? 'F'
    ..sel = json['sel'] as String? ?? 'F'
    ..exibirgrade = json['exibirgrade'] as String? ?? 'F'
    ..dtalteracaopvend = json['dtalteracaopvend'] == null
        ? null
        : DateTime.parse(json['dtalteracaopvend'] as String)
    ..datadainclusaodoproduto = json['datadainclusaodoproduto'] == null
        ? null
        : DateTime.parse(json['datadainclusaodoproduto'] as String)
    ..datadoultimopedido = json['datadoultimopedido'] == null
        ? null
        : DateTime.parse(json['datadoultimopedido'] as String)
    ..dataultimaalteracao = json['dataultimaalteracao'] == null
        ? null
        : DateTime.parse(json['dataultimaalteracao'] as String)
    ..endereco = json['endereco'] as String? ?? ''
    ..unid = json['unid'] as String? ?? ''
    ..prodresumido = json['prodresumido'] as String? ?? ''
    ..tamanho = json['tamanho'] as String? ?? ''
    ..descricao = json['descricao'] as String? ?? ''
    ..descricaoncm = json['descricaoncm'] as String? ?? ''
    ..cor = json['cor'] as String? ?? ''
    ..cest = json['cest'] as String? ?? ''
    ..ncm = json['ncm'] as String? ?? ''
    ..precominimo = (json['precominimo'] as num?)?.toDouble() ?? 0
    ..pmont = (json['pmont'] as num?)?.toDouble() ?? 0
    ..qtdedacaixa = (json['qtdedacaixa'] as num?)?.toDouble() ?? 0
    ..descontomaximo = (json['descontomaximo'] as num?)?.toDouble() ?? 0
    ..guelta = (json['guelta'] as num?)?.toDouble() ?? 0
    ..est_min = json['est_min'] as int? ?? 0
    ..marca = json['marca'] as int? ?? 0
    ..clas = json['clas'] as int? ?? 0
    ..subclas = json['subclas'] as int? ?? 0
    ..localdeimpressao = json['localdeimpressao'] as int? ?? 0
    ..codfigurafiscal = json['codfigurafiscal'] as int? ?? 0
    ..csosn = json['csosn'] as int? ?? 0
    ..codigoanp = json['codigoanp'] as int? ?? 0
    ..cod_produto_ecommerce = json['cod_produto_ecommerce'] as int? ?? 0
    ..forn = json['forn'] as int? ?? 0
    ..pvendanterior = (json['pvendanterior'] as num?)?.toDouble() ?? 0
    ..quant = (json['quant'] as num?)?.toDouble() ?? 0
    ..pind = (json['pind'] as num?)?.toDouble() ?? 0
    ..dind = (json['dind'] as num?)?.toDouble() ?? 0
    ..descontoindustria2 = (json['descontoindustria2'] as num?)?.toDouble() ?? 0
    ..descontoindustria3 = (json['descontoindustria3'] as num?)?.toDouble() ?? 0
    ..descontoindustria4 = (json['descontoindustria4'] as num?)?.toDouble() ?? 0
    ..descontoindustria5 = (json['descontoindustria5'] as num?)?.toDouble() ?? 0
    ..pfob = (json['pfob'] as num?)?.toDouble() ?? 0
    ..cicm = (json['cicm'] as num?)?.toDouble() ?? 0
    ..ipi = (json['ipi'] as num?)?.toDouble() ?? 0
    ..frete = (json['frete'] as num?)?.toDouble() ?? 0
    ..dicm = (json['dicm'] as num?)?.toDouble() ?? 0
    ..icmsfrete = (json['icmsfrete'] as num?)?.toDouble() ?? 0
    ..qtde_embalagem = (json['qtde_embalagem'] as num?)?.toDouble() ?? 0
    ..pped = (json['pped'] as num?)?.toDouble() ?? 0
    ..precocustoultimopedido =
        (json['precocustoultimopedido'] as num?)?.toDouble() ?? 0
    ..precocustomedio = (json['precocustomedio'] as num?)?.toDouble() ?? 0
    ..qtdeultimopedido = (json['qtdeultimopedido'] as num?)?.toDouble() ?? 0
    ..creditodepis = (json['creditodepis'] as num?)?.toDouble() ?? 0
    ..creditodecofins = (json['creditodecofins'] as num?)?.toDouble() ?? 0
    ..icms = (json['icms'] as num?)?.toDouble() ?? 0
    ..simples = (json['simples'] as num?)?.toDouble() ?? 0
    ..pis = (json['pis'] as num?)?.toDouble() ?? 0
    ..cofins = (json['cofins'] as num?)?.toDouble() ?? 0
    ..irpj = (json['irpj'] as num?)?.toDouble() ?? 0
    ..contribuicaosocial = (json['contribuicaosocial'] as num?)?.toDouble() ?? 0
    ..custooperacional = (json['custooperacional'] as num?)?.toDouble() ?? 0
    ..comissoes = (json['comissoes'] as num?)?.toDouble() ?? 0
    ..lucrodesejado = (json['lucrodesejado'] as num?)?.toDouble() ?? 0
    ..peso = (json['peso'] as num?)?.toDouble() ?? 0
    ..pesoliquido = (json['pesoliquido'] as num?)?.toDouble() ?? 0
    ..codind = json['codind'] as String? ?? ''
    ..saiu = json['saiu'] as String?
    ..codigodeprodutodaanvisa =
        json['codigodeprodutodaanvisa'] as String? ?? '';
}

const _$ProdFieldMap = <String, String>{
  'cod': 'cod',
  'pvend': 'pvend',
  'm3': 'm3',
  'obs': 'obs',
  'urlimagem': 'urlimagem',
  'pcif': 'pcif',
  'usuarioalteracaopvend': 'usuarioalteracaopvend',
  'produto': 'produto',
  'codestruturamercadologica': 'codestruturamercadologica',
  'permitirquantidadefracionada': 'permitirquantidadefracionada',
  'capturarpesonocaixa': 'capturarpesonocaixa',
  'geradoporbalanca': 'geradoporbalanca',
  'permitirmaisqueduascasas': 'permitirmaisqueduascasas',
  'naoenviarparafranquia': 'naoenviarparafranquia',
  'neg': 'neg',
  'permitirmultiplicacaonopdv': 'permitirmultiplicacaonopdv',
  'checkinserircodigodebarrasnoxml': 'checkinserircodigodebarrasnoxml',
  'selecionadoparadevolucao': 'selecionadoparadevolucao',
  'tempre': 'tempre',
  'medicamentospreencherlotenanfe': 'medicamentospreencherlotenanfe',
  'dispnoecommerce': 'dispnoecommerce',
  'destnoecommerce': 'destnoecommerce',
  'alterarnoecommerce': 'alterarnoecommerce',
  'sel': 'sel',
  'exibirgrade': 'exibirgrade',
  'dtalteracaopvend': 'dtalteracaopvend',
  'datadainclusaodoproduto': 'datadainclusaodoproduto',
  'datadoultimopedido': 'datadoultimopedido',
  'dataultimaalteracao': 'dataultimaalteracao',
  'endereco': 'endereco',
  'unid': 'unid',
  'prodresumido': 'prodresumido',
  'tamanho': 'tamanho',
  'descricao': 'descricao',
  'descricaoncm': 'descricaoncm',
  'cor': 'cor',
  'cest': 'cest',
  'ncm': 'ncm',
  'precominimo': 'precominimo',
  'pmont': 'pmont',
  'qtdedacaixa': 'qtdedacaixa',
  'descontomaximo': 'descontomaximo',
  'guelta': 'guelta',
  'est_min': 'est_min',
  'marca': 'marca',
  'clas': 'clas',
  'subclas': 'subclas',
  'localdeimpressao': 'localdeimpressao',
  'codfigurafiscal': 'codfigurafiscal',
  'csosn': 'csosn',
  'codigoanp': 'codigoanp',
  'cod_produto_ecommerce': 'cod_produto_ecommerce',
  'forn': 'forn',
  'pvendanterior': 'pvendanterior',
  'quant': 'quant',
  'pind': 'pind',
  'dind': 'dind',
  'descontoindustria2': 'descontoindustria2',
  'descontoindustria3': 'descontoindustria3',
  'descontoindustria4': 'descontoindustria4',
  'descontoindustria5': 'descontoindustria5',
  'pfob': 'pfob',
  'cicm': 'cicm',
  'ipi': 'ipi',
  'frete': 'frete',
  'dicm': 'dicm',
  'icmsfrete': 'icmsfrete',
  'qtde_embalagem': 'qtde_embalagem',
  'pped': 'pped',
  'precocustoultimopedido': 'precocustoultimopedido',
  'precocustomedio': 'precocustomedio',
  'qtdeultimopedido': 'qtdeultimopedido',
  'creditodepis': 'creditodepis',
  'creditodecofins': 'creditodecofins',
  'icms': 'icms',
  'simples': 'simples',
  'pis': 'pis',
  'cofins': 'cofins',
  'irpj': 'irpj',
  'contribuicaosocial': 'contribuicaosocial',
  'custooperacional': 'custooperacional',
  'comissoes': 'comissoes',
  'lucrodesejado': 'lucrodesejado',
  'peso': 'peso',
  'pesoliquido': 'pesoliquido',
  'codind': 'codind',
  'saiu': 'saiu',
  'codigodeprodutodaanvisa': 'codigodeprodutodaanvisa',
};

Map<String, dynamic> _$ProdToJson(Prod instance) {
  final val = <String, dynamic>{
    'cod': instance.cod,
    'pvend': instance.pvend,
    'm3': instance.m3,
    'obs': instance.obs,
    'urlimagem': instance.urlimagem,
    'pcif': instance.pcif,
    'usuarioalteracaopvend': instance.usuarioalteracaopvend,
    'produto': instance.produto,
    'codestruturamercadologica': instance.codestruturamercadologica,
    'permitirquantidadefracionada': instance.permitirquantidadefracionada,
    'capturarpesonocaixa': instance.capturarpesonocaixa,
    'geradoporbalanca': instance.geradoporbalanca,
    'permitirmaisqueduascasas': instance.permitirmaisqueduascasas,
    'naoenviarparafranquia': instance.naoenviarparafranquia,
    'neg': instance.neg,
    'permitirmultiplicacaonopdv': instance.permitirmultiplicacaonopdv,
    'checkinserircodigodebarrasnoxml': instance.checkinserircodigodebarrasnoxml,
    'selecionadoparadevolucao': instance.selecionadoparadevolucao,
    'tempre': instance.tempre,
    'medicamentospreencherlotenanfe': instance.medicamentospreencherlotenanfe,
    'dispnoecommerce': instance.dispnoecommerce,
    'destnoecommerce': instance.destnoecommerce,
    'alterarnoecommerce': instance.alterarnoecommerce,
    'sel': instance.sel,
    'exibirgrade': instance.exibirgrade,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'dtalteracaopvend', instance.dtalteracaopvend?.toIso8601String());
  writeNotNull('datadainclusaodoproduto',
      instance.datadainclusaodoproduto?.toIso8601String());
  writeNotNull(
      'datadoultimopedido', instance.datadoultimopedido?.toIso8601String());
  writeNotNull(
      'dataultimaalteracao', instance.dataultimaalteracao?.toIso8601String());
  val['endereco'] = instance.endereco;
  val['unid'] = instance.unid;
  val['prodresumido'] = instance.prodresumido;
  val['tamanho'] = instance.tamanho;
  val['descricao'] = instance.descricao;
  val['descricaoncm'] = instance.descricaoncm;
  val['cor'] = instance.cor;
  val['cest'] = instance.cest;
  val['ncm'] = instance.ncm;
  val['precominimo'] = instance.precominimo;
  val['pmont'] = instance.pmont;
  val['qtdedacaixa'] = instance.qtdedacaixa;
  val['descontomaximo'] = instance.descontomaximo;
  val['guelta'] = instance.guelta;
  val['est_min'] = instance.est_min;
  val['marca'] = instance.marca;
  val['clas'] = instance.clas;
  val['subclas'] = instance.subclas;
  val['localdeimpressao'] = instance.localdeimpressao;
  val['codfigurafiscal'] = instance.codfigurafiscal;
  val['csosn'] = instance.csosn;
  val['codigoanp'] = instance.codigoanp;
  val['cod_produto_ecommerce'] = instance.cod_produto_ecommerce;
  val['forn'] = instance.forn;
  val['pvendanterior'] = instance.pvendanterior;
  val['quant'] = instance.quant;
  val['pind'] = instance.pind;
  val['dind'] = instance.dind;
  val['descontoindustria2'] = instance.descontoindustria2;
  val['descontoindustria3'] = instance.descontoindustria3;
  val['descontoindustria4'] = instance.descontoindustria4;
  val['descontoindustria5'] = instance.descontoindustria5;
  val['pfob'] = instance.pfob;
  val['cicm'] = instance.cicm;
  val['ipi'] = instance.ipi;
  val['frete'] = instance.frete;
  val['dicm'] = instance.dicm;
  val['icmsfrete'] = instance.icmsfrete;
  val['qtde_embalagem'] = instance.qtde_embalagem;
  val['pped'] = instance.pped;
  val['precocustoultimopedido'] = instance.precocustoultimopedido;
  val['precocustomedio'] = instance.precocustomedio;
  val['qtdeultimopedido'] = instance.qtdeultimopedido;
  val['creditodepis'] = instance.creditodepis;
  val['creditodecofins'] = instance.creditodecofins;
  val['icms'] = instance.icms;
  val['simples'] = instance.simples;
  val['pis'] = instance.pis;
  val['cofins'] = instance.cofins;
  val['irpj'] = instance.irpj;
  val['contribuicaosocial'] = instance.contribuicaosocial;
  val['custooperacional'] = instance.custooperacional;
  val['comissoes'] = instance.comissoes;
  val['lucrodesejado'] = instance.lucrodesejado;
  val['peso'] = instance.peso;
  val['pesoliquido'] = instance.pesoliquido;
  val['codind'] = instance.codind;
  val['saiu'] = instance.saiu;
  val['codigodeprodutodaanvisa'] = instance.codigodeprodutodaanvisa;
  return val;
}
