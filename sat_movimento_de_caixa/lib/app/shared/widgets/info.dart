import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sat_movimento_de_caixa/app/shared/utilities.dart';

class InfoWidget extends StatelessWidget {
  final String info;
  final int infoLines;

  const InfoWidget({super.key, required this.info, this.infoLines = 8});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidth(context) - 40,
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
                    fontSize: 14,
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
