part of 'produtos_insert.dart';

class _ProdutosInsertView
    extends WidgetView<ProdutosInsert, _ProdutosInsertController> {
  const _ProdutosInsertView(_ProdutosInsertController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      resizeToAvoidBottom: true,
      title: "Inserir Produto",
      appBarActions: [
        ElevatedButton(
          onPressed: state.insert,
          child: const Text(
            "Adicionar",
            style: TextStyle(
              color: Cores.branco,
              fontFamily: 'Oxygen',
            ),
          ),
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent,
              shape: const CircleBorder()),
        ),
      ],
      subtitle: "Mesa ${NumberFormat('00').format(widget.mesa.pedido)}",
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.22,
              padding: const EdgeInsets.fromLTRB(25, 15, 25, 10),
              child: Card(
                elevation: 4,
                child: Container(
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //     colorFilter: ColorFilter.mode(
                  //         Colors.black.withOpacity(0.5), BlendMode.dstATop),
                  //     image: NetworkImage(
                  //         'https://img.imageboss.me/consul/cdn/animation:true/wp-content/uploads/2021/01/receitas-de-salada-de-fruta-simples.jpg'),
                  //     fit: BoxFit.fitWidth,
                  //     alignment: Alignment.topCenter,
                  //   ),
                  // ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Text(
                            NumberFormat('000').format(widget.prod.cod),
                            style: const TextStyle(
                                fontFamily: 'Oxygen', fontSize: 15),
                          ),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                widget.prod.produto!,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: 'Oxygen', fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${(widget.prod.quant ?? 0).toInt()} em estoque',
                            style: const TextStyle(
                              fontFamily: 'Oxygen',
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'R\$ ${NumberFormat("##0.00", "pt_BR").format(widget.prod.pvend)}',
                            style: const TextStyle(
                              fontFamily: 'Oxygen',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Quantidade",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Oxygen',
                        ),
                      ),
                      NumberPicker(
                        onChanged: (value) {
                          state._quant = value;
                        },
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: state._clienteController,
                        decoration: FieldDecorator('Cliente'),
                      ),
                      suggestionsCallback: (pattern) async {
                        return await state.getClientes(pattern);
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          dense: true,
                          title: Text(
                              (suggestion as Map<String, String>)['nome']!),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        state._clienteController.text =
                            (suggestion as Map<String, String>)['nome']!;
                      },
                      errorBuilder: (context, error) {
                        return const Text('Nenhum cliente encontrado');
                      },
                      noItemsFoundBuilder: (context) {
                        return const Text('Nenhum cliente encontrado');
                      },
                      loadingBuilder: (context) {
                        return const Text('Carregando clientes...');
                      },
                    ),
                  ),
                  TextField(
                    controller: state._obsController,
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: 5,
                    decoration: FieldDecorator('Observação'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Garçom",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          widget.mesa.garcom ?? "",
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
