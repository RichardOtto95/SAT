import 'package:flutter/material.dart';

import '../utilities.dart';

class CustomCheck extends StatelessWidget {
  final String title;
  final double? textWidth;
  final bool checked;
  final bool isRight;
  final void Function()? onTap;

  const CustomCheck({
    Key? key,
    required this.title,
    required this.checked,
    this.isRight = false,
    this.onTap,
    this.textWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return check(context);
  }

  Widget check(context) => GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.only(bottom: wXD(10, context)),
          child: Row(
            mainAxisAlignment:
                isRight ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isRight)
                Container(
                  height: wXD(27, context),
                  width: wXD(27, context),
                  margin: EdgeInsets.only(
                    left: wXD(16, context),
                    right: wXD(10, context),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(wXD(10, context)),
                    border: Border.all(color: getColors(context).onSurface),
                    color: checked
                        ? getColors(context).primary
                        : getColors(context).surface,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.check,
                    size: wXD(25, context),
                    color: getColors(context).surface,
                  ),
                ),
              SizedBox(
                width: textWidth,
                child: Text(
                  title,
                  style: getStyles(context).bodyMedium,
                  maxLines: 2,
                ),
              ),
              if (isRight)
                Container(
                  height: wXD(27, context),
                  width: wXD(27, context),
                  margin: EdgeInsets.only(
                    right: wXD(16, context),
                    left: wXD(10, context),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(wXD(10, context)),
                    border: Border.all(color: getColors(context).onSurface),
                    color: checked
                        ? getColors(context).primary
                        : getColors(context).surface,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.check,
                    size: wXD(25, context),
                    color: getColors(context).surface,
                  ),
                ),
            ],
          ),
        ),
      );
}
