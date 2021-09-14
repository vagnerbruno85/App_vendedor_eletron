import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String nome;
  final String cpf;
  final String telefone;
  final String? key;
  final Uint8List? image;
  UserModel({
    required this.nome,
    required this.cpf,
    required this.telefone,
    this.key,
    this.image});

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      nome: map['nome'],
      key: map['key'],
      image:map['image']?.bytes,
      cpf: map['cpf'],
      telefone: map['telefone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'cpf': cpf,
      'key': key,
      'telefone': telefone,
      'image': image != null ? Blob(image!) : null,
    };
  }
}