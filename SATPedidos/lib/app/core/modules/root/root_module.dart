// ignore: implementation_imports, unused_import
import 'package:flutter/src/widgets/framework.dart';
import 'package:sat_orders/app/core/modules/root/root_page.dart';
import 'package:sat_orders/app/core/modules/root/root_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
// import 'package:sat_produtos/app/modules/products/products_module.dart';

import '../../../modules/orders/orders_module.dart';

class RootModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => RootStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (_, __) => const RootPage()),
    ModuleRoute("/clients", module: OrdersModule()),
    // ModuleRoute("/products/", module: ProductsModule()),
  ];
}
