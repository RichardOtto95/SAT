part of 'obs.dart';

class _ObsView extends WidgetView<Obs, _ObsController> {
  const _ObsView(_ObsController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      resizeToAvoidBottom: true,
      title: 'Observação',
      titleSize: MediaQuery.of(context).size.height * 0.025,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: state.updateCPF,
        label: const Text('Salvar'),
        icon: const Icon(
          Icons.save,
        ),
        backgroundColor: Cores.azul,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: TextField(
          controller: state._obsController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          minLines: null,
          expands: true,
          textAlignVertical: TextAlignVertical.top,
          decoration: FieldDecorator('Observação'),
        ),
      ),
    );
  }
}
