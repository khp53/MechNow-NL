import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodel.dart';

//----------------------------------------------------------------------------
// Default View is with Selector and ChangeNotifierProvier
// Don't do anything with this file
// Null safety enabled
// Updated for rrad erp on 12th dec
//----------------------------------------------------------------------------

class BaseView<T> extends StatelessWidget {
  final Widget Function(
      BuildContext context, Viewmodel viewmodel, Widget? child) _builder;

  final Viewmodel _viewmodel;

  const BaseView({super.key, required builder, required T viewmodel})
      : _builder = builder,
        _viewmodel = viewmodel as Viewmodel;

  Widget _baseBuilder(
      BuildContext context, Viewmodel viewmodel, Widget? child) {
    if (viewmodel.busy) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return _builder(context, viewmodel, child);
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
        value: _viewmodel,
        child: Consumer<Viewmodel>(builder: _baseBuilder),
      );
}
