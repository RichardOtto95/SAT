// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

import 'package:sat_movimento_de_caixa/app/core/modules/splash/splash_page.dart';
import 'package:sat_movimento_de_caixa/app/core/modules/splash/splash_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends WidgetModule {
  SplashModule({Key? key}) : super(key: key);

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SplashStore()),
  ];

  @override
  Widget get view => const SplashPage();
}
