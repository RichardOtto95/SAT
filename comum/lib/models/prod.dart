import 'package:json_annotation/json_annotation.dart';

import '../reflector.dart';

part 'prod.g.dart';

class ProdWrapper {
  Prod? prod;
}

@reflector
@JsonSerializable()
class Prod {
  Prod(this.cod);

  @JsonKey(required: true)
  int cod;

  @JsonKey(defaultValue: 0)
  double? pvend;

  @JsonKey(defaultValue: 0)
  double? m3;

  @JsonKey(defaultValue: "")
  String? obs;
  @JsonKey(defaultValue: "")
  String? urlimagem;

  @JsonKey(defaultValue: 0)
  double? pcif;

  @JsonKey(defaultValue: "")
  String? usuarioalteracaopvend;

  @JsonKey(defaultValue: "")
  String? produto;

  @JsonKey(defaultValue: "")
  String? codestruturamercadologica;

  @JsonKey(defaultValue: "F")
  String? permitirquantidadefracionada;

  @JsonKey(defaultValue: "F")
  String? capturarpesonocaixa;

  @JsonKey(defaultValue: "F")
  String? geradoporbalanca;

  @JsonKey(defaultValue: "F")
  String? permitirmaisqueduascasas;

  @JsonKey(defaultValue: "F")
  String? naoenviarparafranquia;

  @JsonKey(defaultValue: "F")
  String? neg;

  @JsonKey(defaultValue: "F")
  String? permitirmultiplicacaonopdv;

  @JsonKey(defaultValue: "F")
  String? checkinserircodigodebarrasnoxml;

  @JsonKey(defaultValue: "F")
  String? selecionadoparadevolucao;

  @JsonKey(defaultValue: "F")
  String? tempre;

  @JsonKey(defaultValue: "F")
  String? medicamentospreencherlotenanfe;

  @JsonKey(defaultValue: "F")
  String? dispnoecommerce;

  @JsonKey(defaultValue: "F")
  String? destnoecommerce;

  @JsonKey(defaultValue: "F")
  String? alterarnoecommerce;

  @JsonKey(defaultValue: "F")
  String? sel;

  @JsonKey(defaultValue: "F")
  String? exibirgrade;

  @JsonKey(disallowNullValue: true)
  DateTime? dtalteracaopvend;

  @JsonKey(disallowNullValue: true)
  DateTime? datadainclusaodoproduto;

  @JsonKey(disallowNullValue: true)
  DateTime? datadoultimopedido;

  @JsonKey(disallowNullValue: true)
  DateTime? dataultimaalteracao;

  @JsonKey(defaultValue: "")
  String? endereco;

  @JsonKey(defaultValue: "")
  String? unid;

  @JsonKey(defaultValue: "")
  String? prodresumido;

  @JsonKey(defaultValue: "")
  String? tamanho;

  @JsonKey(defaultValue: "")
  String? descricao;

  @JsonKey(defaultValue: "")
  String? descricaoncm;

  @JsonKey(defaultValue: "")
  String? cor;

  @JsonKey(defaultValue: "")
  String? cest;

  @JsonKey(defaultValue: "")
  String? ncm;

  @JsonKey(defaultValue: 0)
  double? precominimo;

  @JsonKey(defaultValue: 0)
  double? pmont;

  @JsonKey(defaultValue: 0)
  double? qtdedacaixa;

  @JsonKey(defaultValue: 0)
  double? descontomaximo;

  @JsonKey(defaultValue: 0)
  double? guelta;

  // ignore: non_constant_identifier_names
  @JsonKey(defaultValue: 0)
  int? est_min;

  @JsonKey(defaultValue: 0)
  int? marca;

  @JsonKey(defaultValue: 0)
  int? clas;

  @JsonKey(defaultValue: 0)
  int? subclas;

  @JsonKey(defaultValue: 0)
  int? localdeimpressao;

  @JsonKey(defaultValue: 0)
  int? codfigurafiscal;

  @JsonKey(defaultValue: 0)
  int? csosn;

  @JsonKey(defaultValue: 0)
  int? codigoanp;

  @JsonKey(defaultValue: 0)
  int? cod_produto_ecommerce;

  @JsonKey(defaultValue: 0)
  int? forn;

  @JsonKey(defaultValue: 0)
  double? pvendanterior;

  @JsonKey(defaultValue: 0)
  double? quant;

  @JsonKey(defaultValue: 0)
  double? pind;

  @JsonKey(defaultValue: 0)
  double? dind;

  @JsonKey(defaultValue: 0)
  double? descontoindustria2;

  @JsonKey(defaultValue: 0)
  double? descontoindustria3;

  @JsonKey(defaultValue: 0)
  double? descontoindustria4;

  @JsonKey(defaultValue: 0)
  double? descontoindustria5;

  @JsonKey(defaultValue: 0)
  double? pfob;

  @JsonKey(defaultValue: 0)
  double? cicm;

  @JsonKey(defaultValue: 0)
  double? ipi;

  @JsonKey(defaultValue: 0)
  double? frete;

  @JsonKey(defaultValue: 0)
  double? dicm;

  @JsonKey(defaultValue: 0)
  double? icmsfrete;

  @JsonKey(defaultValue: 0)
  double? qtde_embalagem;

  @JsonKey(defaultValue: 0)
  double? pped;

  @JsonKey(defaultValue: 0)
  double? precocustoultimopedido;

  @JsonKey(defaultValue: 0)
  double? precocustomedio;

  @JsonKey(defaultValue: 0)
  double? qtdeultimopedido;

  @JsonKey(defaultValue: 0)
  double? creditodepis;

  @JsonKey(defaultValue: 0)
  double? creditodecofins;

  @JsonKey(defaultValue: 0)
  double? icms;

  @JsonKey(defaultValue: 0)
  double? simples;

  @JsonKey(defaultValue: 0)
  double? pis;

  @JsonKey(defaultValue: 0)
  double? cofins;

  @JsonKey(defaultValue: 0)
  double? irpj;

  @JsonKey(defaultValue: 0)
  double? contribuicaosocial;

  @JsonKey(defaultValue: 0)
  double? custooperacional;

  @JsonKey(defaultValue: 0)
  double? comissoes;

  @JsonKey(defaultValue: 0)
  double? lucrodesejado;

  @JsonKey(defaultValue: 0)
  double? peso;

  @JsonKey(defaultValue: 0)
  double? pesoliquido;

  @JsonKey(defaultValue: "")
  String? codind;
  String? saiu;

  @JsonKey(defaultValue: "")
  String? codigodeprodutodaanvisa;

  double get resultadomarkup =>
      (pvend! - pcif!) * 100 / (pcif == 0 ? 1 : pcif!);

  double get resultadomargem => 100 - (pcif! * 100 / (pvend == 0 ? 1 : pvend!));

  double get teste => (precominimo! - pcif!) * 100 / (pcif == 0 ? 1 : pcif!);

  factory Prod.fromJson(Map<String, dynamic> json) => _$ProdFromJson(json);

  Map<String, dynamic> toJson() => _$ProdToJson(this);

  Map<String, String> fieldMap() => _$ProdFieldMap;
}

enum ProductsStatus {
  loading,
  empty,
  loaded,
}
