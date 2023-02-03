import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../constants/properties.dart';
import '../utilities/utilities.dart';

class DefaultAppBar extends StatefulWidget {
  final void Function()? onPop;

  final String title;

  final double? height;

  final List<Widget>? actions;

  final bool pop;

  final Widget? positioned;

  const DefaultAppBar({
    super.key,
    this.onPop,
    required this.title,
    this.actions,
    this.pop = true,
    this.positioned,
    this.height,
  });

  @override
  State<DefaultAppBar> createState() => _DefaultAppBarState();
}

class _DefaultAppBarState extends State<DefaultAppBar> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getSystemUiOverlayStyle(getColors(context).primary),
      child: Container(
        width: maxWidth(context),
        height: viewPaddingTop(context) + (widget.height ?? 65),
        padding: EdgeInsets.only(top: viewPaddingTop(context)),
        decoration: BoxDecoration(
          color: getColors(context).primary,
          boxShadow: [defBoxShadow(context)],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              widget.title,
              style: getStyles(context).titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: getColors(context).onPrimary,
                  ),
            ),
            Row(
              children: [
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: widget.pop
                          ? IconButton(
                              icon: const Icon(
                                Icons.arrow_back_rounded,
                              ),
                              onPressed: widget.onPop ?? () => Modular.to.pop(),
                            )
                          : null,
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: widget.actions ?? [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (widget.positioned != null) widget.positioned!
          ],
        ),
      ),
    );
  }
}
