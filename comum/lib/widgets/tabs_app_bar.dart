import 'package:comum/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../constants/properties.dart';

class TabsAppBar extends StatefulWidget {
  const TabsAppBar({
    super.key,
    this.onPop,
    required this.title,
    required this.tabs,
    required this.tab,
    this.actions,
    this.leading,
    required this.onSelect,
  });

  final void Function()? onPop;
  final String title;
  final Widget? actions;
  final Widget? leading;
  final List<String> tabs;
  final int tab;
  final void Function(int tab) onSelect;

  @override
  State<TabsAppBar> createState() => TabsAppBarState();
}

class TabsAppBarState extends State<TabsAppBar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: viewPaddingTop(context) + 104,
          width: maxWidth(context),
          decoration: BoxDecoration(
            color: getColors(context).primary,
            boxShadow: [defBoxShadow(context)],
          ),
          padding: EdgeInsets.only(top: viewPaddingTop(context)),
          alignment: Alignment.topCenter,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    vSpace(5),
                    Row(
                      children: [
                        hSpace(5),
                        Expanded(
                          child: widget.actions ??
                              Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  // radius: 300,
                                  borderRadius: BorderRadius.circular(300),

                                  onTap: widget.onPop ??
                                      () {
                                        Modular.to.pop();
                                      },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.arrow_back_rounded,
                                      // size:
                                    ),
                                  ),
                                ),
                              ),
                        ),
                        Text(
                          widget.title,
                          style: getStyles(context).titleMedium,
                        ),
                        Expanded(
                          child: widget.leading ?? Container(),
                        ),
                        hSpace(5),
                      ],
                    ),
                    vSpace(5),
                    buildTabs(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  buildTabs() {
    return SizedBox(
      width: maxWidth(context),
      height: 44,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 10, bottom: 10),
        child: Row(
          children: List.generate(
            widget.tabs.length,
            (index) => Material(
              color: Colors.transparent,
              child: Row(
                children: [
                  InkWell(
                    onTap: () => widget.onSelect(index),
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: getColors(context).onPrimary),
                        borderRadius: BorderRadius.circular(5),
                        color: widget.tab == index
                            ? getColors(context).onPrimary
                            : getColors(context).primary,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        widget.tabs[index],
                        style: getStyles(context).labelMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: widget.tab != index
                                  ? getColors(context).onPrimary
                                  : getColors(context).primary,
                            ),
                      ),
                    ),
                  ),
                  hSpace(10),
                ],
              ),
            ),
          ),
          // widget.tabs
          //     .map<Widget>(
          //       (tab) =>
          //     )
          //     .toList(),
        ),
      ),
    );
  }
}
