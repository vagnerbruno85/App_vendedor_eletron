class PedidoModel {
  final String? keyPedido;
  final String keyVendedor;
  final String categoria;
  final int quantidade;
 
  PedidoModel({
    this.keyPedido,
    required this.keyVendedor,
    required this.categoria,
    required this.quantidade,
  });
 
  static PedidoModel fromMap(Map<String, dynamic> map, [String? keyPedido]) =>
      PedidoModel(
        keyPedido: keyPedido,
        keyVendedor: map['keyVendedor'],
        categoria: map['categoria'],
        quantidade: map['quantidade']
      );
      Map<String, dynamic> toMap() => {
        'keyVendedor': keyVendedor,
        'categoria': categoria,
        'quantidade': quantidade,
      };
}