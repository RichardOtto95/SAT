// ignore_for_file: deprecated_member_use, no_leading_underscores_for_local_identifiers, duplicate_ignore

import 'dart:math' as math;

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reflectable/reflectable.dart';

import 'constants/properties.dart';
import 'reflector.dart';
import 'utilities/utilities.dart';
import 'widgets/info_widget.dart';

class QueryWrapper {
  late final dynamic query;

  QueryWrapper({required this.query});
}

class DataForm extends InheritedWidget {
  final dynamic query;

  DataForm({
    super.key,
    required child,
    required this.query,
  }) : super(child: child) {
    instanceMirror = reflector.reflect(query);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  late final InstanceMirror instanceMirror;
  static DataForm? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DataForm>();
}

class DataInputText extends StatefulWidget {
  const DataInputText({
    required this.label,
    required this.field,
    this.enable = true,
    this.isNumber = false,
    // this.fill = false,
    this.isCurrency = false,
    this.minLines = 1,
    this.height,
    this.mask = '',
    this.maxLength,
    this.maxWidth,
    this.hint,
    this.icon,
    this.controller,
    super.key,
    this.info,
    this.bottom,
    this.isBlue = false,
    this.textColor,
    this.width,
  });

  final int minLines;
  final int? maxLength;
  final int? maxWidth;
  final bool isNumber;
  final bool isCurrency;
  final bool isBlue;
  final bool enable;
  // final bool fill;
  final Color? textColor;
  final String mask;
  final String field;
  final Widget? icon;
  final String? hint;
  final String label;
  final String? info;
  final double? height;
  final double? width;
  final double? bottom;
  final TextEditingController? controller;

  @override
  State<DataInputText> createState() => _DataInputTextState();
}

class _DataInputTextState extends State<DataInputText> {
  late final TextEditingController controller;

  late InstanceMirror instanceMirror;

  @override
  void initState() {
    if (widget.controller != null) {
      controller = widget.controller!;
    } else if (widget.isCurrency) {
      controller =
          MoneyMaskedTextController(leftSymbol: 'R\$ ', initialValue: 0);
    } else {
      if (widget.mask.isNotEmpty) {
        controller = MaskedTextController(mask: widget.mask);
      } else {
        controller = TextEditingController();
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    instanceMirror = DataForm.of(context)!.instanceMirror;
    if (widget.isCurrency) {
      (controller as MoneyMaskedTextController)
          .updateValue(instanceMirror.invokeGetter(widget.field) as double?);
    } else {
      controller.text =
          (instanceMirror.invokeGetter(widget.field) ?? '').toString();
    }

    return Padding(
      padding: EdgeInsets.only(
        right: widget.info != null ? 10 : 0,
        left: widget.info != null ? 10 : 0,
        bottom: widget.bottom ?? 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: widget.height,
            width: widget.width ?? maxWidth(context) - 20,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.isBlue
                    ? getColors(context).primaryContainer
                    : getColors(context).onPrimaryContainer,
              ),
              borderRadius: BorderRadius.circular(14),
              color: widget.isBlue
                  ? getColors(context).secondaryVariant
                  : Colors.transparent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSpace(3),
                SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      widget.label,
                      style: getStyles(context).labelMedium?.copyWith(
                            color: getColors(context).primary,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ),
                ),
                vSpace(4),
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 10),
                  child: TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(widget.maxWidth),
                    ],
                    controller: controller,
                    enabled: widget.enable,
                    onChanged: (_) => setValue(),
                    textAlignVertical:
                        ((widget.height != null && widget.height! > 40)
                            ? TextAlignVertical.top
                            : null),
                    maxLength: widget.maxLength,
                    maxLines: (widget.minLines > 1 ? widget.minLines + 10 : 1),
                    minLines: widget.minLines,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: widget.hint,
                      icon: widget.icon,
                    ),
                    style: getStyles(context).labelMedium?.copyWith(
                          color: widget.textColor ??
                              getColors(context).onBackground,
                        ),
                  ),
                ),
                vSpace(3),
              ],
            ),
          ),
          if (widget.info != null) vSpace(7),
          if (widget.info != null)
            InfoWidget(
              info: widget.info!,
              infoLines: 1,
            ),
        ],
      ),
    );
  }

  void setValue() {
    if (widget.isCurrency) {
      var newController = controller as MoneyMaskedTextController;

      instanceMirror.invokeSetter(widget.field, newController.numberValue);
    } else if (widget.mask.isNotEmpty) {
      var newController = controller as MaskedTextController;

      instanceMirror.invokeSetter(
        widget.field,
        (widget.isNumber
            ? num.tryParse(newController.unmasked)
            : newController.unmasked),
      );
    } else {
      instanceMirror.invokeSetter(
        widget.field,
        (widget.isNumber ? num.tryParse(controller.text) : controller.text),
      );
    }
  }
}

class DataInputDropDown extends StatefulWidget {
  const DataInputDropDown({
    super.key,
    required this.dropDownOptions,
    required this.label,
    required this.field,
    this.height,
    this.width,
    this.isNumber = false,
  });

  /// Options displayed on dropdown
  final Map<String, String> dropDownOptions;

  final String label;
  final String field;
  final double? height;
  final double? width;
  final bool isNumber;

  @override
  State<DataInputDropDown> createState() => _DataInputDropDownState();
}

class _DataInputDropDownState extends State<DataInputDropDown>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  final TextEditingController textController = TextEditingController();

  // late OverlayEntry dropDownOverlay;

  // LayerLink layerLink = LayerLink();

  String selectedItem = "";

  final inputKey = GlobalKey<_DataInputTextState>();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      selectedItem = widget.dropDownOptions[textController.text] ?? "";
    });
  }

  @override
  void dispose() {
    textController.dispose();
    animationController.dispose();
    super.dispose();
  }

  Future<void> animateTo(double value) async =>
      await animationController.animateTo(value,
          duration: const Duration(milliseconds: 350),
          curve: Curves.decelerate);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () {
                // dropDownOverlay = getOverlay();
                // Overlay.of(context)!.insert(dropDownOverlay);
                if (animationController.value == 0) {
                  animateTo(1.0);
                } else {
                  animateTo(0);
                }
              },
              child: DataInputText(
                key: inputKey,
                enable: false,
                label: widget.label,
                field: widget.field,
                width: widget.width,
                height: widget.height,
                isNumber: widget.isNumber,
                controller: textController,
              ),
            ),
            Positioned(
              right: /*widget.info != null ? 23 :*/ 3,
              top: 4,
              child: AnimatedBuilder(
                animation: animationController,
                child: IconButton(
                  onPressed: () {
                    // dropDownOverlay = getOverlay();
                    // Overlay.of(context)!.insert(dropDownOverlay);
                    if (animationController.value == 0) {
                      animateTo(1.0);
                    } else {
                      animateTo(0);
                    }
                  },
                  icon: Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 30,
                    color: getColors(context).primary,
                  ),
                ),
                builder: (context, child) {
                  return Transform.rotate(
                    angle: math.pi * animationController.value,
                    child: child,
                  );
                },
              ),
            ),
          ],
        ),
        SizeTransition(
          sizeFactor: animationController,
          axisAlignment: 1,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: widget.width ?? maxWidth(context) - 20,
              // padding: EdgeInsets.all(5),
              margin: const EdgeInsets.all(5),
              constraints: const BoxConstraints(
                minHeight: 60,
                maxHeight: 150,
              ),
              decoration: BoxDecoration(
                color: getColors(context).surface,
                boxShadow: [defBoxShadow(context)],
                borderRadius: BorderRadius.circular(9),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.dropDownOptions.entries
                      .map(
                        (e) => InkWell(
                          onTap: () async {
                            textController.text = e.value;
                            inputKey.currentState?.instanceMirror.invokeSetter(
                              widget.field,
                              (widget.isNumber ? num.tryParse(e.key) : e.key),
                            );
                            await animateTo(0);
                            // dropDownOverlay.remove();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 20),
                            height: 30,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              e.value,
                              style: getStyles(context)
                                  .labelMedium
                                  ?.copyWith(color: getColors(context).primary),
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
      ],
    );
  }
}

class DataInputDate extends StatefulWidget {
  const DataInputDate({
    required this.label,
    required this.field,
    this.enable = true,
    this.isNumber = false,
    this.fill = false,
    this.isCurrency = false,
    this.minLines = 1,
    this.height = 55,
    this.mask = '',
    this.maxLength,
    this.hint,
    this.controller,
    super.key,
  });

  final TextEditingController? controller;
  final bool isNumber;
  final bool isCurrency;
  final String mask;
  final bool fill;
  final String field;
  final String? hint;
  final String label;
  final int minLines;
  final int? maxLength;
  final bool enable;
  final double height;

  @override
  State<DataInputDate> createState() => _DataInputDateState();
}

class _DataInputDateState extends State<DataInputDate> {
  late final TextEditingController controller;
  @override
  void initState() {
    if (widget.isCurrency) {
      controller = MoneyMaskedTextController(leftSymbol: 'R\$ ');
    } else {
      if (widget.mask.isNotEmpty) {
        controller = MaskedTextController(mask: widget.mask);
      } else {
        controller = TextEditingController();
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InstanceMirror instanceMirror = DataForm.of(context)!.instanceMirror;
    if (widget.isCurrency) {
      (controller as MoneyMaskedTextController)
          .updateValue(instanceMirror.invokeGetter(widget.field) as double?);
    } else {
      controller.text =
          (instanceMirror.invokeGetter(widget.field) ?? '').toString();
    }

    return SizedBox(
      height: widget.height,
      width: 375,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 5,
          right: 5,
        ),
        child: Container(
          height: widget.height,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: (widget.fill
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.background),
            border: Border.all(
                color: Theme.of(context).colorScheme.primaryContainer),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 4,
                child: Text(
                  widget.label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16),
                ),
              ),
              Center(
                child: TextField(
                  controller: widget.controller,
                  enabled: widget.enable,
                  onChanged: (_) {
                    if (widget.isCurrency) {
                      // ignore: no_leading_underscores_for_local_identifiers
                      var _controller = controller as MoneyMaskedTextController;
                      instanceMirror.invokeSetter(
                          widget.field, _controller.numberValue);
                    } else if (widget.mask.isNotEmpty) {
                      var _controller = controller as MaskedTextController;

                      instanceMirror.invokeSetter(
                          widget.field,
                          (widget.isNumber
                              ? num.tryParse(_controller.unmasked)
                              : _controller.unmasked));
                    } else {
                      instanceMirror.invokeSetter(
                          widget.field,
                          (widget.isNumber
                              ? num.tryParse(controller.text)
                              : controller.text));
                    }
                  },
                  textAlignVertical:
                      (widget.height > 40 ? TextAlignVertical.top : null),
                  maxLength: widget.maxLength,
                  maxLines: (widget.minLines > 1 ? widget.minLines + 10 : 1),
                  minLines: widget.minLines,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                    labelText: '',
                    isDense: true,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: widget.hint,
                  ),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: (widget.fill
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.onBackground),
                      fontSize: 17),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
