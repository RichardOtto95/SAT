import 'package:flutter/material.dart';

import '../utilities/utilities.dart';

class ContainerTextField extends StatelessWidget {
  final double? height;
  final double? width;
  final String? hint;
  final String? initialValue;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final void Function(String)? onChanged;

  const ContainerTextField({
    Key? key,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.hint,
    this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 55,
      width: width ?? 172,
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: getColors(context).primaryContainer.withOpacity(.2),
        border: Border.all(color: getColors(context).primaryContainer),
      ),
      alignment: Alignment.centerLeft,
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        scrollPadding: EdgeInsets.zero,
        style: Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(
              color: getColors(context).onSurfaceVariant,
            ),
        decoration: InputDecoration(
          hintText: hint ?? "",
        ),
      ),
    );
  }
}
