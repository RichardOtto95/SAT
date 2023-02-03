import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sat_fornecedores/app/constants/properties.dart';
import 'package:sat_fornecedores/app/modules/suppliers/suppliers_store.dart';
import 'package:flutter/material.dart';
import 'package:sat_fornecedores/app/shared/utilities.dart';
import 'package:sat_fornecedores/app/shared/widgets/confirm_popup.dart';
import 'package:sat_fornecedores/app/shared/widgets/custom_floating_button.dart';
import 'package:sat_fornecedores/app/shared/widgets/primary_button.dart';

import '../../shared/widgets/custom_check.dart';

class SuppliersPage extends StatefulWidget {
  final String title;
  const SuppliersPage({Key? key, this.title = 'Fornecedores'})
      : super(key: key);
  @override
  SuppliersPageState createState() => SuppliersPageState();
}

class SuppliersPageState extends State<SuppliersPage> {
  final SuppliersStore store = Modular.get();

  final ScrollController controller = ScrollController();

  OverlayEntry? filterOverlay;

  bool showFloatingButton = true;

  @override
  initState() {
    addScrollListener();
    super.initState();
  }

  addScrollListener() {
    controller.addListener(() {
      if (controller.position.userScrollDirection == ScrollDirection.forward &&
          !showFloatingButton) {
        // print("Scroll Forward");
        showFloatingButton = true;
        setState(() {});
      } else if (controller.position.userScrollDirection ==
              ScrollDirection.reverse &&
          showFloatingButton) {
        showFloatingButton = false;
        setState(() {});
        // print("Scroll Reverse");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (filterOverlay != null) {
          filterOverlay!.remove();
          filterOverlay = null;
          return false;
        }
        return false;
      },
      child: Listener(
        onPointerDown: (_) => store.removeSupplierOverlay(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.title,
              style: getStyles(context).titleMedium,
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.filter_alt_outlined,
                  size: wXD(30, context),
                ),
                onPressed: () {
                  filterOverlay = OverlayEntry(
                    builder: (context) => FilterOverlay(
                      onBack: () {
                        filterOverlay!.remove();
                        filterOverlay = null;
                      },
                    ),
                  );
                  Overlay.of(context)!.insert(filterOverlay!);
                },
              )
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                controller: controller,
                padding: EdgeInsets.symmetric(vertical: wXD(25, context)),
                child: Column(
                  children: <Widget>[
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                    SupplierTile(),
                  ],
                ),
              ),
              AnimatedPositioned(
                right:
                    showFloatingButton ? wXD(20, context) : -wXD(60, context),
                bottom: wXD(70, context),
                duration: const Duration(milliseconds: 300),
                child: CustomFloatButton(
                  icon: Icons.add_rounded,
                  onTap: () => Modular.to.pushNamed(
                      "/suppliers/create-supplier",
                      arguments: false),
                ),
              )
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   child: Icon(
          //     Icons.add_rounded,
          //     color: getColors(context).primary,
          //     size: wXD(35, context),
          //   ),
          //   onPressed: () => Modular.to.pushNamed("/suppliers/create-supplier"),
          // ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      ),
    );
  }
}

class SupplierTile extends StatelessWidget {
  SupplierTile({Key? key}) : super(key: key);

  final SuppliersStore store = Modular.get();

  final _layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomCard(
        // height: wXD(85, context),
        width: wXD(374, context),
        padding: EdgeInsets.only(
          bottom: wXD(10, context),
          top: wXD(10, context),
          left: wXD(12, context),
        ),
        margin: EdgeInsets.only(bottom: wXD(15, context)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "005 - Evandro sales",
                    style: getStyles(context).titleSmall,
                  ),
                  vSpace(wXD(2, context)),
                  Padding(
                    padding: EdgeInsets.only(left: wXD(8, context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "satsistemas@gmail.com",
                          style: TextStyle(fontSize: 14),
                        ),
                        vSpace(wXD(1, context)),
                        const Text(
                          "02.882.886/101",
                          style: TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Material(
              color: Colors.transparent,
              child: CompositedTransformTarget(
                link: _layerLink,
                child: IconButton(
                  onPressed: () {
                    store.insertSupplierOverlay(context, getSupplierOverlay());
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: getColors(context).primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OverlayEntry getSupplierOverlay() {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: wXD(150, context),
        height: wXD(72, context),
        child: CompositedTransformFollower(
          offset: Offset(-100, 20),
          link: _layerLink,
          child: Material(
            color: Colors.transparent,
            child: CustomCard(
              width: wXD(146, context),
              height: wXD(72, context),
              padding: EdgeInsets.symmetric(
                horizontal: wXD(8, context),
                vertical: wXD(5, context),
              ),
              radius: 9,
              child: Column(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Modular.to.pushNamed(
                          "/suppliers/create-supplier",
                          arguments: true,
                        );
                        store.removeSupplierOverlay();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye_outlined,
                            size: wXD(25, context),
                            color: getColors(context).primary,
                          ),
                          hSpace(wXD(7, context)),
                          const Text(
                            "Visualizar",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        store.removeSupplierOverlay();
                        store.insertSupplierOverlay(
                          context,
                          OverlayEntry(
                            builder: (context) => ConfirmPopup(
                              onBack: () {
                                store.removeSupplierOverlay();
                              },
                              onConfirm: () {
                                store.removeSupplierOverlay();
                              },
                              text:
                                  "Tem certeza que deseja excluir este fornecedor?",
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline,
                            size: wXD(25, context),
                            color: getColors(context).primary,
                          ),
                          hSpace(wXD(7, context)),
                          const Text(
                            "Excluir",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final Widget? child;

  const CustomCard({
    Key? key,
    this.height,
    this.width,
    this.radius,
    this.padding,
    this.margin,
    this.alignment,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: radius != null
            ? BorderRadius.circular(radius!)
            : defBorderRadius(context),
        color: getColors(context).surface,
        border: Border.all(color: Color(0xffd9d9d9)),
        boxShadow: [defBoxShadow(context)],
      ),
      alignment: alignment,
      child: child,
    );
  }
}

class FilterOverlay extends StatefulWidget {
  final void Function() onBack;
  const FilterOverlay({Key? key, required this.onBack}) : super(key: key);

  @override
  State<FilterOverlay> createState() => _FilterOverlayState();
}

class _FilterOverlayState extends State<FilterOverlay>
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
    super.dispose();
    _controller.dispose();
  }

  Future animateTo(double value) async => await _controller.animateTo(value,
      duration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          double value = _controller.value;
          return Stack(
            children: [
              GestureDetector(
                onTap: () async {
                  await animateTo(0);
                  widget.onBack();
                },
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: (value * 2) + 0.001,
                    sigmaY: (value * 2) + 0.001,
                  ),
                  child: Container(
                    height: maxHeight(context),
                    width: maxWidth(context),
                    color: getColors(context).shadow.withOpacity(value * .3),
                  ),
                ),
              ),
              Positioned(
                left: maxWidth(context) - (value * wXD(321, context)),
                top: viewPaddingTop(context),
                child: Container(
                  height: maxHeight(context) - viewPaddingTop(context),
                  width: wXD(321, context),
                  decoration: BoxDecoration(
                    color: getColors(context).surface,
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(19)),
                  ),
                  child: Column(
                    children: [
                      vSpace(wXD(40, context)),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(bottom: wXD(15, context)),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: getColors(context).onSurface,
                            ),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Filtros",
                          style: getStyles(context).titleMedium?.copyWith(
                                color: getColors(context).primary,
                              ),
                        ),
                      ),
                      vSpace(wXD(30, context)),
                      filterField("Código:"),
                      filterField("CNPJ:"),
                      filterField("Nome Fantasia:"),
                      filterField("Razão Social:"),
                      const CustomCheck(
                        title: "Ativos",
                        checked: true,
                        isRight: true,
                      ),
                      const CustomCheck(
                        title: "Inativos",
                        checked: false,
                        isRight: true,
                      ),
                      const CustomCheck(
                        title: "Todos",
                        checked: false,
                        isRight: true,
                      ),
                      Spacer(),
                      PrimaryButton(
                        title: "Filtrar",
                        onTap: () async {
                          await animateTo(0);
                          widget.onBack();
                        },
                      ),
                      vSpace(wXD(110, context)),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget filterField(String title) => Padding(
        padding: EdgeInsets.only(
          left: wXD(20, context),
          right: wXD(20, context),
          bottom: wXD(10, context),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                style: getStyles(context).titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: getColors(context).onSurfaceVariant,
                    ),
              ),
            ),
            ContainerTextField(),
          ],
        ),
      );
}

class ContainerTextField extends StatelessWidget {
  final double? height;
  final double? width;
  final String? hint;
  final String? initialValue;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final void Function(String)? onChanged;

  const ContainerTextField({
    Key? key,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.hint,
    this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? wXD(55, context),
      width: width ?? wXD(172, context),
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: wXD(10, context),
            vertical: wXD(8, context),
          ),
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: getColors(context).onSurface.withOpacity(.2),
        border: Border.all(color: getColors(context).onSurface),
      ),
      alignment: Alignment.centerLeft,
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        scrollPadding: EdgeInsets.zero,
        style: Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(
              color: getColors(context).onSurfaceVariant,
            ),
        decoration: InputDecoration(
          hintText: hint ?? "hint",
        ),
      ),
    );
  }
}
