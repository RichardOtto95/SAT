import 'package:comum/constants/theme_constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sat_orders/app/core/modules/root/root_store.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);
  @override
  RootPageState createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  final RootStore store = Modular.get();

  @override
  void initState() {
    Modular.to.pushReplacementNamed("/clients");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        // home: MainModule(),
        // home: getChild(),
      ),
    );
  }
}
