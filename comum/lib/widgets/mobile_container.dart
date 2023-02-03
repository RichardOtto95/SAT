import 'package:flutter/material.dart';

import '../utilities/utilities.dart';

class MobileContainer extends StatelessWidget {
  final Widget child;

  const MobileContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wXD(428, context),
      padding: EdgeInsets.only(left: wXD(20, context)),
      alignment: Alignment.centerLeft,
      child: child,
    );
  }
}
