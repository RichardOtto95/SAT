import 'package:flutter_modular/flutter_modular.dart';
import 'package:sat_consultar_notas/app/modules/consult_financial_notes/widgets/receiver_page.dart';
import 'package:sat_consultar_notas/app/modules/consult_financial_notes/widgets/xml_page.dart';
import 'consult_financial_notes_page.dart';
import 'consult_financial_notes_store.dart';

class ConsultFinancialNotesModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ConsultFinancialNotesStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const ConsultFinancialNotesPage()),
    ChildRoute('/receiver', child: (_, args) => const ReceiverPage()),
    ChildRoute('/xml', child: (_, args) => const XMLPage()),
  ];
}
