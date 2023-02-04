import 'package:mobx/mobx.dart';

part 'root_store.g.dart';

// ignore: library_private_types_in_public_api
class RootStore = _RootStoreBase with _$RootStore;

abstract class _RootStoreBase with Store {}
