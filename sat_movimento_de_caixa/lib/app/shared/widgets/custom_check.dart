import 'package:flutter/material.dart';

import '../utilities.dart';

class CustomCheck extends StatelessWidget {
  final String text;
  final double? textWidth;
  final double? fontSize;
  final double? left;
  final Color? color;
  final bool checked;
  final bool isRight;
  final FontWeight? fontWeight;
  final void Function()? onTap;

  const CustomCheck({
    Key? key,
    required this.text,
    required this.checked,
    this.isRight = false,
    this.onTap,
    this.textWidth,
    this.fontSize,
    this.fontWeight,
    this.left,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return check(context);
  }

  Widget check(context) => GestureDetector(
        //  onTap: onTap,
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
                    left: left ?? wXD(20, context),
                    right: wXD(10, context),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(wXD(7, context)),
                    border: Border.all(
                        color: getColors(context).onPrimaryContainer),
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
                  text,
                  style: getStyles(context).labelLarge!.copyWith(
                        color: color ?? getColors(context).secondaryContainer,
                        fontWeight: FontWeight.w500,
                        fontSize: fontSize,
                      ),
                  maxLines: 3,
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
                    borderRadius: BorderRadius.circular(wXD(7, context)),
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

class BodyCheck extends StatefulWidget {
  const BodyCheck({
    super.key,
    required this.text,
    required this.checked,
    this.onTap,
    this.left,
    this.right,
    this.bottom,
    this.width,
  });

  final String text;
  final bool checked;
  final void Function(bool)? onTap;
  final double? left;
  final double? right;
  final double? bottom;
  final double? width;

  @override
  State<BodyCheck> createState() => _BodyCheckState();
}

class _BodyCheckState extends State<BodyCheck> {
  late bool _checked;
  @override
  void initState() {
    super.initState();
    _checked = widget.checked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          setState(() {
            _checked = !_checked;
            widget.onTap!(_checked);
          });
        }
      },
      child: Container(
        width: widget.width ?? wXD(428, context),
        margin: EdgeInsets.only(
          left: widget.left ?? wXD(20, context),
          right: widget.right ?? wXD(20, context),
          bottom: widget.bottom ?? wXD(10, context),
        ),
        child: Row(
          children: [
            Container(
              height: wXD(27, context),
              width: wXD(27, context),
              margin: EdgeInsets.only(
                right: wXD(10, context),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(wXD(7, context)),
                border:
                    Border.all(color: getColors(context).onPrimaryContainer),
                color: _checked
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
            Expanded(
              child: Text(
                widget.text,
                style: getStyles(context).labelLarge!.copyWith(
                      color: getColors(context).secondaryContainer,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
