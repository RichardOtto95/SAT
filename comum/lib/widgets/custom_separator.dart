import 'package:flutter/material.dart';
import '../utilities/utilities.dart';

class CustomSeparator extends StatelessWidget {
  const CustomSeparator({super.key, this.width});

  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: width ?? double.infinity,
      color: getColors(context).onPrimaryContainer,
      margin: EdgeInsets.only(bottom: 15),
    );
  }
}
