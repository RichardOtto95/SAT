import 'package:flutter/material.dart';

import '../utilities/utilities.dart';

class CustomCheck extends StatelessWidget {
  final String text;
  final double? textWidth;
  final double? fontSize;
  final double? left;
  final double bottom;
  final double? width;
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
    this.bottom = 10,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return check(context);
  }

  Widget check(context) => GestureDetector(
        //  onTap: onTap,
        child: Container(
          width: width ?? maxWidth(context),
          padding: EdgeInsets.only(bottom: bottom),
          child: Row(
            mainAxisAlignment:
                isRight ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isRight)
                Container(
                  height: 27,
                  width: 27,
                  margin: EdgeInsets.only(
                    left: left ?? 10,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                        color: getColors(context).onPrimaryContainer),
                    color: checked
                        ? getColors(context).primary
                        : getColors(context).surface,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.check,
                    size: 25,
                    color: getColors(context).surface,
                  ),
                ),
              if (isRight) hSpace(left ?? 10),
              SizedBox(
                width: textWidth ??
                    (width ?? maxWidth(context)) - (47 + (left ?? 10)),
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
                  height: 27,
                  width: 27,
                  margin: EdgeInsets.only(
                    right: 10,
                    left: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: getColors(context).onSurface),
                    color: checked
                        ? getColors(context).primary
                        : getColors(context).surface,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.check,
                    size: 25,
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
    this.padding = true,
  });

  final String text;
  final bool checked;
  final void Function(bool)? onTap;
  final double? left;
  final double? right;
  final double? bottom;
  final double? width;
  final bool padding;

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
        width: widget.width ?? maxWidth(context),
        margin: EdgeInsets.only(
          left: widget.left ?? (widget.padding ? 10 : 0),
          right: widget.right ?? (widget.padding ? 10 : 0),
          bottom: widget.bottom ?? (widget.padding ? 10 : 0),
        ),
        child: Row(
          children: [
            Container(
              height: 27,
              width: 27,
              margin: EdgeInsets.only(
                right: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border:
                    Border.all(color: getColors(context).onPrimaryContainer),
                color: _checked
                    ? getColors(context).primary
                    : getColors(context).surface,
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.check,
                size: 25,
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
