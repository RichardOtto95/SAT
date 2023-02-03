part of 'produtos_confirmar.dart';

class _ProdutosConfirmarView
    extends WidgetView<ProdutosConfirmar, _ProdutosConfirmarController> {
  const _ProdutosConfirmarView(_ProdutosConfirmarController state)
      : super(state);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: state._onWillPop,
      child: BaseLayout(
        title: "Confirmar Itens",
        subtitle: "Mesa ${NumberFormat('00').format(widget.mesa.pedido)}",
        gradientColor: Cores.verde,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Vendedor",
                  ),
                  Text(
                    widget.mesa.garcom ?? "",
                    textAlign: TextAlign.right,
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: Cache.itens!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        // color: Cores.branco,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        elevation: 2,
                        child: InkWell(
                          onTap: () => state.itemClick(index),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 10),
                                child: Text(
                                  "${Cache.itens![index].quant} ✕",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontFamily: 'Oxygen',
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 5, 10),
                                  child: Text(
                                    Cache.itens![index].produto ?? "",
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
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Text(
                                  "R\$ ${NumberFormat("##0.00", "pt_BR").format(Cache.itens![index].valor! * Cache.itens![index].quant!)}",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontFamily: 'Oxygen',
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 10.0,
                    spreadRadius: -6.0,
                    offset: Offset(0, 0), // shadow direction: bottom right
                  )
                ],
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 25,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Valor Total",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Oxygen',
                            ),
                          ),
                          Text(
                            "R\$ ${NumberFormat("##0.00", "pt_BR").format(state.total)}",
                            style: const TextStyle(
                              fontSize: 19,
                              fontFamily: 'Oxygen',
                            ),
                          ),
                          if (!widget.only_total)
                            Text(
                              "Serviços ${NumberFormat("##0.##").format(Models.param!.restaurantecomissaodogarcom)}% ",
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Oxygen',
                              ),
                            ),
                          if (!widget.only_total)
                            Text(
                              "R\$ ${NumberFormat("##0.00", "pt_BR").format(state.total * ((Models.param!.restaurantecomissaodogarcom! / 100) + 1))}",
                              style: const TextStyle(
                                fontSize: 19,
                                fontFamily: 'Oxygen',
                              ),
                            ),
                        ],
                      ),
                    ),
                    Wrap(
                      direction: (MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? Axis.horizontal
                          : Axis.vertical),
                      spacing: 8,
                      children: [
                        RoundButton(
                          text: 'Confirmar',
                          width: (MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? 180
                              : 170),
                          height: (MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? 42
                              : 32),
                          icon: const Icon(Icons.done),
                          onPressed: state.inserirIOE,
                        ),
                        RoundButton(
                          text: 'Inserir Produtos',
                          width: (MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? 180
                              : 170),
                          height: (MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? 42
                              : 32),
                          color: Cores.verde,
                          icon: const Icon(Icons.add),
                          onPressed: state.produtoclick,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
