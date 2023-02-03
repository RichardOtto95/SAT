import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'widgets/responsive.dart';

/// Valor da largura total: 428
double wXD(
  double size,
  BuildContext context, {
  double? ws,
  bool mediaWeb = false,
}) {
  if (Responsive.isDesktop(context)) {
    double _size = ws ?? size;
    if (mediaWeb) {
      return MediaQuery.of(context).size.width / 1920 * _size;
    } else {
      return _size;
    }
  }
  return MediaQuery.of(context).size.width / 428 * size;
}

/// Valor da largura total: 926
double hXD(double size, BuildContext context) {
  return MediaQuery.of(context).size.height / 926 * size;
}

double maxHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double maxWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double viewPaddingTop(context) => MediaQuery.of(context).viewPadding.top;

Widget vSpace(double val) => SizedBox(height: val);

Widget hSpace(double val) => SizedBox(width: val);

Brightness brightness =
    MediaQueryData.fromWindow(WidgetsBinding.instance.window)
        .platformBrightness;

late ColorScheme colors;

late TextTheme styles;

ColorScheme getColors(context) => colors = Theme.of(context).colorScheme;

TextTheme getStyles(context) => styles = Theme.of(context).textTheme;

SystemUiOverlayStyle getOverlayStyleFromColor(Color color) {
  Brightness brightness = ThemeData.estimateBrightnessForColor(color);
  return brightness == Brightness.dark
      ? SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: colors.surface,
          systemNavigationBarIconBrightness: Brightness.light,
        )
      : SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: colors.surface,
          systemNavigationBarIconBrightness: Brightness.dark);
}

String formatedCurrency(var value) {
  //if(kDebugMode) print('Formated Currency: $value');
  var newValue = NumberFormat("R\$ #,##0.00", "pt_BR");
  return newValue.format(value);
}
