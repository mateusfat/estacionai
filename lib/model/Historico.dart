import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Historico{
  String? id;
  int? vaga;
  String? veiculo;
  Timestamp? dtentrada;
  Timestamp? dtsaida;
  String? nome;
  String? telefone;

  Historico({
    this.id,
    this.vaga,
    this.veiculo,
    this.dtentrada,
    this.dtsaida,
    this.nome,
    this.telefone
  });

  Historico.fromJson(Map<String, dynamic> json)
      : this(
    id: json['id'],
    vaga: json['vaga'],
    veiculo: json['veiculo'],
    dtentrada: json['dtentrada'],
    dtsaida: json['dtsaida'],
    nome: json['nome'],
    telefone: json['telefone'],
  );

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'vaga': vaga,
      'veiculo': veiculo,
      'dtentrada': dtentrada,
      'dtsaida': dtsaida,
      'nome':nome,
      'telefone':telefone,
    };
  }
}