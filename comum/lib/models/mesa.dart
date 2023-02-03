// ignore_for_file: non_constant_identifier_names

import 'cli.dart';
import 'package:json_annotation/json_annotation.dart';
import '../reflector.dart';

part 'mesa.g.dart';

@JsonSerializable()
@reflector
class Mesa {
  Mesa(this.pedido,
      {this.data,
      this.codcli,
      this.matr,
      this.total,
      this.reservado,
      this.cli,
      this.loja});

  int pedido;
  DateTime? data;
  int? id_oe;
  int? codcli;
  int? matr;
  int? loja;
  double? total;
  double? acrescimo;
  Cli? cli;
  double? troco;
  String? cpf;
  String? garcom;
  String? reservado;
  String? obs;

  factory Mesa.fromJson(Map<String, dynamic> json) => _$MesaFromJson(json);
  Map<String, dynamic> toJson() => _$MesaToJson(this);
}
