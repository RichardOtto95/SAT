// ignore_for_file: invalid_use_of_protected_member

part of 'cli_edit.dart';

class _CliEditView extends WidgetView<CliEdit, _CliEditController> {
  const _CliEditView(_CliEditController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      resizeToAvoidBottom: true,
      title: 'Editar Cliente',
      titleSize: MediaQuery.of(context).size.height * 0.025,
      body: SingleChildScrollView(
        child: _formDados(context),
      ),
      rodape: Container(
        height: (kIsWeb ? 45 : (Platform.isIOS ? 60 : 45)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: (kIsWeb
              ? const EdgeInsets.symmetric(horizontal: 10)
              : (Platform.isIOS
                  ? const EdgeInsets.fromLTRB(10, 0, 10, 10)
                  : const EdgeInsets.symmetric(horizontal: 10))),
          child: Row(
            mainAxisAlignment: (kIsWeb
                ? MainAxisAlignment.center
                : Platform.isWindows
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween),
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundButton(
                text: 'Salvar',
                icon: const Icon(Icons.save),
                fontsize: 12,
                width: MediaQuery.of(context).size.width * 0.45,
                onPressed: state.saveClick,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Form _formDados(BuildContext context) {
    return Form(
      key: state._formKey,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            TextFormField(
              controller: state.controllers[CliController.CPF],
              enableSuggestions: false,
              autocorrect: false,
              maxLength: 18,
              keyboardType: TextInputType.number,
              decoration: FieldDecorator('CPF/CNPJ'),
              validator:
                  (state.controllers[CliController.CPF].unmasked.length <= 11
                      ? Validators.validarCPFnotRequired
                      : Validators.validarCNPJnotRequired),
            ),
            TextFormField(
              controller: state.controllers[CliController.Nome],
              enableSuggestions: false,
              autocorrect: false,
              maxLength: 50,
              keyboardType: TextInputType.name,
              decoration: FieldDecorator('Nome / Razão Social'),
              validator: Validators.validarCampoVazio,
            ),
            TextFormField(
              controller: state.controllers[CliController.NomeFantasia],
              enableSuggestions: false,
              autocorrect: false,
              maxLength: 50,
              keyboardType: TextInputType.name,
              decoration: FieldDecorator('Nome Fantasia'),
              validator: Validators.validarCampoVazio,
            ),
            TextFormField(
              controller: state.controllers[CliController.CEP],
              enableSuggestions: false,
              autocorrect: false,
              maxLength: 50,
              keyboardType: TextInputType.name,
              decoration: FieldDecorator('CEP'),
              validator: Validators.validarCampoVazio,
            ),
            TextFormField(
              controller: state.controllers[CliController.Endereco],
              enableSuggestions: false,
              autocorrect: false,
              maxLength: 50,
              keyboardType: TextInputType.name,
              decoration: FieldDecorator('Endereço'),
              validator: Validators.validarCampoVazio,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: TextFormField(
                      controller: state.controllers[CliController.Bairro],
                      enableSuggestions: false,
                      autocorrect: false,
                      maxLength: 50,
                      keyboardType: TextInputType.name,
                      decoration: FieldDecorator('Bairro'),
                      validator: Validators.validarCampoVazio,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: TextFormField(
                      controller: state.controllers[CliController.Cidade],
                      enableSuggestions: false,
                      autocorrect: false,
                      maxLength: 50,
                      keyboardType: TextInputType.name,
                      decoration: FieldDecorator('Cidade'),
                      validator: Validators.validarCampoVazio,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: TextFormField(
                      controller: state.controllers[CliController.Estado],
                      enableSuggestions: false,
                      autocorrect: false,
                      maxLength: 50,
                      keyboardType: TextInputType.name,
                      decoration: FieldDecorator('Estado'),
                      validator: Validators.validarCampoVazio,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: TextFormField(
                      controller: state.controllers[CliController.IBGE],
                      enableSuggestions: false,
                      autocorrect: false,
                      maxLength: 50,
                      keyboardType: TextInputType.name,
                      decoration: FieldDecorator('IBGE Código'),
                      validator: Validators.validarCampoVazio,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: TextFormField(
                      controller: state.controllers[CliController.Telefone],
                      enableSuggestions: false,
                      autocorrect: false,
                      maxLength: 50,
                      keyboardType: TextInputType.name,
                      decoration: FieldDecorator('Telefone'),
                      validator: Validators.validarCampoVazio,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: TextFormField(
                      controller: state.controllers[CliController.Email],
                      enableSuggestions: false,
                      autocorrect: false,
                      maxLength: 50,
                      keyboardType: TextInputType.name,
                      decoration: FieldDecorator('Email'),
                      validator: Validators.validarCampoVazio,
                    ),
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: state.controllers[CliController.INS],
              enableSuggestions: false,
              autocorrect: false,
              maxLength: 50,
              keyboardType: TextInputType.name,
              decoration: FieldDecorator('INS / RG'),
              validator: Validators.validarCampoVazio,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(right: 5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      color: Colors.white,
                    ),
                    child: DropdownButtonFormField<int>(
                        value: state.indIE,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                        onChanged: (int? newValue) {
                          state.setState(() {
                            state._cli!.indicadorIEDestinatario =
                                state.indIE = newValue!;
                          });
                        },
                        decoration: FieldDecorator('Indicador I.E.'),
                        items: <int>[for (var i = 0; i < 3; i++) i]
                            .map<DropdownMenuItem<int>>((e) {
                          return DropdownMenuItem<int>(
                            value: e,
                            child: Text(state.indIEItems[e]),
                          );
                        }).toList()),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(right: 5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      color: Colors.white,
                    ),
                    child: DropdownButtonFormField<int>(
                        value: state.indCon,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                        onChanged: (int? newValue) {
                          state.setState(() {
                            state._cli!.indFinal = state.indCon = newValue!;
                          });
                        },
                        decoration: FieldDecorator('Ind. Consumidor Final'),
                        items: <int>[for (var i = 0; i < 2; i++) i]
                            .map<DropdownMenuItem<int>>((e) {
                          return DropdownMenuItem<int>(
                            value: e,
                            child: Text(state.indConItems[e]),
                          );
                        }).toList()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
