import 'dart:ui';

import 'package:flutter/material.dart';

import '../utilities.dart';

class DefaultOverlaySlider extends StatefulWidget {
  final double height;
  final void Function() onBack;
  final Widget child;

  const DefaultOverlaySlider({
    super.key,
    required this.height,
    required this.onBack,
    required this.child,
  });

  @override
  State<DefaultOverlaySlider> createState() => DefaultOverlaySliderState();
}

class DefaultOverlaySliderState extends State<DefaultOverlaySlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    animateTo(1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> animateTo(double target) => _controller.animateTo(target,
      duration: const Duration(milliseconds: 450), curve: Curves.decelerate);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: maxWidth(context),
      height: maxHeight(context),
      child: Material(
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return GestureDetector(
                  onTap: () async {
                    await animateTo(0);
                    widget.onBack();
                  },
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 0.001 + (2 * _controller.value),
                      sigmaY: 0.001 + (2 * _controller.value),
                    ),
                    child: Container(
                      height: maxHeight(context),
                      width: maxWidth(context),
                      color: getColors(context).shadow.withOpacity(
                            .3 * _controller.value,
                          ),
                    ),
                  ),
                );
              },
            ),
            SizeTransition(
              sizeFactor: _controller,
              axisAlignment: -1,
              child: Container(
                width: maxWidth(context),
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(wXD(30, context)),
                  ),
                  color: getColors(context).surface,
                ),
                child: widget.child,
              ),
            )
          ],
        ),
      ),
    );
  }
}
