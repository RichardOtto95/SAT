import 'package:flutter/material.dart';

import '../../constants/properties.dart';
import '../utilities.dart';

class CustomFloatButton extends StatelessWidget {
  final IconData? icon;
  final void Function() onTap;
  final Widget? child;
  final double size;

  const CustomFloatButton({
    super.key,
    this.icon,
    required this.onTap,
    this.child,
    this.size = 60,
  }) : assert(
          icon != null || child != null,
          "You must provide a icon or a child",
        );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: getColors(context).surface,
              boxShadow: [defBoxShadow(context)]),
          alignment: Alignment.center,
          child: child ??
              Icon(
                icon,
                color: getColors(context).primary,
                size: 35,
              ),
        ),
      ),
    );
  }
}
