// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:sat_fornecedores/app/core/modules/root/root_Page.dart';
import 'package:sat_fornecedores/app/core/modules/root/root_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sat_fornecedores/app/modules/main/main_module.dart';
import 'package:sat_fornecedores/app/modules/suppliers/suppliers_module.dart';

class RootModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => RootStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const RootPage()),
    ModuleRoute("/main", module: MainModule()),
    ModuleRoute("/suppliers", module: SuppliersModule()),
  ];
}
