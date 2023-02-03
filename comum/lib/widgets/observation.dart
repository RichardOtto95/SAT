import 'package:flutter/material.dart';
import '../utilities/utilities.dart';

class Observation extends StatelessWidget {
  const Observation({
    super.key,
    required this.label,
    this.hint = "",
    this.data,
    this.height,
  });

  final String label;
  final String hint;
  final String? data;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 10,
              bottom: 5,
            ),
            child: Text(
              label,
              style: getStyles(context).labelMedium?.copyWith(
                    color: getColors(context).primary,
                  ),
            ),
          ),
          Container(
            width: maxWidth(context) - 20,
            height: height ?? 122,
            padding: EdgeInsets.fromLTRB(
              10,
              5,
              10,
              5,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: getColors(context).onPrimaryContainer),
              borderRadius: BorderRadius.circular(14),
            ),
            child: TextFormField(
              initialValue: data,
              style: getStyles(context).displaySmall?.copyWith(
                    color: getColors(context).onBackground,
                  ),
              decoration: InputDecoration.collapsed(
                hintText: hint,
                hintStyle: getStyles(context).displaySmall?.copyWith(
                      color: getColors(context).onBackground.withOpacity(.5),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
