import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;
import '../utilities/utilities.dart';

class ExpandItem extends StatefulWidget {
  const ExpandItem({
    super.key,
    required this.icon,
    required this.title,
    required this.children,
  });

  final String icon;
  final String title;
  final List<Widget> children;

  @override
  State<ExpandItem> createState() => _ExpandItemState();
}

class _ExpandItemState extends State<ExpandItem>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> animate() => controller.animateTo(controller.value == 1 ? 0 : 1,
      duration: const Duration(milliseconds: 400), curve: Curves.decelerate);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: getColors(context).primaryContainer),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => animate(),
              child: Container(
                height: 54,
                width: maxWidth(context) - 40,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "./assets/svg/${widget.icon}.svg",
                      width: 20,
                    ),
                    hSpace(20),
                    Text(
                      widget.title,
                      style: getStyles(context).titleSmall,
                    ),
                    const Spacer(),
                    AnimatedBuilder(
                      animation: controller,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: getColors(context).onSurface,
                      ),
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: math.pi * controller.value,
                          child: child,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: controller,
          axisAlignment: -1,
          child: SizedBox(
            width: maxWidth(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                vSpace(10),
                ...widget.children,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
