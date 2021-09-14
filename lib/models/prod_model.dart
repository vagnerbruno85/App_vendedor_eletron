import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
 
class ProdutoModel {
  final int avaliacao;
  final int quantidadeAvaliacoes;
  final String? keyProduto;
  final String keyVendedor;
  final String nome;
  final String nomeVendedor;
  final String marca;
  final double preco;
  final String precoDesconto;
  final String promocao;
  final String cor;
  final String categoria;
  final String descricao;
  final int quantidade;
  final Uint8List? imagem;
 
  ProdutoModel({
    this.avaliacao=0,
    this.quantidadeAvaliacoes=0,
    this.keyProduto,
    required this.keyVendedor,
    required this.nome,
    required this.nomeVendedor,
    required this.marca,
    required this.preco,
    required this.precoDesconto,
    required this.cor,
    required this.promocao,
    required this.categoria,
    required this.descricao,
    required this.quantidade,
    this.imagem,
  });
 
  static ProdutoModel fromMap(Map<String, dynamic> map, [String? keyProduto]) =>
      ProdutoModel(
        avaliacao: map['avaliacao'],
        quantidadeAvaliacoes: map['quantidadeAvaliacoes'],
        keyProduto: keyProduto,
        keyVendedor: map['keyVendedor'],
        nome: map['nome'],
        nomeVendedor: map['nomeVendedor'],
        marca: map['marca'],
        preco: map['preco'],
        cor: map['cor'],
        categoria: map['categoria'],
        descricao: map['descricao'],
        quantidade: map['quantidade'],
        imagem: map['imagem']?.bytes,
        precoDesconto: map['precoDesconto'], 
        promocao: map['promocao'],
      );
 
  Map<String, dynamic> toMap() => {
        'avaliacao': avaliacao,
        'quantidadeAvaliacoes': quantidadeAvaliacoes,
        'keyVendedor': keyVendedor,
        'nome': nome,
        'nomeVendedor': nomeVendedor,
        'marca': marca,
        'preco': preco,
        'precoDesconto': precoDesconto,
        'promocao': promocao,
        'cor': cor,
        'categoria': categoria,
        'descricao': descricao,
        'quantidade': quantidade,
        'imagem': imagem != null ? Blob(imagem!) : null,
      };
}