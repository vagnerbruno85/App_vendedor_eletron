import 'package:app_vendedor/controllers/user_controller.dart';
import 'package:app_vendedor/models/prod_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DadosCelulares extends StatefulWidget {
  const DadosCelulares({ Key? key }) : super(key: key);

  @override
  _DadosCelularesState createState() => _DadosCelularesState();
}

class _DadosCelularesState extends State<DadosCelulares> {
late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );


  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('produtos')
            .where("keyVendedor", isEqualTo: userController.user!.uid)
            .where("categoria", isEqualTo: "Celulares")
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
              int qntdCelular = 0;
              produtos.forEach((element) {
                qntdCelular = qntdCelular + produto.quantidade;
              });
              return Text(qntdCelular.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.purple));
            },
          );
        },
      ),
    );
  }
}

class DadosNotebooks extends StatefulWidget {
  const DadosNotebooks({ Key? key }) : super(key: key);

  @override
  _DadosNotebooksState createState() => _DadosNotebooksState();
}

class _DadosNotebooksState extends State<DadosNotebooks> {
late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );


  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('produtos')
            .where("keyVendedor", isEqualTo: userController.user!.uid)
            .where("categoria", isEqualTo: "Notebooks")
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
              int qntdNotebooks = 0;
              produtos.forEach((element) {
                qntdNotebooks = qntdNotebooks + produto.quantidade;
              });
              return Text(qntdNotebooks.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.purple));
            },
          );
        },
      ),
    );
  }
}

class DadosTelevisoes extends StatefulWidget {
  const DadosTelevisoes({ Key? key }) : super(key: key);

  @override
  _DadosTelevisoesState createState() => _DadosTelevisoesState();
}

class _DadosTelevisoesState extends State<DadosTelevisoes> {
late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );


  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('produtos')
            .where("keyVendedor", isEqualTo: userController.user!.uid)
            .where("categoria", isEqualTo: "Televisões")
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
              int qntdTelevisoes = 0;
              produtos.forEach((element) {
                qntdTelevisoes = qntdTelevisoes + produto.quantidade;
              });
              return Text(qntdTelevisoes.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.purple));
            },
          );
        },
      ),
    );
  }
}

class DadosVideoGames extends StatefulWidget {
  const DadosVideoGames({ Key? key }) : super(key: key);

  @override
  _DadosVideoGamesState createState() => _DadosVideoGamesState();
}

class _DadosVideoGamesState extends State<DadosVideoGames> {
late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
              int qntdVideoGamess = 0;
              produtos.forEach((element) {
                qntdVideoGamess = qntdVideoGamess + produto.quantidade;
              });
              return ListTile(
                title: Column(
                  children: [Text(qntdVideoGamess.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.purple))],
                ),
              );
            },
          );
        },
      ),
    );
  }
}