part of 'clientes.dart';

class _ClientesView extends WidgetView<Clientes, _ClientesController> {
  const _ClientesView(_ClientesController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      resizeToAvoidBottom: true,
      title: 'Cliente',
      titleSize: MediaQuery.of(context).size.height * 0.025,
      body: Form(
        key: state._formKey,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal:
                (MediaQuery.of(context).orientation == Orientation.landscape
                    ? 100
                    : 25),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                autofocus: (widget.cliente == null ? true : false),
                controller: state._cpfcontroller,
                readOnly: (widget.cliente == null),
                enableSuggestions: false,
                autocorrect: false,
                maxLength: 18,
                keyboardType: TextInputType.number,
                decoration: FieldDecorator('CPF/CNPJ'),
                validator: (state._cpfcontroller.unmasked.length <= 11
                    ? Validators.validarCPFnotRequired
                    : Validators.validarCNPJnotRequired),
              ),
              Visibility(
                visible: (widget.cliente != null),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextFormField(
                    autofocus: (widget.cliente == null ? false : true),
                    focusNode: state._focusnode,
                    controller: state._nomecontroller,
                    enableSuggestions: false,
                    autocorrect: false,
                    maxLength: 50,
                    keyboardType: TextInputType.name,
                    decoration: FieldDecorator('Nome / Razão Social'),
                    validator: Validators.validarCampoVazio,
                  ),
                ),
              ),
              Visibility(
                visible: (widget.cliente != null),
                child: Container(
                  child: TextFormField(
                    controller: state._nomefancontroller,
                    enableSuggestions: false,
                    autocorrect: false,
                    maxLength: 50,
                    keyboardType: TextInputType.name,
                    decoration: FieldDecorator('Nome Fantasia'),
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Wrap(
                  direction: (MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? Axis.horizontal
                      : Axis.vertical),
                  spacing: 10,
                  children: [
                    RoundButton(
                      text: 'Editar',
                      width: 150,
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        if ((state.cliwrap.cli == null &&
                                widget.mesa.codcli == null) ||
                            (widget.cliente != null &&
                                widget.cliente!.codcli == 1)) {
                          EasyLoading.showError('Selecione um usuário válido.',
                              dismissOnTap: true);
                          return;
                        }

                        if (state.cliwrap.cli == null) {
                          await WebService.consultar<Cli>(
                                  'clientes/${widget.mesa.codcli}')
                              .then(
                                  (value) => state.cliwrap.cli = value.single);
                          ;
                        }

                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CliEdit(
                              cliente: state.cliwrap,
                            ),
                          ),
                        );
                        state.updateValores();
                      },
                    ),
                    RoundButton(
                      text: 'Buscar',
                      width: 150,
                      icon: const Icon(Icons.search),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClientesBusca(
                              cliente: state.cliwrap,
                            ),
                          ),
                        );
                        if (state.cliwrap.cli != null) {
                          state.updateValores();
                        }
                      },
                    ),
                    RoundButton(
                      text: 'Salvar',
                      width: 150,
                      icon: const Icon(Icons.done),
                      onPressed: state.updateCPF,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
