// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forn.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Forn _$FornFromJson(Map<String, dynamic> json) => Forn(
      json['forn'] as int?,
      nome: json['nome'] as String? ?? '',
      razao: json['razao'] as String? ?? '',
      email: json['email'] as String? ?? '',
      cgc: json['cgc'] as String? ?? '',
      ins: json['ins'] as String? ?? '',
      cont: json['cont'] as String? ?? '',
      repr: json['repr'] as String? ?? '',
      nire: json['nire'] as String? ?? '',
      inscricaomunicipal: json['inscricaomunicipal'] as String? ?? '',
      tel: json['tel'] as String?,
      foner: json['foner'] as String? ?? '',
      fax: json['fax'] as String? ?? '',
      faxr: json['faxr'] as String? ?? '',
      ende: json['ende'] as String? ?? '',
      complemento: json['complemento'] as String? ?? '',
      pais: json['pais'] as String? ?? '',
      cep: json['cep'] as String? ?? '',
      estado: json['estado'] as String? ?? '',
      bairro: json['bairro'] as String? ?? '',
      cidade: json['cidade'] as String? ?? '',
      site: json['site'] as String? ?? '',
      trans: json['trans'] as String? ?? '',
      ibgecodigodomunicipio: json['ibgecodigodomunicipio'] as int? ?? 0,
      codigodopais: json['codigodopais'] as int? ?? 0,
    );

const _$FornFieldMap = <String, String>{
  'forn': 'forn',
  'nome': 'nome',
  'razao': 'razao',
  'email': 'email',
  'cgc': 'cgc',
  'ins': 'ins',
  'cont': 'cont',
  'repr': 'repr',
  'nire': 'nire',
  'inscricaomunicipal': 'inscricaomunicipal',
  'tel': 'tel',
  'foner': 'foner',
  'fax': 'fax',
  'faxr': 'faxr',
  'ende': 'ende',
  'complemento': 'complemento',
  'cep': 'cep',
  'pais': 'pais',
  'estado': 'estado',
  'bairro': 'bairro',
  'cidade': 'cidade',
  'site': 'site',
  'trans': 'trans',
  'ibgecodigodomunicipio': 'ibgecodigodomunicipio',
  'codigodopais': 'codigodopais',
};

Map<String, dynamic> _$FornToJson(Forn instance) => <String, dynamic>{
      'forn': instance.forn,
      'nome': instance.nome,
      'razao': instance.razao,
      'email': instance.email,
      'cgc': instance.cgc,
      'ins': instance.ins,
      'cont': instance.cont,
      'repr': instance.repr,
      'nire': instance.nire,
      'inscricaomunicipal': instance.inscricaomunicipal,
      'tel': instance.tel,
      'foner': instance.foner,
      'fax': instance.fax,
      'faxr': instance.faxr,
      'ende': instance.ende,
      'complemento': instance.complemento,
      'cep': instance.cep,
      'pais': instance.pais,
      'estado': instance.estado,
      'bairro': instance.bairro,
      'cidade': instance.cidade,
      'site': instance.site,
      'trans': instance.trans,
      'ibgecodigodomunicipio': instance.ibgecodigodomunicipio,
      'codigodopais': instance.codigodopais,
    };