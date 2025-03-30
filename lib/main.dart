import 'package:app_mochila/presentation/screens/auth/login_screen.dart';
import 'package:app_mochila/presentation/screens/auth/register/register_screen1.dart';
import 'package:app_mochila/presentation/screens/auth/register/register_screen2.dart';
import 'package:app_mochila/presentation/screens/auth/register/register_screen3.dart';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  //debugPaintSizeEnabled = true;
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
      widgetsBinding:
          widgetsBinding); //PRESERVE EL SPLASHSCREEN HASTA QUE EL METODO REMOVE ES LLAMDO
  // runApp(const MyApp());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  //SE HA CAMBIADO EL STATELES POR EL STATEFUL PARA PODER USAR EL MÉTODO INIT
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    //AGREGAMOS EL METODO INIT
    super.initState();
    initialization();
  }

  void initialization() async {
    //CREAMOS EL METODO ASINCRONO, DÁNDOLE UN DELAY Y BORRAMOS EL SPLASH Y LO LLAMAMOS DESDE EL INITSATE
    print('cargando...');
    await Future.delayed(const Duration(seconds: 3));
    print('Entrando');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppMochila',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        textTheme: const TextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen1(),
        '/registerPage2': (context) => const RegisterScreen2(),
        '/registerPage3': (context) => const RegisterScreen3(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
