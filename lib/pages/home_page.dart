import 'dart:typed_data';
import 'dart:ui';
import 'package:app_vendedor/controllers/user_controller.dart';
import 'package:app_vendedor/models/prod_model.dart';
import 'package:app_vendedor/pages/add_prod.dart';
import 'package:app_vendedor/pages/hist_notbooks.dart';
import 'package:app_vendedor/pages/hist_promocao.dart';
import 'package:app_vendedor/pages/hist_televisao.dart';
import 'package:app_vendedor/pages/hist_video_game.dart';
import 'package:app_vendedor/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dashboard/dashboard/dashboard.dart';
import 'edit_prod.dart';
import 'hist_celulares.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  Uint8List? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  title: Image.asset("assets/images/logo.png"),

        title: Text(
          'Eletron',
          style: GoogleFonts.changa(
            textStyle: TextStyle(
              fontSize: 28,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await userController.logout();
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      //-------------------------------------------------------------------------
      drawer: Drawer(
        child: ListView(
          children: [

            GestureDetector(
              onTap: () async {
                final result =
                  await FilePicker.platform.pickFiles(type: FileType.image);
              if(result != null) {
                setState((){
                  final bytes = result.files.first.bytes;
                  file = bytes;
                });
              }
              },
              child: UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: userController.model.image !=null
                      ? Image.memory(
                        userController.model.image!,
                        width: 144,
                        height: 144,
                        fit:BoxFit.cover
                        )
                      : Icon(Icons.person),
                     )),
                
                accountName: Text(
                  userController.model.nome,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
                accountEmail: Text(
                  userController.user!.email!,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
                //---------------------------------------------------------------
                decoration: BoxDecoration(
                  color: Color(0xFF9d4edd),
                  gradient: LinearGradient(colors: [
                    Color(0xFFe0aaff),
                    Colors.white,
                    Color(0xFF9d4edd),
                    Colors.white,
                    Color(0xFF9d4edd),
                  ]),
                ),
              ),
            ),

            //-----------------------------------------------------------------
            ListTile(
              title: Text(
                "Eletron",
                style: GoogleFonts.changa(
                  textStyle: TextStyle(
                    fontSize: 28,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
            ),
            //--------------------------------------------------------------------

            ListTile(
              leading: FaIcon(FontAwesomeIcons.mobileAlt),
              title: Text("Celulares"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoricoCelulares(),
                  ),
                );
              },
            ),
            //------------------------------------------------------------------
            ListTile(
              leading: FaIcon(FontAwesomeIcons.laptopCode),
              title: Text("Notebooks"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoricoNotbooks(),
                  ),
                );
              },
            ),
//-------------------------------------------------------------------------
            ListTile(
              leading: FaIcon(FontAwesomeIcons.tv),
              title: Text("Televisores"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoricoTelevisao(),
                  ),
                );
              },
            ),
            //------------------------------------------------------------------
            ListTile(
              leading: FaIcon(FontAwesomeIcons.gamepad),
              title: Text("Video Games"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoricoVideogame(),
                  ),
                );
              },
            ),
            //----------------------------------------------------------------
            ListTile(
              title: Text(
                "Destaques",
                style: GoogleFonts.changa(
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
            ),
//------------------------------------------------------------------------------
            ListTile(
              title: Text("Mais Vendidos"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
//-------------------------------------------------------------------            
            ListTile(          
              title: Text("Produtos em Promoção"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoricoPromocao(),
                  ),
                );
              },
            ),
//-------------------------------------------------------------------            
            ListTile(
              title: Text("Dashboard"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Dashboard(),
                  ),
                );
              },
            ),
//-------------------------------------------------------------------            
          ],
        ),
      ),
//--------------------------------------------------------------------
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('produtos')
            .where('keyVendedor', isEqualTo: userController.user!.uid)
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
              ListTile(
                title: Text(produto.nome),
                subtitle: Row(
                  children: [


                    Expanded(child: Text(produto.descricao)),
                    Text("  R\$ ${produto.preco}",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),

                  ],
                ),
                leading: produto.imagem != null
                    ? Image.memory(
                        produto.imagem!,
                        fit: BoxFit.cover,
                        width: 108,
                      )
                    : Container(
                        child: Icon(Icons.list),
                        width: 108,
                        height: double.maxFinite,
                        color: Colors.blue,
                      ),
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
              );
            },
          );
        },
      ),
      
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProduto(),
            ),
          );
        },
      ),
    );
  }
}
