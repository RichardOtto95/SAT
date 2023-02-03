import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../utilities/utilities.dart';
import 'custom_card.dart';

class OptionsMenu extends StatefulWidget {
  final List<Map<String, String>> menuTabs;
  final LayerLink layerLink;
  final void Function() onBack;

  const OptionsMenu({
    super.key,
    required this.menuTabs,
    required this.layerLink,
    required this.onBack,
  });

  @override
  State<OptionsMenu> createState() => _OptionsMenuState();
}

class _OptionsMenuState extends State<OptionsMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      value: 0,
    );
    animateMenuTo(1);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<void> animateMenuTo(double value) =>
      animationController.animateTo(value,
          curve: Curves.decelerate,
          duration: const Duration(milliseconds: 300));

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onPanDown: (_) async {
              await animateMenuTo(0);
              widget.onBack();
            },
            child: Container(
              color: Colors.transparent,
              height: maxHeight(context),
              width: maxWidth(context),
            ),
          ),
          Positioned(
            width: wXD(228, context),
            height: wXD(148, context),
            child: CompositedTransformFollower(
              offset: Offset(
                -wXD(200, context),
                wXD(20, context),
              ),
              link: widget.layerLink,
              child: ScaleTransition(
                scale: animationController,
                alignment: Alignment.topRight,
                child: Material(
                  color: Colors.transparent,
                  child: CustomCard(
                    width: wXD(228, context),
                    height: wXD(148, context),
                    // padding: EdgeInsets.symmetric(
                    //   horizontal: wXD(8, context),
                    //   vertical: wXD(5, context),
                    // ),
                    radius: wXD(9, context),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(wXD(9, context)),
                      child: Column(
                        children: widget.menuTabs
                            .map<Widget>(
                              (e) => Expanded(
                                child: InkWell(
                                  borderRadius:
                                      BorderRadius.circular(wXD(9, context)),
                                  onTap: () async {
                                    animateMenuTo(0);
                                    widget.onBack();
                                    Modular.to
                                        .pushReplacementNamed(e[e.keys.first]!);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: wXD(15, context),
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      e.keys.first,
                                      style: getStyles(context)
                                          .labelMedium
                                          ?.copyWith(
                                            color: getColors(context).onSurface,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
