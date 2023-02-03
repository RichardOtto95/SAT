import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateController extends TextEditingController {
  DateController({DateTime? date}) {
    _date.addListener(() {
      if (_date.value != null) {
        super.text = DateFormat('dd/MM/yyyy').format(_date.value!);
      }
    });

    _date.value = date;
  }

  DateTime? get date => _date.value;
  set date(DateTime? value) => _date.value = value;

  @override
  void dispose() {
    _date.dispose();
    super.dispose();
  }

  final ValueNotifier<DateTime?> _date = ValueNotifier<DateTime?>(null);
}
