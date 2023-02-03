import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sat_fornecedores/app/core/modules/root/root_store.dart';
import 'package:flutter/material.dart';

import '../../../constants/theme_constants.dart';
import '../splash/splash_module.dart';

class RootPage extends StatefulWidget {
  final String title;
  const RootPage({Key? key, this.title = 'RootPage'}) : super(key: key);
  @override
  RootPageState createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  final RootStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
            theme: lightTheme(context),
            darkTheme: darkTheme(context),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            // themeMode: store.themeMode,
            debugShowCheckedModeBanner: false,
            home: SplashModule(),
            // home: getChild(),
          ),
        );
      },
    );
  }
}
