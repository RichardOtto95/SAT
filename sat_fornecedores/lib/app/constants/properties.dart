import 'package:flutter/cupertino.dart';
import 'package:sat_fornecedores/app/shared/utilities.dart';

BorderRadius defBorderRadius(context) => BorderRadius.circular(20);

BoxShadow defBoxShadow(context) => BoxShadow(
      blurRadius: wXD(3, context),
      offset: Offset(0, wXD(3, context)),
      color: getColors(context).shadow,
    );
