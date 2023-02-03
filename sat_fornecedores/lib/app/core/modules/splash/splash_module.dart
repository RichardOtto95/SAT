// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

import 'package:sat_fornecedores/app/core/modules/splash/splash_page.dart';
import 'package:sat_fornecedores/app/core/modules/splash/splash_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends WidgetModule {
  SplashModule({Key? key}) : super(key: key);

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SplashStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const SplashPage()),
  ];

  @override
  Widget get view => const SplashPage();
}
