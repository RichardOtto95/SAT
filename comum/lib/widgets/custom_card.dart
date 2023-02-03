import 'package:flutter/material.dart';

import '../../constants/properties.dart';
import '../utilities/utilities.dart';

class CustomCard extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final Widget? child;
  final Border? border;

  const CustomCard({
    Key? key,
    this.height,
    this.width,
    this.radius,
    this.padding,
    this.margin,
    this.alignment,
    this.child,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: radius != null
            ? BorderRadius.circular(radius!)
            : defBorderRadius(context),
        color: getColors(context).surface,
        border: border ?? Border.all(color: Color(0xffd9d9d9)),
        boxShadow: [defBoxShadow(context)],
      ),
      alignment: alignment,
      child: Material(
        color: Colors.transparent,
        child: child,
      ),
    );
  }
}
