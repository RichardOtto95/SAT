part of 'ncm_busca.dart';

class _SubGruposBuscaView extends WidgetView<NCMBusca, _NCMBuscaController> {
  const _SubGruposBuscaView(_NCMBuscaController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      resizeToAvoidBottom: true,
      title: "NCM",
      appBarActions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        Visibility(
          visible: MediaQuery.of(context).orientation == Orientation.portrait,
          child: IconButton(
              onPressed: () {
                widget.ncm.ncm = state.codncm![state.selectedIndex];
                Navigator.pop(context);
              },
              icon: const Icon(Icons.done)),
        ),
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                Expanded(
                  flex: 20,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: const Text(
                      'Codigo',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black,
                        fontFamily: 'Oxygen',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 40,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: const Text(
                      'Descrição',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontFamily: 'Oxygen',
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: MediaQuery.of(context).orientation ==
                      Orientation.landscape,
                  child: Expanded(
                    flex: 40,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                      child: const Text(
                        'CEST',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: 'Oxygen',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 80,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: clientesWidget(),
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
                  Wrap(
                    spacing: 10,
                    children: [
                      RoundButton(
                        text: '',
                        icon: Icon(Icons.first_page, size: 15),
                        color: Cores.azul,
                        fontsize: 12,
                        width: MediaQuery.of(context).size.width * 0.15,
                        onPressed: (state.page == 0 ? null : state.firstPage),
                      ),
                      RoundButton(
                        text: (MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? ''
                            : 'Anterior'),
                        icon: Icon(Icons.arrow_back_ios, size: 15),
                        color: Cores.azul,
                        fontsize: 12,
                        width: MediaQuery.of(context).size.width * 0.15,
                        onPressed: (state.page == 0 ? null : state.backPage),
                      ),
                    ],
                  ),
                  Text(
                    'Página ${state.page + 1}/${state.maxpage}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontFamily: 'Oxygen',
                    ),
                  ),
                  Wrap(
                    spacing: 10,
                    children: [
                      RoundButton(
                        text: (MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? ''
                            : 'Próxima'),
                        icon: Icon(Icons.arrow_forward_ios, size: 15),
                        color: Cores.azul,
                        fontsize: 12,
                        width: MediaQuery.of(context).size.width * 0.15,
                        onPressed: (state.page == state.maxpage - 1
                            ? null
                            : state.nextPage),
                      ),
                      RoundButton(
                        text: '',
                        icon: Icon(Icons.last_page, size: 15),
                        color: Cores.azul,
                        fontsize: 12,
                        width: MediaQuery.of(context).size.width * 0.15,
                        onPressed: (state.page == state.maxpage - 1
                            ? null
                            : state.lastPage),
                      ),
                      Visibility(
                        visible: MediaQuery.of(context).orientation ==
                            Orientation.landscape,
                        child: RoundButton(
                          text: 'Selecionar',
                          icon: const Icon(Icons.done),
                          color: Cores.azul,
                          fontsize: 12,
                          onPressed: () {
                            widget.ncm.ncm = state.codncm![state.selectedIndex];
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder<List<NCM>> clientesWidget() {
    return FutureBuilder<List<NCM>>(
      key: ValueKey<int>(state.page),
      future: state.queryData(),
      builder: (context, snapshot) {
        var data = snapshot.data;
        if (snapshot.hasData) {
          return ListNCM(
            data: data!,
            onChanged: (value) {
              state.selectedIndex = value;
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class ListNCM extends StatefulWidget {
  const ListNCM({
    Key? key,
    required this.data,
    required this.onChanged,
  }) : super(key: key);
  final List<NCM> data;
  final ValueChanged<int> onChanged;

  @override
  State<ListNCM> createState() => _ListNCMState();
}

class _ListNCMState extends State<ListNCM> {
  int selectedIndex = 0;
  void updateSelected(index) {
    widget.onChanged(index);
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        return Card(
          color: index == selectedIndex ? Cores.azul : Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          elevation: 2,
          child: InkWell(
            onTap: () => updateSelected(index),
            child: Row(
              children: [
                Expanded(
                  flex: 20,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: Text(
                      widget.data[index].ncm ?? '',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 11,
                        color: index == selectedIndex
                            ? Cores.branco
                            : Colors.black,
                        fontFamily: 'Oxygen',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 40,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Text(
                      widget.data[index].descricao ?? '',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: index == selectedIndex
                            ? Cores.branco
                            : Colors.black,
                        fontFamily: 'Oxygen',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 40,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Text(
                      widget.data[index].cest ?? '',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: index == selectedIndex
                            ? Cores.branco
                            : Colors.black,
                        fontFamily: 'Oxygen',
                      ),
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
