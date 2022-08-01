import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:worldlan_apps/models/prueba.dart';

import 'package:worldlan_apps/screens/screens.dart';
import 'package:worldlan_apps/services/services.dart';

// INSTALA PAQUETES CON LA TERMINAL "Pubspec"

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProductsService())],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clinica Andre',
        initialRoute: 'login',
        routes: {
          'login': (_) => LoginScreen(),
          'home': (_) => HomeScreen(),
          'product': (_) => ProductScreen(),
          // 'prueba': (_) => VideoPlayerController(),
        },
        theme: ThemeData.light().copyWith(
            //Color de Fondo Gris
            scaffoldBackgroundColor: Colors.grey[250],
            appBarTheme:
                const AppBarTheme(elevation: 0, color: Colors.greenAccent),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.greenAccent,
              elevation: 0,
            )));
  }
}
