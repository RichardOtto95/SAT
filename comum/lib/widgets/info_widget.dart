import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/utilities.dart';

class InfoWidget extends StatelessWidget {
  final String info;
  final int infoLines;
  final double? width;
  final EdgeInsets? padding;
  final double? fontSize;

  const InfoWidget({
    super.key,
    required this.info,
    this.fontSize,
    this.infoLines = 8,
    this.width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width ?? maxWidth(context) - 20,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "./assets/svg/info.svg",
            width: 23,
          ),
          hSpace(10),
          Expanded(
            // width: 355,
            child: Text(
              info,
              style: getStyles(context).displaySmall?.copyWith(
                    fontSize: fontSize ?? 14,
                    color: getColors(context).primary,
                  ),
              maxLines: infoLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
