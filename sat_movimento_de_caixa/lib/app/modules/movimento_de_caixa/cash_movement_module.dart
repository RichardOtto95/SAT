import 'package:flutter_modular/flutter_modular.dart';
import 'package:sat_movimento_de_caixa/app/modules/movimento_de_caixa/widgets/info_page.dart';

import 'cash_movement_page.dart';
import 'cash_movement_store.dart';

class CashMovementModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CashMovementStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const CashMovementPage()),
    ChildRoute('/info', child: (_, args) => InfoPage()),
  ];
}
