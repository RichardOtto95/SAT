part of 'pagamento.dart';

class _PagamentoView extends WidgetView<Pagamento, _PagamentoController> {
  const _PagamentoView(_PagamentoController state) : super(state);

  @override
  Widget build(BuildContext context) {
    for (var element in Cache.pgtos!) {
      if (element.id_pg! >= state.id_pg) state.id_pg = element.id_pg! + 1;
    }
    return BaseLayout(
      title: "Pagamento",
      appBarActions: [
        IconButton(
          onPressed: state.changeView,
          icon: const Icon(Icons.payments),
        )
      ],
      body: (state._activePageIndex == 0
          ? InserirPagamento(state: state)
          : HistoricoPagamento(state: state)),
    );
  }
}

class InserirPagamento extends StatelessWidget {
  const InserirPagamento({Key? key, required this.state}) : super(key: key);
  final _PagamentoController state;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ScrollConfiguration(
            behavior: DisableScrollGlow(),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                ListaPagamentos(state: state),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Valor"),
                      SizedBox(
                        height: 40,
                        width: 180,
                        child: TextField(
                          controller: state._valor,
                          keyboardType: TextInputType.number,
                          decoration: FieldDecorator(''),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: state._tituloHeader == 'Cartão',
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Parcelas"),
                        SizedBox(
                          height: 40,
                          width: 180,
                          child: TextField(
                            controller: state._parcelas,
                            keyboardType: TextInputType.number,
                            decoration: FieldDecorator(''),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: state._tituloHeader == 'Vale Troca',
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Código de Barras"),
                        SizedBox(
                          height: 40,
                          width: 180,
                          child: TextField(
                            controller: state._codbarras,
                            keyboardType: TextInputType.number,
                            decoration: FieldDecorator(''),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: state._tituloHeader == 'Outros',
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Vencimento"),
                            SizedBox(
                              height: 40,
                              width: 180,
                              child: TextField(
                                controller: state._vencimento,
                                keyboardType: TextInputType.number,
                                decoration: FieldDecorator(''),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Autorização"),
                            SizedBox(
                              height: 40,
                              width: 180,
                              child: TextField(
                                controller: state._autorizacao,
                                keyboardType: TextInputType.number,
                                decoration: FieldDecorator(''),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Parcelas"),
                            SizedBox(
                              height: 40,
                              width: 180,
                              child: TextField(
                                controller: state._parcelas,
                                keyboardType: TextInputType.number,
                                decoration: FieldDecorator(''),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: state._tituloHeader == 'Convênio',
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("CPF/CNPJ"),
                            SizedBox(
                              height: 40,
                              width: 180,
                              child: TextField(
                                controller: state._cpfcnpj,
                                keyboardType: TextInputType.number,
                                enableSuggestions: false,
                                autocorrect: false,
                                maxLength: 18,
                                decoration: FieldDecorator(''),
                                onEditingComplete: state.verificarConveniado,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Associado"),
                            SizedBox(
                              height: 40,
                              width: 180,
                              child: TextField(
                                controller: state._associado,
                                readOnly: true,
                                decoration: FieldDecorator(''),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Disponível"),
                            SizedBox(
                              height: 40,
                              width: 180,
                              child: TextField(
                                controller: state._disponivel,
                                readOnly: true,
                                decoration: FieldDecorator(''),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Parcelas"),
                            SizedBox(
                              height: 40,
                              width: 180,
                              child: TextField(
                                controller: state._parcelas,
                                keyboardType: TextInputType.number,
                                decoration: FieldDecorator(''),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: state._tituloHeader == 'Cheque',
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Emitente"),
                            SizedBox(
                              height: 40,
                              width: 180,
                              child: TextField(
                                controller: state._emitente,
                                decoration: FieldDecorator(''),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Vencimento"),
                            SizedBox(
                              height: 40,
                              width: 180,
                              child: TextField(
                                controller: state._vencimento,
                                maxLength: 10,
                                readOnly: true,
                                onTap: () async {
                                  DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate:
                                        DateTime(DateTime.now().year - 1),
                                    lastDate: DateTime(DateTime.now().year + 1),
                                  );

                                  if (picked != null)
                                    state.setState(() => state._vencimento
                                        .text = state.df.format(picked));
                                },
                                decoration: FieldDecorator(''),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Número CH"),
                            SizedBox(
                              height: 40,
                              width: 180,
                              child: TextField(
                                controller: state._numeroCH,
                                keyboardType: TextInputType.number,
                                decoration: FieldDecorator(''),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Parcelas"),
                            SizedBox(
                              height: 40,
                              width: 180,
                              child: TextField(
                                controller: state._parcelas,
                                keyboardType: TextInputType.number,
                                decoration: FieldDecorator(''),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                CheckboxListTile(
                  title: Text(
                    'Cobrar serviço ${NumberFormat("##0.##").format(Models.param!.restaurantecomissaodogarcom)}%.',
                    style: TextStyle(fontSize: 15),
                  ),
                  value: state.usarComissao,
                  contentPadding: EdgeInsets.zero,
                  activeColor: Cores.azul,
                  onChanged: (bool? value) =>
                      state.cobrarServico(value ?? false),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Total"),
                    Text(
                      'R\$ ${NumberFormat('###0.00', 'pt_BR').format(state.total)}',
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Pago"),
                    Text(
                      'R\$ ${NumberFormat('###0.00', 'pt_BR').format(state.pago)}',
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Falta"),
                    Text(
                      'R\$ ${NumberFormat('###0.00', 'pt_BR').format((state.dif.isNegative ? 0 : state.dif))}',
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Troco"),
                    Text(
                      'R\$ ${NumberFormat('###0.00', 'pt_BR').format(state.pago > state.total ? state.dif.abs() : 0)}',
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
              ],
            ),
          ),
        ),
        Container(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RoundButton(
                  text: 'Inserir Pagamento',
                  icon: const Icon(Icons.add),
                  fontsize: 11.5,
                  width: MediaQuery.of(context).size.width * 0.45,
                  onPressed: state.inserirPagamento,
                ),
                RoundButton(
                  text: 'Finalizar',
                  icon: const Icon(Icons.done),
                  color: Cores.verde,
                  fontsize: 11.5,
                  width: MediaQuery.of(context).size.width * 0.45,
                  onPressed: state.finalizarVenda,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ListaPagamentos extends StatelessWidget {
  ListaPagamentos({
    Key? key,
    required this.state,
  }) : super(key: key);

  final _PagamentoController state;

  @override
  Widget build(BuildContext context) {
    var size = ((state._pgtoSelecionado == 'Dinheiro'
                ? state._pgtos.length
                : state._ents.length) *
            11.5) /
        100;

    return Column(
      children: [
        if (state._pgtoSelecionado != 'Dinheiro') header(),
        SizedBox(
          height: 250,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: (state._pgtoSelecionado == 'Dinheiro'
                ? state._pgtos.length
                : state._ents.length),
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 40,
                child: InkWell(
                  onTap: () => (state._pgtoSelecionado == 'Dinheiro'
                      ? state.pgtoClick(index)
                      : state.entClick(index)),
                  child: Card(
                    color: (state._pgtoSelecionado == 'Dinheiro'
                                ? state._pgtos[index]
                                : state._ents[index].entd) ==
                            state._pgtoSelecionado
                        ? Cores.azul
                        : Colors.white,
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          (state._pgtoSelecionado == 'Dinheiro'
                              ? state._pgtos[index]
                              : state._ents[index].entd),
                          style: TextStyle(
                            color: (state._pgtoSelecionado == 'Dinheiro'
                                        ? state._pgtos[index]
                                        : state._ents[index].entd) ==
                                    state._pgtoSelecionado
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  SizedBox header() {
    return SizedBox(
      height: 40,
      child: InkWell(
        onTap: () {
          state.setState(() {
            state._tituloHeader = 'Dinheiro';
            state._pgtoSelecionado = 'Dinheiro';
            state.ent = 1;
          });
        },
        child: Card(
          color: Cores.azul,
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 16,
                ),
                Text(
                  state._tituloHeader,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Oxygen',
                  ),
                ),
                const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HistoricoPagamento extends StatelessWidget {
  const HistoricoPagamento({Key? key, required this.state}) : super(key: key);
  final _PagamentoController state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        itemCount: (Cache.pgtos ?? []).length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 40,
            child: InkWell(
              onTap: () =>
                  state.deletarPgto((Cache.pgtos ?? [])[index].id_pg, index),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '#${NumberFormat('00').format((Cache.pgtos ?? [])[index].id_pg)}',
                      ),
                      Text(((Cache.pgtos ?? [])[index].ent) == 1
                          ? 'Dinheiro'
                          : Cache.ents!
                              .where((element) =>
                                  element.ent == (Cache.pgtos ?? [])[index].ent)
                              .single
                              .entd),
                      Text(
                        'R\$ ${NumberFormat('##0.00').format((Cache.pgtos ?? [])[index].valor_pg ?? 0)}',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
