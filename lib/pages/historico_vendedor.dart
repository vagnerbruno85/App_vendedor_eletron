import 'package:app_vendedor/controllers/user_controller.dart';
import 'package:app_vendedor/models/prod_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoricoVendedor extends StatefulWidget {
  const HistoricoVendedor({ Key? key }) : super(key: key);

  @override
  _HistoricoVendedorState createState() => _HistoricoVendedorState();
}

class _HistoricoVendedorState extends State<HistoricoVendedor> {
late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Produtos '),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('produtos')
            .where("keyVendedor", isEqualTo: userController.user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final produtos = snapshot.data!.docs.map((map) {
            final data = map.data();
            return ProdutoModel.fromMap(data, map.id);
          }).toList();

          return ListView.builder(
            itemCount: produtos.length,
            itemBuilder: (context, index) {
              final produto = produtos[index];
              return ListTile(
                title: Text(produto.nome),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on),
                    Text(produto.descricao),
                    Text(produto.categoria),
                    Text(produto.cor),
                    Text(produto.marca),
                    Text("${produto.preco}"),
                    // Text(produto.quantidade),
                    Text(produto.keyVendedor),
                  ],
                ),
                leading: produto.imagem != null
                    ? Image.memory(
                        produto.imagem!,
                        fit: BoxFit.cover,
                        width: 72,
                      )
                    : Container(
                        child: Icon(Icons.location_on),
                        width: 72,
                        height: double.maxFinite,
                        color: Colors.blue,
                      ),
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => EditProdutoPage(
                //         produto: produto,
                //       ),
                //     ),
                //   );
                // },
              );
            },
          );
        },
      ),
    );
  }
}