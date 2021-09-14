import 'package:app_vendedor/controllers/user_controller.dart';
import 'package:app_vendedor/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String senha = "";
   String cpf = "";

  bool continuarConectado = false;

  late final userController =
      Provider.of<UserController>(context, listen: false);

  //get children => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: new EdgeInsets.all(10.0),
   
 
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/logotrans.png',
                  height: 300,
                  //margin: EdgeInsets 0;
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
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
                        style: TextStyle(color: Colors.black,fontSize: 20,),
                        keyboardType: TextInputType.emailAddress,
                        autofocus: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail_outline,
                          ),
                          labelText: 'Email',
                          fillColor: Color(0xFFe0aaff),
                          filled: true,
                          contentPadding:
                              new EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                      //-------------------------------------------------------------------------------
                      SizedBox(height: 25),
                      //-------------------------------------------------------------------------------
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
                        style: TextStyle(color: Colors.black,fontSize: 20,),
                        obscureText: true,
                        autofocus: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key_sharp),
                          labelText: 'Senha',
                          fillColor: Color(0xFFe0aaff),
                          filled: true,
                          contentPadding:
                              new EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                       //------------------------------------------------------------------------------
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('ta funcionando???');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 100),
                          child: Text(
                            '',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 13,
                                // color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                       //------------------------------------------------------------------------------
                      Row(
                        children: [
                          Checkbox(
                            value: this.continuarConectado,
                            onChanged: (bool? novoValor) {
                              setState(() {
                                this.continuarConectado = novoValor ?? true;
                              });
                            },
                          ),
                          Text(
                            'Continuar conectado?',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 14,
                                // color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                       //------------------------------------------------------------------------------
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: Container(
                          // height: ,
                          width: 250,
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                await userController.login(email, senha);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == "wrong-password") {
                                } else if (e.code == "Invalid-email") {
                                } else {}
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Ocorre um erro: ${e.code}")),
                                );
                              }
                            },
                            style:OutlinedButton.styleFrom(
                               primary: Colors.white,
      backgroundColor: Color(0xFFe0aaff),
      shadowColor: Colors.red,
      elevation: 10,
                            ),
                            child: Text(
                              "Login",
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                           //--------------------------------------------------------------------------
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Divider(),
                      ),
                      Text(
                        'Ainda não tem uma conta?',
                        style: GoogleFonts.changa(
                          textStyle: TextStyle(
                            fontSize: 16,
                            // color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 250,
                          child: OutlinedButton(
                            
                             style: OutlinedButton.styleFrom(
      primary: Colors.white,
      backgroundColor: Color(0xFFe0aaff),
      shadowColor: Colors.red,
      elevation: 10,
    ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Cadastre-se',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ); 
  }
}
