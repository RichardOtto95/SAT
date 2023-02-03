part of 'login.dart';

class _LoginView extends WidgetView<Login, _LoginController> {
  _LoginView(_LoginController state) : super(state);

  final senhaFoco = FocusNode();

  final dbFoco = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ScrollConfiguration(
        behavior: DisableScrollGlow(),
        child: SingleChildScrollView(
          reverse: true,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                width: MediaQuery.of(context).size.width,
                height: 500,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Cores.azul, Color(0xFFFAFAFA)],
                    stops: [0, 1],
                    begin: Alignment(0, -1),
                    end: Alignment(0, 1),
                  ),
                  shape: BoxShape.rectangle,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  15,
                  (MediaQuery.of(context).orientation == Orientation.landscape
                      ? 20
                      : 50),
                  15,
                  0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      versaoSAT,
                      style: getStyles(context).labelSmall?.copyWith(
                            color: getColors(context).onPrimary,
                          ),
                    ),
                    InkWell(
                      onTap: state.configClick,
                      child: Text(
                        "Configuração",
                        textAlign: TextAlign.end,
                        style: getStyles(context).labelMedium?.copyWith(
                              color: getColors(context).onPrimary,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/logo.svg',
                      height: 150,
                    ),
                    vSpace(10),
                    Text(
                      appName,
                      style: getStyles(context).titleMedium?.copyWith(
                            color: getColors(context).onPrimary,
                          ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Form(
                        key: state._formKey,
                        child: Container(
                          padding: const EdgeInsets.only(top: 40),
                          width: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                controller: state.matrController,
                                onChanged: state.textFieldOnChange,
                                decoration: FieldDecorator('Matrícula'),
                                validator: Validators.validarCampoVazio,
                                autofocus: true,
                                onEditingComplete: () =>
                                    senhaFoco.requestFocus(),
                              ),
                              const Divider(
                                color: Colors.transparent,
                              ),
                              TextFormField(
                                controller: state.passwdController,
                                onChanged: state.senhaFieldOnChange,
                                onEditingComplete: () => dbFoco.requestFocus(),
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: FieldDecorator('Senha'),
                                validator: Validators.validarCampoVazio,
                                focusNode: senhaFoco,
                              ),
                              const Divider(
                                color: Colors.transparent,
                              ),
                              TextFormField(
                                controller: state.empresaController,
                                onChanged: state.textFieldOnChange,
                                decoration: FieldDecorator('Banco de Dados'),
                                validator: Validators.validarCampoVazio,
                                focusNode: dbFoco,
                                onEditingComplete: state.loginClick,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SwitchListTile(
                                    value: state.switchSenha,
                                    onChanged: state.switchSenhaOnChanged,
                                    title: const Text('Salvar login'),
                                    activeColor: Cores.azul,
                                    hoverColor: Colors.transparent,
                                    dense: true,
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: ElevatedButton(
                                      onPressed: state.loginClick,
                                      style: ElevatedButton.styleFrom(
                                        primary: getColors(context).primary,
                                        shape: const StadiumBorder(),
                                      ),
                                      child: const Text("Login"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
