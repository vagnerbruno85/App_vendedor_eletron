import 'package:app_vendedor/controllers/user_controller.dart';
import 'package:app_vendedor/models/prod_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edit_prod.dart';


class HistoricoVideogame extends StatefulWidget {
  const HistoricoVideogame({ Key? key }) : super(key: key);

  @override
  _HistoricoVideogameState createState() => _HistoricoVideogameState();
}

class _HistoricoVideogameState extends State<HistoricoVideogame> {
late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico Video Games '),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('produtos')
            .where("keyVendedor", isEqualTo: userController.user!.uid)
            .where("categoria", isEqualTo: "Video Games")
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

              return 
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                width: 300,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProdutoPage(
                          produto: produto,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children:[ 
                       produto.imagem != null
                          ? Image.memory(
                              produto.imagem!,
                              fit: BoxFit.contain,
                              height: 140,
                              width: 120,
                            )
                          : Container(
                              child: Icon(Icons.list),
                              width: 120,
                              height: double.maxFinite,
                              color: Colors.blue,
                            ),

                      Text(produto.nome , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),                  
                      Text(produto.descricao),
                      Text(produto.categoria),
                      Text(produto.cor),
                      Text(produto.marca),
                      Text("R\$ ${produto.preco}",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.red)),
                    ],
                  ), 
                ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow:[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    spreadRadius: 7,
                    blurRadius: 10,
                    offset: 
                      Offset(0,5),
                  ),
                ],
              ),    
            ); 
            },
          );
        },
      ),
    );
  }
}