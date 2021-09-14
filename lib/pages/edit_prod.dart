import 'dart:typed_data';
import 'package:app_vendedor/controllers/user_controller.dart';
import 'package:app_vendedor/models/prod_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';


class EditProdutoPage extends StatefulWidget {
  final ProdutoModel produto;

  EditProdutoPage({required this.produto});

  @override
  _EditProdutoPageState createState() => _EditProdutoPageState();
}

class _EditProdutoPageState extends State<EditProdutoPage> {
  late final nomeCont = TextEditingController()..text = widget.produto.nome;
  late final nomeVendedorCont = TextEditingController()..text = widget.produto.nomeVendedor;
  late final marcaCont = TextEditingController()..text = widget.produto.marca;
  late final precoCont = TextEditingController()..text = widget.produto.preco.toString();
  late final precoDescontoCont = TextEditingController()..text = widget.produto.precoDesconto;
  late final promocaoCont = TextEditingController()..text = widget.produto.promocao.toString();
  late final corCont = TextEditingController()..text = widget.produto.cor;
  late final categoriaCont = TextEditingController()..text = widget.produto.categoria;  
  late final descricaoCont = TextEditingController()..text = widget.produto.descricao;
  late final quantidadeCont = TextEditingController()..text = widget.produto.quantidade.toString();
  late Uint8List? file = widget.produto.imagem;


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
    'icon': Icon(Icons.error),
  },
  {
    'value': 'Televisões',
    'label': 'Televisões',
    'icon': Icon(Icons.error),
  },
  {
    'value': 'Video Games',
    'label': 'Video Games',
    'icon': Icon(Icons.error),
  },
 
];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar produto"),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('produtos')
                  .doc(widget.produto.keyProduto)
                  .delete();
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              TextField(
                controller: nomeCont,
                decoration: InputDecoration(
                  labelText: "Nome do Produto",
                ),
              ),
              TextField(
                controller: marcaCont,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.location_on),
                  labelText: "Marca",
                ),
              ),
              TextField(
                controller: precoCont,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.location_on),
                  labelText: "Preco",
                ),
              ),
              TextField(
                controller: precoDescontoCont,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.location_on),
                  labelText: "Desconto",
                ),
              ),
              SelectFormField(
              type: SelectFormFieldType.dropdown, // or can be dialog
              controller: promocaoCont,
              labelText: 'Promoção',
              items: _items,
              ),
              TextField(
                controller: corCont,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.location_on),
                  labelText: "Cor",
                ),
              ),
              TextField(
                controller: quantidadeCont,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.location_on),
                  labelText: "Quantidade",
                ),
              ), 
              SelectFormField(
                type: SelectFormFieldType.dropdown, // or can be dialog
                controller: categoriaCont,
                labelText: 'Categoria',
                items: _categoria,
              ),
              TextField(
                controller: descricaoCont,
                decoration: InputDecoration(
                  labelText: "Descrição",
                ),
                maxLines: 10,
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
                    Text("Adicionar imagem",style: GoogleFonts.roboto(
                              textStyle:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              MaterialButton(
                 color: Color(0XFF9d4edd),
                onPressed: () async {
                  final atualizado = ProdutoModel(   
                    keyVendedor: userController.user!.uid, 
                    nome: nomeCont.text,
                    marca: marcaCont.text, 
                    preco: double.parse(precoCont.text), 
                    cor: corCont.text,
                    categoria: categoriaCont.text,
                    descricao: descricaoCont.text,
                    quantidade: int.parse(quantidadeCont.text),
                    imagem:file,
                    nomeVendedor: userController.model.nome,
                    precoDesconto:precoDescontoCont.text,  
                    promocao: promocaoCont.text, 
                  ).toMap();

                  await FirebaseFirestore.instance
                      .collection('produtos')
                      .doc(widget.produto.keyProduto)
                      .update(atualizado);
                  
                  Navigator.pop(context);
                },
                child: Text("Atualizar produto",style: GoogleFonts.roboto(
                              textStyle:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
