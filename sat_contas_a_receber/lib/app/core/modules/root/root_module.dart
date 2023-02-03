import 'package:flutter_modular/flutter_modular.dart';
import '../../../modules/bills_to_receive/bills_to_receive_module.dart';
import 'root_page.dart';

class RootModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (_, __) => const RootPage()),
    ModuleRoute("/bills-to-receive/", module: BillsToReceiveModule()),
  ];
}
