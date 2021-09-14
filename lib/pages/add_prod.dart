import 'dart:typed_data';
import 'package:app_vendedor/models/prod_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../controllers/user_controller.dart';
import 'package:select_form_field/select_form_field.dart';



class AddProduto extends StatefulWidget {
  @override
  _AddProdutoState createState() => _AddProdutoState();
}

class _AddProdutoState extends State<AddProduto> {
  String nome ="", marca = "", cor = "", categoria = "", descricao = "", precoDesconto = "", promocao = "";
  int quantidade = 0;
  double preco = 0.0;
  Uint8List? file;

  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  final List<Map<String, dynamic>> _items = [
  
  {
    'value': 'Sim',
    'label': 'Sim',
    'icon': Icon(Icons.check),
  },
  {
    'value': 'Não',
    'label': 'Não',
    'icon': Icon(Icons.error),
    'textStyle': TextStyle(color: Colors.red),
  },
 
];

final List<Map<String, dynamic>> _categoria = [
  {
    'value': 'Celulares',
    'label': 'Celulares',
    'icon': Icon(Icons.check),
  },
  {
    'value': 'Notebooks',
    'label': 'Notebooks',
    'icon': Icon(Icons.check),
  },
  {
    'value': 'Televisões',
    'label': 'Televisões',
    'icon': Icon(Icons.check),
  },
  {
    'value': 'Video Games',
    'label': 'Video Games',
    'icon': Icon(Icons.check),
  },
];

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("     Adicionar produto", style: GoogleFonts.roboto(
                            textStyle:
                                TextStyle(fontSize: 22, color: Colors.white,),
                          ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Nome do Produto",
                ),
                onChanged: (texto) => nome = texto,
              ),
              TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_balance),
                  labelText: "Marca",
                ),
                onChanged: (texto) => marca = texto,
              ),
              TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.attach_money_sharp),
                  labelText: "Preço",
                ),
                onChanged: (texto) => preco = double.parse(texto),
              ),
              TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.compare_arrows_sharp),
                  labelText: "Desconto",
                ),
                onChanged: (texto) => precoDesconto = (texto),
              ),

              SelectFormField(
              type: SelectFormFieldType.dropdown, // or can be dialog
              // initialValue: 'Não',
              labelText: 'Promoção',
              items: _items,
              onChanged: (value) => promocao = value,
              ),

              TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.add_a_photo_rounded),
                  labelText: "Cor",
                ),
                onChanged: (texto) => cor = texto,
              ),
              TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.add_box_rounded),
                  labelText: "Quantidade",
                ),
                onChanged: (texto) => quantidade = int.parse(texto),
              ),
               
              SelectFormField(
                type: SelectFormFieldType.dropdown, // or can be dialog
                initialValue: 'Não',
                labelText: 'Categoria',
                items: _categoria,
                onChanged: (value) => categoria = value,
              ),

              TextField(
                decoration: InputDecoration(
                  labelText: "Descrição",labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                maxLines: 10,
                onChanged: (texto) => descricao = texto,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  final result =
                      await FilePicker.platform.pickFiles(type: FileType.image);

                  if (result != null) {
                    setState(() {
                      final bytes = result.files.first.bytes;
                      file = bytes;
                    });
                  }
                },
                 style: ElevatedButton.styleFrom(
                          primary: Color(0XFF9d4edd),
                        ),
                child: Row(
                  children: [
                    Icon(file != null ? Icons.check : Icons.upload),
                     Text("Adicionar imagem", style: GoogleFonts.roboto(
                        textStyle: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
             MaterialButton(
                    color: Color(0XFF9d4edd),
                onPressed: () async {

                  final novoProduto = ProdutoModel(
                    keyVendedor: userController.user!.uid,
                    nome: nome,
                    marca: marca,
                    preco: preco,
                    cor: cor,
                    categoria: categoria,
                    descricao: descricao,
                    quantidade: quantidade,
                    imagem: file, 
                    nomeVendedor: userController.model.nome, 
                    precoDesconto: precoDesconto , 
                    promocao: promocao ,
                  ).toMap();

                  await FirebaseFirestore.instance
                      .collection('produtos')
                      .add(novoProduto);
                  
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("    Adicionar produto", style: GoogleFonts.roboto(
                              textStyle:
                                  TextStyle(fontSize: 20, color: Colors.white,),
                            ),
                            ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
