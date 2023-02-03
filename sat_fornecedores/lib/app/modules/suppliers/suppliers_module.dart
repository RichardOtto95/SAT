import 'package:sat_fornecedores/app/modules/suppliers/suppliers_Page.dart';
import 'package:sat_fornecedores/app/modules/suppliers/suppliers_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'widgets/create_suppliers.dart';

class SuppliersModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SuppliersStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const SuppliersPage()),
    ChildRoute('/create-supplier',
        child: (_, args) => CreateSupplier(visualization: args.data)),
  ];
}
