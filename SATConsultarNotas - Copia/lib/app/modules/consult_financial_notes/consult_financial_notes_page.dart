import 'dart:math' as math;
import 'package:comum/utilities/custom_scroll_behavior.dart';
import 'package:comum/utilities/utilities.dart';

import 'package:comum/widgets/action_popup.dart';
import 'package:comum/widgets/custom_separator.dart';
import 'package:comum/widgets/default_app_bar.dart';
import 'package:comum/widgets/default_overlay_slider.dart';
import 'package:comum/widgets/default_text_field.dart';
import 'package:comum/widgets/default_title.dart';
import 'package:comum/widgets/filter_overlay.dart';
import 'package:comum/widgets/grid_base.dart';
import 'package:comum/widgets/info_widget.dart';
import 'package:comum/widgets/primary_button.dart';
import 'package:comum/widgets/responsive.dart';
import 'package:comum/widgets/secondary_button.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'consult_financial_notes_store.dart';

class ConsultFinancialNotesPage extends StatefulWidget {
  final String title;
  const ConsultFinancialNotesPage(
      {Key? key, this.title = 'ConsultFinancialNotesPage'})
      : super(key: key);
  @override
  ConsultFinancialNotesPageState createState() =>
      ConsultFinancialNotesPageState();
}

class ConsultFinancialNotesPageState extends State<ConsultFinancialNotesPage>
    with TickerProviderStateMixin {
  final ConsultFinancialNotesStore store = Modular.get();

  late OverlayEntry optionsSlider;

  final slideryKey = GlobalKey<DefaultOverlaySliderState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    optionsSlider = getOptionsSliderOverlay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: Column(
          children: [
            DefaultAppBar(
              title: "Notas Fiscais",
              actions: [
                IconButton(
                  onPressed: () {
                    scaffoldKey.currentState!.openEndDrawer();
                  },
                  icon: SvgPicture.asset(
                    "./assets/svg/filter_light.svg",
                    width: 22,
                  ),
                ),
                // hSpace(10),
                PopupMenuButton(
                  constraints: const BoxConstraints(maxWidth: 405),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  onSelected: (value) {
                    switch (value) {
                      case 0:
                        showDialog(
                          context: context,
                          useRootNavigator: true,
                          builder: (context) => getPrintPopup(),
                        );
                        break;
                      default:
                    }
                  },
                  itemBuilder: (context) {
                    List<Map> menuItens = [
                      {
                        "icon": "printer",
                        "title": "Imprimir Relatório",
                      },
                      {
                        "icon": "add",
                        "title": "Imprimir Relatório",
                      },
                      {
                        "icon": "nf_e",
                        "title": "Baixar NFe(s) pelo Manifesto do Destinatário",
                      },
                    ];
                    return List.generate(
                      menuItens.length,
                      (index) => PopupMenuItem<int>(
                        value: index,
                        height: 46,
                        child: Row(
                          children: [
                            Container(
                              height: 46,
                              alignment: Alignment.centerLeft,
                              child: SvgPicture.asset(
                                "./assets/svg/${menuItens[index]["icon"]}.svg",
                                width: 20,
                              ),
                            ),
                            hSpace(10),
                            Text(
                              menuItens[index]["title"],
                              style: Responsive.isDesktop(context)
                                  ? getStyles(context).displayLarge
                                  : getStyles(context).displaySmall?.copyWith(),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                // hSpace(10),
              ],
            ),
            Expanded(
              child: MyGrid(
                onSelect: (selectEvent) =>
                    Overlay.of(context)!.insert(optionsSlider),
              ),
            ),
          ],
        ),
      ),
      endDrawer: buildDrawer(),
    );
  }

  Widget buildDrawer() => FilterDrawer(
        children: [
          const DefaultTitle(
            title: "NF-e/NFC-e/MDF-e",
            fontSize: 20,
            isLeft: true,
            top: 0,
          ),
          Row(
            children: [
              const Expanded(
                child: DefaultTextField(
                  label: "Data Inicial",
                  left: 10,
                  right: 5,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "a",
                  style: getStyles(context).titleSmall,
                ),
              ),
              const Expanded(
                child: DefaultTextField(
                  label: "Data Final",
                  left: 5,
                  right: 10,
                  width: double.infinity,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                child: DefaultTextField(
                  label: "Nº NF Inicial",
                  left: 10,
                  right: 5,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "a",
                  style: getStyles(context).titleSmall,
                ),
              ),
              const Expanded(
                child: DefaultTextField(
                  label: "Nº NF Final",
                  left: 5,
                  right: 10,
                  width: double.infinity,
                ),
              ),
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: DefaultTextField(
                  label: "Série",
                  dropDown: true,
                  left: 10,
                  width: double.infinity,
                ),
              ),
              Spacer(),
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: DefaultTextField(
                  label: "Loja",
                  width: double.infinity,
                  dropDown: true,
                  left: 10,
                  right: 5,
                ),
              ),
              Expanded(
                child: DefaultTextField(
                  label: "CFOP",
                  width: double.infinity,
                  dropDown: true,
                  left: 5,
                  right: 10,
                ),
              ),
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: DefaultTextField(
                  label: "Produto",
                  width: double.infinity,
                  dropDown: true,
                  left: 10,
                  right: 5,
                ),
              ),
              Expanded(
                child: DefaultTextField(
                  label: "Forma Pgto",
                  width: double.infinity,
                  dropDown: true,
                  left: 5,
                  right: 10,
                ),
              ),
            ],
          ),
          const DefaultTextField(
            label: "Natureza",
            right: 10,
            left: 10,
          ),
          const DefaultTextField(
            label: "Chave da NF-e/NFC-e",
            right: 10,
            left: 10,
          ),
          Row(
            children: const [
              Expanded(
                child: DefaultTextField(
                  label: "Entrada/Saída",
                  width: double.infinity,
                  dropDown: true,
                  left: 10,
                  right: 5,
                ),
              ),
              Expanded(
                child: DefaultTextField(
                  label: "Modelo",
                  width: double.infinity,
                  dropDown: true,
                  left: 5,
                  right: 10,
                ),
              ),
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: DefaultTextField(
                  label: "Cancelada",
                  width: double.infinity,
                  dropDown: true,
                  left: 10,
                  right: 5,
                ),
              ),
              Expanded(
                child: DefaultTextField(
                  label: "Autorizada",
                  width: double.infinity,
                  dropDown: true,
                  left: 5,
                  right: 10,
                ),
              ),
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: DefaultTextField(
                  label: "Contingência",
                  width: double.infinity,
                  dropDown: true,
                  left: 10,
                  right: 5,
                ),
              ),
              Expanded(
                child: DefaultTextField(
                  label: "Denegada",
                  width: double.infinity,
                  dropDown: true,
                  left: 5,
                  right: 10,
                ),
              ),
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: DefaultTextField(
                  label: "Ambiente",
                  width: double.infinity,
                  dropDown: true,
                  left: 10,
                  right: 5,
                ),
              ),
              Expanded(
                child: DefaultTextField(
                  label: "Manifestação",
                  width: double.infinity,
                  dropDown: true,
                  left: 5,
                  right: 10,
                ),
              ),
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: DefaultTextField(
                  label: "Manifesto",
                  width: double.infinity,
                  dropDown: true,
                  left: 10,
                  right: 5,
                  bottom: 5,
                ),
              ),
              Expanded(
                child: DefaultTextField(
                  label: "MDF-e Encerrado",
                  width: double.infinity,
                  dropDown: true,
                  left: 5,
                  right: 10,
                  bottom: 5,
                ),
              ),
            ],
          ),
          const InfoWidget(
            info: "ATENÇÃO! Caso tenha que colocar mais de "
                "uma chave de Nota Fiscal, utiliza a virgula "
                "para separar cada uma delas.",
            padding: EdgeInsets.only(right: 10, left: 10),
          ),
          const DefaultTitle(
            title: "Emitente",
            fontSize: 20,
            isLeft: true,
            top: 15,
          ),
          Row(
            children: const [
              Expanded(
                child: DefaultTextField(
                  label: "Loja",
                  width: double.infinity,
                  dropDown: true,
                  left: 10,
                  right: 5,
                  bottom: 5,
                ),
              ),
              Expanded(
                child: DefaultTextField(
                  label: "Fornecedor",
                  width: double.infinity,
                  dropDown: true,
                  left: 5,
                  right: 10,
                  bottom: 5,
                ),
              ),
            ],
          ),
          const DefaultTextField(
            label: "CNPJ",
            right: 10,
            left: 10,
          ),
          const DefaultTextField(
            label: "Razão Social",
            right: 10,
            left: 10,
          ),
          const DefaultTitle(
            title: "Destinatário",
            fontSize: 20,
            isLeft: true,
          ),
          const DefaultTextField(
            label: "Loja",
            dropDown: true,
            right: 10,
            left: 10,
          ),
          const DefaultTextField(
            label: "Fornecedor",
            dropDown: true,
            right: 10,
            left: 10,
          ),
          const DefaultTextField(
            label: "Cliente",
            dropDown: true,
            right: 10,
            left: 10,
          ),
          vSpace(30),
          PrimaryButton(
            label: "Consultar Notas",
            width: 220,
            onTap: () {
              scaffoldKey.currentState!.closeEndDrawer();
            },
          ),
        ],
      );

  Widget getPrintPopup() => ActionPopup(
        onCancel: () => Modular.to.pop(),
        onConfirm: () => Modular.to.pop(),
        children: const [
          DefaultTitle(
            title: "Imprimir Relatório",
            fontSize: 25,
            top: 20,
            bottom: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: DefaultTextField(
              label: "Relatórios",
              dropDown: true,
              width: double.infinity,
              bottom: 20,
            ),
          ),
        ],
      );

  OverlayEntry getOptionsSliderOverlay() {
    Future<void> removeSlider() async {
      await slideryKey.currentState!.animateTo(0);
      optionsSlider.remove();
    }

    return OverlayEntry(
      builder: (context) => DefaultOverlaySlider(
        key: slideryKey,
        height: maxHeight(context) - 100,
        onBack: () {
          optionsSlider.remove();
        },
        child: Column(
          children: [
            const DefaultTitle(
              title: "Nota 11414293",
              top: 20,
              bottom: 20,
            ),
            ExpandItem(
              icon: "nf_e",
              title: "Relatórios demonstrativos",
              children: [
                SecondaryButton(
                  label: "Pela Chave de Acesso",
                  icon: "nf_e",
                  onTap: removeSlider,
                  width: wXD(332, context),
                ),
                SecondaryButton(
                  label: "Pelo Navegador",
                  icon: "nf_e",
                  onTap: removeSlider,
                  width: wXD(332, context),
                ),
                SecondaryButton(
                  label: "Sincronia NFC-e",
                  icon: "nf_e",
                  onTap: removeSlider,
                  width: wXD(332, context),
                ),
              ],
            ),
            ExpandItem(
              icon: "nf_e",
              title: "Inutilizar",
              children: [
                SecondaryButton(
                  label: "NF-e",
                  icon: "nf_e",
                  onTap: removeSlider,
                  width: wXD(332, context),
                ),
                SecondaryButton(
                  label: "NFC-e",
                  icon: "nf_e",
                  onTap: removeSlider,
                  width: wXD(332, context),
                ),
                const InfoWidget(
                  info: "* ATENÇÃO! Requer conhecimento técnico",
                ),
              ],
            ),
            ExpandItem(
              icon: "export",
              title: "Carta de Correção",
              children: [
                SecondaryButton(
                  label: "Nova Carta",
                  icon: "export",
                  onTap: removeSlider,
                  width: wXD(332, context),
                ),
                SecondaryButton(
                  label: "Reiprimir Carta",
                  icon: "printer",
                  onTap: removeSlider,
                  width: wXD(332, context),
                ),
              ],
            ),
            ExpandItem(
              icon: "nf_e",
              title: "Conferir Numeração",
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: DefaultTextField(
                        label: "Nº da NF inicial",
                        width: double.infinity,
                        left: 10,
                      ),
                    ),
                    hSpace(5),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "a",
                        style: getStyles(context).titleSmall,
                      ),
                    ),
                    hSpace(5),
                    const Expanded(
                      child: DefaultTextField(
                        label: "Nº da NF final",
                        width: double.infinity,
                        right: 10,
                      ),
                    ),
                  ],
                ),
                SecondaryButton(
                  label: "Verificar Numeração",
                  icon: "nf_e",
                  onTap: removeSlider,
                  width: wXD(332, context),
                ),
                SecondaryButton(
                  label: "Reiprimir Carta",
                  icon: "nf_e",
                  onTap: removeSlider,
                  width: wXD(332, context),
                ),
              ],
            ),
            ExpandItem(
              title: "Manifesto do Destinatário",
              icon: "edit",
              children: [
                SecondaryButton(
                  label: "Aterar Situação",
                  icon: "edit",
                  onTap: removeSlider,
                  width: wXD(332, context),
                ),
                SecondaryButton(
                  label: "Alterar Tipo de ítens",
                  icon: "edit",
                  onTap: removeSlider,
                  width: wXD(332, context),
                ),
                SecondaryButton(
                  label: "Download do XML",
                  icon: "nf_e",
                  onTap: removeSlider,
                  width: wXD(332, context),
                  bottom: 0,
                ),
              ],
            ),
            vSpace(10),
            CustomSeparator(width: maxWidth(context) - 20),
            SecondaryButton(
              label: "Editar",
              icon: "edit_orange",
              onTap: removeSlider,
              width: wXD(332, context),
            ),
            SecondaryButton(
              label: "Cancelar",
              icon: "nf_e_cancel",
              onTap: removeSlider,
              width: wXD(332, context),
            ),
            SecondaryButton(
              label: "Reimprimir",
              icon: "nf_e_reprint",
              onTap: removeSlider,
              width: wXD(332, context),
            ),
            SecondaryButton(
              label: "Visualizar NFC-e",
              icon: "nf_e",
              onTap: removeSlider,
              width: wXD(332, context),
            ),
            SecondaryButton(
              label: "Envair por E-mail",
              icon: "email",
              onTap: removeSlider,
              width: wXD(332, context),
            ),
            SecondaryButton(
              label: "Exportar XML's",
              icon: "save",
              onTap: removeSlider,
              width: wXD(332, context),
            ),
            SecondaryButton(
              label: "Visualizar XML",
              icon: "nf_e",
              onTap: () async {
                await removeSlider();
                Modular.to.pushNamed("/consult-fiscal-notes/xml");
              },
              width: wXD(332, context),
            ),
            SecondaryButton(
              label: "Encerrar MDF-e",
              icon: "nf_e_cancel",
              onTap: removeSlider,
              width: wXD(332, context),
            ),
            SecondaryButton(
              label: "Dados do Destinatário ",
              icon: "nf_e",
              onTap: () async {
                await removeSlider();
                Modular.to.pushNamed("/consult-fiscal-notes/receiver");
              },
              width: wXD(332, context),
            ),
          ],
        ),
      ),
    );
  }
}

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
