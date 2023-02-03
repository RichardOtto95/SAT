import 'package:flutter/cupertino.dart';

import '../utilities/utilities.dart';

BorderRadius defBorderRadius(context) => BorderRadius.circular(20);

BoxShadow defBoxShadow(context) => BoxShadow(
      blurRadius: wXD(3, context),
      offset: Offset(0, wXD(3, context)),
      color: getColors(context).shadow,
    );

BoxShadow defBoxShadowMove(context, pressed) => BoxShadow(
      blurRadius: pressed ? wXD(1, context) : wXD(3, context),
      offset: Offset(0, pressed ? wXD(1, context) : wXD(3, context)),
      color: getColors(context).shadow,
    );
