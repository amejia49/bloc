import 'dart:collection';

import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

/// A Flutter widget which provides a bloc to its children via `BlocProvider.of(context)`.
/// It is used as a DI widget so that a single instance of a bloc can be provided
/// to multiple widgets within a subtree.
class BlocProvider extends StatefulWidget {
  /// The Blocs which are to be made available throughout the subtree
  final List<Bloc> blocs;

  /// The Widget and its descendants which will have access to the Blocs.
  final Widget child;

  BlocProvider({
    Key key,
    @required this.blocs,
    @required this.child,
  })  : assert(blocs != null && blocs.isNotEmpty && !blocs.contains(null)),
        assert(child != null),
        super(key: key);

  static HashMap<Type, HashMap<Type, Bloc>> _blocs =
      HashMap<Type, HashMap<Type, Bloc>>();

  /// Method that allows widgets to access the bloc as long as their `BuildContext`
  /// contains a `BlocProvider` instance.
  static B of<B extends Bloc<dynamic, dynamic>>(BuildContext context) {
    final Type contextType = context.owner.runtimeType;
    if (_blocs[contextType] == null) {
      throw FlutterError(
          'BlocProvider.of() called with a context that does not contain any BlocProviders.\n'
          'This can happen if the context you use comes from a widget above the BlocProvider.\n'
          'The context used was:\n'
          '  $context');
    }
    if (_blocs[contextType][B] == null) {
      throw FlutterError(
          'BlocProvider.of() called with a context that does not contain a Bloc of type $B.\n'
          'This can happen if the context you use comes from a widget above the BlocProvider.\n'
          'The context used was:\n'
          '  $context');
    }
    return _blocs[contextType][B] as B;
  }

  @override
  _BlocProviderState createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  void initState() {
    final Type contextType = context.owner.runtimeType;
    for (int i = 0; i < widget.blocs.length; i++) {
      final Bloc bloc = widget.blocs[i];
      if (BlocProvider._blocs[contextType] == null) {
        BlocProvider._blocs[contextType] = HashMap<Type, Bloc>();
      }
      BlocProvider._blocs[contextType][bloc.runtimeType] = bloc;
    }
    super.initState();
  }

  @override
  void dispose() {
    final Type contextType = context.owner.runtimeType;
    BlocProvider._blocs[contextType] = HashMap<Type, Bloc>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
