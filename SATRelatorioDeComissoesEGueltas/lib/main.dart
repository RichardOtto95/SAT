import 'package:comum/constants/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/app_module.dart';
import '/app/app_widget.dart';

void main() async {
  // versaoSAT = '220829A';
  // appName = 'Atendimento';
  // await initSAT();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // initializeReflectable();
  runApp(const InitialApp());
}

class InitialApp extends StatefulWidget {
  const InitialApp({Key? key}) : super(key: key);

  @override
  State<InitialApp> createState() => _InitialAppState();
}

class _InitialAppState extends State<InitialApp> {
  var app = ModularApp(
    module: AppModule(),
    child: const MediaQuery(data: MediaQueryData(), child: AppWidget()),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [Locale('pt', 'BR')],
      title: 'SAT Produtos',
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      debugShowCheckedModeBanner: false,
      home: // const Login(destination: Mesas()),
          app,
      builder: (context, child) => app,
    );
  }
}
