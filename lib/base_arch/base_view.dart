// ignore_for_file: library_private_types_in_public_api

import '../core/logic_helper/import_all.dart';

class BaseView<T extends Model> extends StatefulWidget {
  final ScopedModelDescendantBuilder<T> _builder;
  final Function(T)? onViewModelReady;

  const BaseView({
    super.key,
    this.onViewModelReady,
    required ScopedModelDescendantBuilder<T> builder,
  }) : _builder = builder;

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends Model> extends State<BaseView<T>> {
  final T _model = locator<T>();

  @override
  void initState() {
    if (widget.onViewModelReady != null) {
      widget.onViewModelReady!(_model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ScopedModel<T>(
        model: _model,
        child: ScopedModelDescendant<T>(builder: widget._builder));
  }
}
