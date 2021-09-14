import 'package:app_vendedor/controllers/user_controller.dart';
import 'package:app_vendedor/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  // Ele inicializa o Firebase, ele vem antes do runApp, para poder carregar umas depêndencias e garantir que o Firebase inicie corretamente.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const cor = Color(0xFF9d4edd);
    //BuildContext ele diz para o Flutter endereços(informações) na arvore (Context = endereços)
    // Provider.. ele ajudar aprover os changesNotifier no app. A classe ChangeNotifierProvider, prover o UserController para todo o app a partir do return
    //Create é uma função que retorna um ChangeNotifier = UserController
    //Desde que você tenha um context é possível acessar a informação em qualquer lugar da arvore. Por isso você vai colocar ele antes do MaterialApp

    return ChangeNotifierProvider(
      create: (context) => UserController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Vendedor',
        theme: ThemeData(
          primaryColor: cor, accentColor: cor,
        ),
        home: SplashPage(),
      ),
    );
  }
}
