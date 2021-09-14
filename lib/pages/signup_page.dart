import 'dart:typed_data';

import 'package:app_vendedor/controllers/user_controller.dart';
import 'package:app_vendedor/models/user_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:validadores/Validador.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  
  String nome = "";
  String cpf = "";
  String email = "";
  String telefone = "";
  String senha = "";
  Uint8List? file;
  

  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar conta"),
      ),
      body: Container(
        
        child: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/logotrans.png",
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 30),

                  if (isLoading) CircularProgressIndicator(),
                  TextFormField(
                    validator: (String? texto) {
                      if (texto != null && texto.isNotEmpty) {
                        if (texto.length == 0) {
                          return 'Informe o Nome';
                        } else if (!regExp.hasMatch(texto)) {
                          return 'O Nome deve conter caracteres de a-z ou A-Z';
                        }
                      } else {
                        return 'Campo obrigatório';
                      }
                    },
                    onChanged: (texto) => nome = texto,
                    keyboardType: TextInputType.name,
                    autofocus: true,
                    decoration: InputDecoration(
                      fillColor: Color(0xFFe0aaff),
                      filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'Nome completo ',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  //-------------------------------------------------------------------------------
                  SizedBox(height: 10),
                  //-------------------------------------------------------------------------------
                  TextFormField(
                    validator: (value) {
                      
                      // Aqui entram as validações
                      return Validador()
                          .add(Validar.CPF, msg: 'CPF Inválido')
                          .add(Validar.OBRIGATORIO, msg: 'Campo obrigatório')
                          .minLength(11)
                          .maxLength(11)
                          .valido(value, clearNoNumber: true);
                    },
                     onChanged: (texto) => cpf = texto,
                  keyboardType: TextInputType.number,
                  autofocus: true,
                    decoration: InputDecoration(
                       fillColor: Color(0xFFe0aaff),
                      filled: true,
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(color: Colors.brown),
                        hintText: '123.456.789-00',
                        labelText: 'Informe seu CPF',  prefixIcon: Icon(Icons.badge),
                        ),
                        
                  ),
                  //-------------------------------------------------------------------------------
                  SizedBox(
                      height:
                          10), //-------------------------------------------------------------------------------
                  TextFormField(
                    validator: (String? texto) {
                      if (texto != null && texto.isNotEmpty) {
                        if (!texto.contains('@') || texto.length < 8) {
                          return 'Digite um email válido';
                        }
                      } else {
                        return 'Campo obrigatório.';
                      }
                    },
                    onChanged: (texto) => email = texto,
                    style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.emailAddress,
                    autofocus: true,
                    decoration: InputDecoration(
                     fillColor: Color(0xFFe0aaff),
                      filled: true,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.mail_outline,
                      ),
                      labelText: 'Email',
                      //border: OutlineInputBorder(),
                    ),
                  ),
                  //-------------------------------------------------------------------------------
                  SizedBox(height: 10),
                  //-------------------------------------------------------------------------------
                  TextFormField(
                    validator: (String? texto) {
                      if (texto != null && texto.isNotEmpty) {
                        final telefone = int.tryParse(texto);
                        if (telefone == null) {
                          return "Digite apenas números";
                        }
                      } else {
                        return "Campo obrigatório";
                      }
                    },
                     
                  onChanged: (texto) => telefone = texto,
                  keyboardType: TextInputType.phone,
                  autofocus: true,
                  decoration: InputDecoration(
                    fillColor: Color(0xFFe0aaff),
                      filled: true,
                      border: OutlineInputBorder(),
                    labelText: 'Telefone',
                    prefixIcon: Icon(Icons.tty_rounded),
                  ),
                ),
                  //-------------------------------------------------------------------------------
                  SizedBox(
                      height:
                          10), //-------------------------------------------------------------------------------

                  TextFormField(
                    validator: (String? texto) {
                      if (texto != null && texto.isNotEmpty) {
                        if (texto.length < 8) {
                          return "Digite uma senha com 8 caracteres ou mais";
                        }
                      } else {
                        return "Campo obrigatório";
                      }
                    },
                    onChanged: (texto) => senha = texto,
                    obscureText: true,
                    autofocus: true,
                    decoration: InputDecoration(
                     fillColor: Color(0xFFe0aaff),
                      filled: true,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.vpn_key_sharp),
                      labelText: 'Senha',
                      //border:OutlineInputBorder(),
                    ),
                  ),
                  //------------------------------------------------------------------------------
                  SizedBox(height: 30),
                  //-----------------------------------------------------------------------------
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
                  //------------------------------------------------------------------------------
                  SizedBox(height: 30),
                  //-----------------------------------------------------------------------------

                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final user = UserModel(nome: nome, cpf:cpf, telefone:telefone, image: file);
                       
                        setState(() {
                          isLoading = true;
                        });
                        await userController.signup(email, senha, user);

                        Navigator.pop(context);
                      } on FirebaseAuthException catch (e) {
                        setState(() {
                          isLoading = false;
                        });

                        var msg = "";

                        if (e.code == "weak-password") {
                          msg = "senha fraca !";
                        } else if (e.code == "email-already-in-use") {
                          msg = "Email já cadastrado";
                        } else {
                          msg = "Ocorreu um erro";
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(msg),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary:Color(0xFF9d4edd),
                    ),
                    child: Text(
                      "Criar conta",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                  //------------------------------------------------------------------------------
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


