import 'package:flutter_modular/flutter_modular.dart';
import '../../../modules/consult_financial_notes/answer_representative_module.dart';
import 'root_page.dart';

class RootModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (_, __) => const RootPage()),
    ModuleRoute("/answer-representative/",
        module: AnswerRepresentativeModule()),
  ];
}
