import 'package:flutter_modular/flutter_modular.dart';
// import 'package:sat_produtos/app/modules/products/products_module.dart';

import 'orders_page.dart';
import 'orders_store.dart';

class OrdersModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => OrdersStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const OrdersPage()),
  ];
}
