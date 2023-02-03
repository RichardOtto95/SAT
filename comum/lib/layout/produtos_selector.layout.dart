part of 'produtos_selector.dart';

class _ProdutosView extends WidgetView<Produtos, _ProdutosController> {
  const _ProdutosView(_ProdutosController state) : super(state);

  @override
  Widget build(BuildContext context) {
    state.data = Cache.prods;
    return BaseLayout(
      resizeToAvoidBottom: true,
      title: "Inserir Produto",
      appBarActions: [
        IconButton(
            onPressed: () {
              state.setState(() {
                state.viewGrupos = !state.viewGrupos;
                state._controller.text = '';
                state.grupoIndex = 0;
                state.subGrupoIndex = 0;
                state.subVisible = false;
                state.searchBar.requestFocus();
              });
            },
            icon: Icon(state.viewGrupos ? Icons.search : Icons.search_off))
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: (state.subVisible ? 95 : 50),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!state.viewGrupos)
                  SizedBox(
                    height: 45,
                    child: Card(
                      elevation: 2,
                      child: TextField(
                        focusNode: state.searchBar,
                        onChanged: state.search,
                        controller: state._controller,
                        decoration: FieldDecorator('',
                            hint: 'Buscar', fillColor: Colors.white),
                      ),
                    ),
                  ),
                if (state.viewGrupos)
                  SizedBox(
                      height: 45,
                      child: _listViewGrupos(Cache.grupos, context, false)),
                if (state.subVisible)
                  SizedBox(
                    height: 45,
                    child: _listViewGrupos(
                        Cache.grupos![state.grupoIndex].subgrupo,
                        context,
                        true),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 80,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: _listViewProd(context),
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
                mainAxisAlignment: (kIsWeb
                    ? MainAxisAlignment.center
                    : Platform.isWindows
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween),
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RoundButton(
                    text: 'Código de barras',
                    icon: const Icon(Icons.qr_code_scanner_rounded),
                    fontsize: 12,
                    width: MediaQuery.of(context).size.width * 0.45,
                    onPressed: state.lerCodigoDeBarras,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                  ),
                  RoundButton(
                    text: 'Escolher Produto',
                    icon: const Icon(Icons.add),
                    color: Cores.verde,
                    fontsize: 12,
                    width: MediaQuery.of(context).size.width * 0.45,
                    onPressed: state.inserirProduto,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ScrollConfiguration _listViewGrupos(List<Grupo>? data, context, sub) {
    if (data!.isNotEmpty && data[0].clasd != 'Todos') {
      data.insert(0, Grupo(-1, clasd: 'Todos', subgrupo: <Grupo>[]));
    }
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      }),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return IntrinsicWidth(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 220, minWidth: 100),
                child: Card(
                  color: index == (sub ? state.subGrupoIndex : state.grupoIndex)
                      ? Cores.azul
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: 2,
                  child: InkWell(
                    onTap: () {
                      state.setState(() {
                        if (!sub) {
                          state.grupoIndex = index;
                          state.subGrupoIndex = 0;
                          if (data[index].subgrupo!.isNotEmpty) {
                            state.subVisible = true;
                          } else {
                            state.subVisible = false;
                          }
                        } else {
                          state.subGrupoIndex = index;
                        }
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              data[index].clasd!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: index ==
                                          (sub
                                              ? state.subGrupoIndex
                                              : state.grupoIndex)
                                      ? Cores.branco
                                      : Colors.black,
                                  fontFamily: 'Oxygen',
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  ListView _listViewProd(context) {
    state.queryData();
    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: state.data!.length,
      itemBuilder: (context, index) {
        return Card(
          color: index == state.selectedIndex ? Cores.azul : Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          elevation: 2,
          child: InkWell(
            onTap: () => state.updateSelected(index),
            onDoubleTap: () {
              state.updateSelected(index);
              state.inserirProduto();
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                  child: Text(
                    NumberFormat('00').format(state.data![index].cod),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: index == state.selectedIndex
                          ? Cores.branco
                          : Colors.black,
                      fontFamily: 'Oxygen',
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Text(
                      state.data![index].produto ?? "",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: index == state.selectedIndex
                            ? Cores.branco
                            : Colors.black,
                        fontFamily: 'Oxygen',
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                  child: Text(
                    "R\$ ${NumberFormat("##0.00", "pt_BR").format(state.data![index].pvend ?? 0)}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: index == state.selectedIndex
                          ? Cores.branco
                          : Colors.black,
                      fontFamily: 'Oxygen',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
