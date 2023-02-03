import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sat_fornecedores/app/shared/utilities.dart';
import 'package:sat_fornecedores/app/shared/widgets/custom_check.dart';

import '../../../shared/widgets/custom_floating_button.dart';

class CreateSupplier extends StatefulWidget {
  final bool visualization;
  const CreateSupplier({Key? key, this.visualization = false})
      : super(key: key);

  @override
  State<CreateSupplier> createState() => _CreateSuppliersStat();
}

class _CreateSuppliersStat extends State<CreateSupplier> {
  final ScrollController controller = ScrollController();

  bool editing = false;

  bool showFloatingButton = true;

  @override
  initState() {
    editing = !widget.visualization;
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
    return Listener(
      onPointerDown: (_) => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.visualization ? "Dados do Fornecedor" : "Criar fornecedor",
            style: getStyles(context).titleMedium,
          ),
          actions: [
            if (widget.visualization)
              IconButton(
                onPressed: () {
                  setState(() {
                    editing = !editing;
                  });
                },
                icon: Icon(
                  !editing ? Icons.edit_off_rounded : Icons.edit,
                ),
              ),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: controller,
              padding: EdgeInsets.symmetric(vertical: wXD(25, context)),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DataTile(
                    title: "Código",
                    hint: "001",
                    enable: editing,
                  ),
                  DataTile(
                    title: "Nome fantasia",
                    hint: "Nome fantasia",
                    enable: editing,
                  ),
                  DataTile(
                    title: "Razão social",
                    hint: "Razão social",
                    enable: editing,
                  ),
                  DataTile(
                    title: "Email",
                    hint: "email@email.com",
                    enable: editing,
                  ),
                  DataTile(
                    title: "Site",
                    hint: "https://www.site.com",
                    enable: editing,
                  ),
                  DataTile(
                    title: "CPF/CNPJ",
                    hint: "99.999.999/9999-99",
                    enable: editing,
                  ),
                  DataTile(
                    title: "NIRE",
                    hint: "NIRE",
                    enable: editing,
                  ),
                  DataTile(
                    title: "R.G./I.E.",
                    hint: "R.G./I.E.",
                    enable: editing,
                  ),
                  DataTile(
                    title: "Inscrição municipal",
                    hint: "ssp/to",
                    enable: editing,
                  ),
                  DataTile(
                    title: "Contato",
                    hint: "Fulano cliclano",
                    enable: editing,
                  ),
                  DataTile(
                    title: "Telefone de contato",
                    hint: "(61) 9999-9999",
                    enable: editing,
                  ),
                  DataTile(
                    title: "Celular de contato",
                    hint: "(61) 99999-9999",
                    enable: editing,
                  ),
                  DataTile(
                    title: "Representante",
                    hint: "Ciclano fulano",
                    enable: editing,
                  ),
                  DataTile(
                    title: "Telefone do representante",
                    hint: "(61) 9999-9999",
                    enable: editing,
                  ),
                  DataTile(
                    title: "Celular do representante",
                    hint: "(61) 99999-9999",
                    enable: editing,
                  ),
                  DataTile(
                    title: "Indicador de IE",
                    hint: "Selecionar",
                    type: "DROPDOWN_MENU",
                    enable: editing,
                  ),
                  vSpace(wXD(5, context)),
                  CustomCheck(
                    title:
                        "Saiu de linha - Marque essa opção para não exibir esse fornecedor nas listagens.",
                    textWidth: wXD(350, context),
                    checked: true,
                  ),
                  vSpace(wXD(30, context)),
                  Text("Endereço", style: getStyles(context).titleLarge),
                  vSpace(wXD(25, context)),
                  DataTile(
                    title: "Endereço",
                    hint: "Cidade tal, bairro tal, rua tal, número tal - DF",
                    enable: editing,
                  ),
                  DataTile(
                    title: "Complemento",
                    hint: "Complemento",
                    enable: editing,
                  ),
                  DataTile(
                    title: "País",
                    hint: "Brasil",
                    enable: editing,
                  ),
                  DataTile(
                    title: "CEP",
                    hint: "00.000-000",
                    enable: editing,
                  ),
                  DataTile(
                    title: "Estado",
                    hint: "Estado - ES",
                    enable: editing,
                  ),
                  DataTile(
                    title: "Cidade",
                    hint: "Cidade",
                    enable: editing,
                  ),
                  DataTile(
                    title: "Bairro",
                    hint: "Bairro",
                    enable: editing,
                  ),
                  DataTile(
                    title: "Código do município (IBGE)",
                    hint: "123416",
                    enable: editing,
                  ),
                  DataTile(
                    title: "Código do país (BACEN)",
                    hint: "001",
                    enable: editing,
                  ),
                  vSpace(wXD(5, context)),
                  CustomCheck(
                    title: "Possui transportadora.",
                    textWidth: wXD(350, context),
                    checked: true,
                  ),
                  vSpace(wXD(25, context)),
                  DataTile(
                    title: "Nome da transportadora",
                    hint: "Nome da transportadora",
                    enable: editing,
                  ),
                ],
              ),
            ),
            if (widget.visualization)
              AnimatedPositioned(
                right:
                    showFloatingButton ? wXD(20, context) : -wXD(60, context),
                bottom: wXD(70, context),
                duration: const Duration(milliseconds: 300),
                child: CustomFloatButton(
                  icon: editing ? Icons.check_rounded : Icons.edit,
                  onTap: () => setState(() => editing = !editing),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class DataTile extends StatelessWidget {
  final String title;
  final String hint;
  final String? value;
  final String type;
  final bool enable;

  const DataTile({
    Key? key,
    required this.title,
    required this.hint,
    this.enable = true,
    this.type = "TEXT_FIELD",
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wXD(428, context),
      margin: EdgeInsets.only(
          right: wXD(20, context),
          left: wXD(20, context),
          bottom: wXD(15, context)),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: getColors(context).onSurface)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: getStyles(context)
                .titleSmall
                ?.copyWith(color: getColors(context).primary),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: wXD(10, context),
                top: wXD(3, context),
                bottom: wXD(5, context)),
            child: Row(
              children: [
                Flexible(
                  child: TextFormField(
                    enabled: enable && type == "TEXT_FIELD",
                    onTap: () {
                      if (type == "DROPDOWN_MENU") {
                        print("é DROPDOWN_MENU");
                      }
                    },
                    initialValue: value,
                    style: getStyles(context).displayMedium,
                    decoration: InputDecoration.collapsed(
                      hintText: hint,
                      hintStyle: getStyles(context).displayMedium?.copyWith(
                            color: getColors(context).onSurface,
                          ),
                    ),
                  ),
                ),
                if (type == "DROPDOWN_MENU")
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: getColors(context).primary,
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
