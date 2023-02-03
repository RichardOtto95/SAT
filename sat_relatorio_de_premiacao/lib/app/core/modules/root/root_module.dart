import 'package:flutter_modular/flutter_modular.dart';
import '../../../modules/consult_financial_notes/award_report_module.dart';
import 'root_page.dart';

class RootModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (_, __) => const RootPage()),
    ModuleRoute("/award-report/", module: AwardReportModule()),
  ];
}
