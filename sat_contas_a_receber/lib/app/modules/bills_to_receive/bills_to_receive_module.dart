import 'package:flutter_modular/flutter_modular.dart';
import 'package:sat_contas_a_receber/app/modules/bills_to_receive/widgets/create_bill.dart';
import 'bills_to_receive_page.dart';
import 'bills_to_receive_store.dart';

class BillsToReceiveModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => BillsToReceiveStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const BillsToReceivePage()),
    ChildRoute('/create-bill-to-receive',
        child: (_, args) => const CreateBill()),
  ];
}
