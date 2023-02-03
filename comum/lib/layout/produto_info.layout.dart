part of 'produto_info.dart';

class _Produto_InfoView
    extends WidgetView<Produto_Info, _Produto_InfoController> {
  _Produto_InfoView(_Produto_InfoController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title:
          '#${NumberFormat('00').format(widget.local ? widget.id_item + 1 : widget.id_item)} - ${widget.title}',
      subtitle: 'Mesa ${NumberFormat('00').format(widget.mesa.pedido)}',
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Visibility(
              visible: (!widget.local ? widget.excluir : true),
              child: SizedBox(
                width: MediaQuery.of(context).size.width *
                    (MediaQuery.of(context).orientation == Orientation.landscape
                        ? 0.13
                        : 0.3),
                height: MediaQuery.of(context).size.height * 0.05,
                child: FloatingActionButton.extended(
                  heroTag: 'deleteitem',
                  onPressed: state.deleteItem,
                  elevation: 4,
                  label: Text(
                    'Excluir',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02),
                  ),
                  icon: const Icon(
                    Icons.delete,
                  ),
                  backgroundColor: Cores.vermelho,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            Visibility(
              visible: (widget.tranferir),
              child: SizedBox(
                width: MediaQuery.of(context).size.width *
                    (MediaQuery.of(context).orientation == Orientation.landscape
                        ? 0.15
                        : 0.4),
                height: MediaQuery.of(context).size.height * 0.05,
                child: FloatingActionButton.extended(
                  heroTag: 'transferitem',
                  onPressed: state.moveItem,
                  elevation: 4,
                  label: Text(
                    'Transferir',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02),
                  ),
                  icon: const Icon(
                    Icons.find_replace,
                  ),
                  backgroundColor: Cores.azul,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
              height: MediaQuery.of(context).size.height * 0.75,
              child: FutureBuilder<IOE>(
                future: state._load(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    state.item = snapshot.data;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                          color: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(const Radius.circular(10))),
                          elevation: 4,
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 5, 10),
                                child: const Text(
                                  'Produto',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Oxygen',
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: const Text(
                                      'Código',
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Oxygen',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: const Text(
                                        'Nome',
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Oxygen',
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: const Text(
                                      "Valor Unitário",
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Oxygen',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: Text(
                                      '${NumberFormat('0000').format(state.item!.cod)}',
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontFamily: 'Oxygen',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 5, 0),
                                      child: Text(
                                        state.item?.produto ?? "",
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontFamily: 'Oxygen',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Text(
                                      "R\$ ${NumberFormat("##0.00", "pt_BR").format(state.item!.precodevenda)}",
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontFamily: 'Oxygen',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 15))
                            ],
                          ),
                        ),
                        const Padding(
                            padding: const EdgeInsets.only(bottom: 20)),
                        Card(
                          color: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(const Radius.circular(10))),
                          elevation: 4,
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 5, 10),
                                child: const Text(
                                  'Pedido',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Oxygen',
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Vendedor',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Oxygen',
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${widget.mesa.garcom}",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: 'Oxygen',
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Cliente',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Oxygen',
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 5),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${state.item!.nome}",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: 'Oxygen',
                                  ),
                                ),
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: const Text(
                                        "Quantidade",
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Oxygen',
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 0, 5, 0),
                                        child: const Text(
                                          'Valor Total',
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Oxygen',
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 10, 0),
                                      child: const Text(
                                        "Hora",
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Oxygen',
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Text(
                                      '×${NumberFormat('###.0#').format(state.item!.quant)}',
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontFamily: 'Oxygen',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 0, 5, 0),
                                      child: Text(
                                        "R\$ ${NumberFormat("##0.00", "pt_BR").format(state.item!.valor ?? 0)}",
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontFamily: 'Oxygen',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Text(
                                      DateFormat('Hm').format(
                                          state.item!.dataentr ??
                                              DateTime.now()),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontFamily: 'Oxygen',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: const Text(
                                  'Observação',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontFamily: 'Oxygen',
                                  ),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  ((state.item!.obs ?? '').isEmpty
                                      ? 'Nenhuma observação.'
                                      : state.item!.obs!),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontFamily: 'Oxygen',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return const Center(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
