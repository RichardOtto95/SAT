import 'package:flutter_modular/flutter_modular.dart';
import 'answer_representative_page.dart';
import 'answer_representative_store.dart';
import 'widgets/filters_page.dart';

class AnswerRepresentativeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AnswerRepresentativeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const AnswerRepresentativePage()),
    ChildRoute('/filter', child: (_, args) => const FiltersPage()),
  ];
}
