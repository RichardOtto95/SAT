import 'dart:ui';

import 'package:comum/utilities/adjustable_scroll_controller.dart';
import 'package:comum/utilities/custom_scroll_behavior.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utilities/utilities.dart';

class DefaultOverlaySlider extends StatefulWidget {
  final void Function() onBack;
  final double? height;
  final Widget? child;
  final BoxConstraints? constraints;

  const DefaultOverlaySlider({
    super.key,
    required this.onBack,
    this.height,
    this.child,
    this.constraints,
  });

  @override
  State<DefaultOverlaySlider> createState() => DefaultOverlaySliderState();
}

class DefaultOverlaySliderState extends State<DefaultOverlaySlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  ScrollController scrollController = AdjustableScrollController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => animateTo(1),
    );
  }

  Future<void> animateTo(double value) async =>
      await _controller.animateTo(value,
          duration: const Duration(milliseconds: 400), curve: Curves.ease);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (kDebugMode) {
          print("barcode slide info willpopscope");
        }
        return false;
      },
      child: Positioned(
        height: maxHeight(context),
        width: maxWidth(context),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final value = _controller.value;
                  return BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: (2 * _controller.value) + 0.001,
                      sigmaY: (2 * _controller.value) + 0.001,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        await animateTo(0);
                        widget.onBack();
                      },
                      child: Container(
                        height: maxHeight(context),
                        width: maxWidth(context),
                        color: Colors.black.withOpacity(.3 * value),
                      ),
                    ),
                  );
                },
              ),
              SizeTransition(
                sizeFactor: _controller,
                axisAlignment: -1,
                child: Container(
                  height: widget.height,
                  constraints: widget.constraints,
                  width: maxWidth(context),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: const Radius.circular(30)),
                    color: getColors(context).surface,
                  ),
                  child: ScrollConfiguration(
                    behavior: CustomScrollBehavior(),
                    child: SingleChildScrollView(
                      // controller: scrollController,
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
