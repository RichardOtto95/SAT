import 'package:flutter_modular/flutter_modular.dart';
import 'package:sat_relatorio_de_premiacao/app/modules/consult_financial_notes/widgets/receiver_page.dart';
import 'package:sat_relatorio_de_premiacao/app/modules/consult_financial_notes/widgets/xml_page.dart';
import 'award_report_page.dart';
import 'award_report_store.dart';

class AwardReportModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AwardReportStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const AwardReportPage()),
    ChildRoute('/receiver', child: (_, args) => const ReceiverPage()),
    ChildRoute('/xml', child: (_, args) => const XMLPage()),
  ];
}
