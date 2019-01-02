import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';

/// A Flutter widget which provides a bloc to its children via `BlocProvider.of(context)`.
/// It is used as a DI widget so that a single instance of a bloc can be provided
/// to multiple widgets within a subtree.
class BlocProvider extends StatefulWidget {
  /// The Blocs which are to be made available throughout the subtree.
  /// If multiple blocs are provided, the blocs will be inserted in the same order they are specified.
  /// For example if blocs: [BlocA, BlocB] BlocA will the an ancestor of BlocB.
  /// Blocs must not be null or empty.
  final List<Bloc> blocs;

  /// The Widget and its descendants which will have access to the Bloc.
  /// This must not be null.
  final Widget child;

  BlocProvider({
    Key key,
    @required this.blocs,
    @required this.child,
  })  : assert(blocs != null && blocs.isNotEmpty),
        assert(child != null),
        super(key: key);

  @override
  _BlocProviderState createState() => _BlocProviderState();

  /// Method that allows widgets to access the bloc as long as their `BuildContext`
  /// contains a `BlocProvider` instance.
  static B of<B extends Bloc<dynamic, dynamic>>(BuildContext context) {
    final type = _typeOf<_BlocProviderInherited<B>>();
    print('of $type');
    final _BlocProviderInherited<B> provider =
        context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;

    if (provider == null) {
      throw FlutterError(
          'BlocProvider.of() called with a context that does not contain a Bloc of type $B.\n'
          'No ancestor could be found starting from the context that was passed '
          'to BlocProvider.of<$B>(). This can happen '
          'if the context you use comes from a widget above the BlocProvider.\n'
          'The context used was:\n'
          '  $context');
    }
    return provider?.bloc;
  }

  static Type _typeOf<B>() => B;
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) =>
      _buildBlocProviders(widget.blocs, widget.child);

  Widget _buildBlocProviders(List<Bloc> blocs, Widget child) {
    return blocs.length == 1
        ? _BlocProviderInherited(
            bloc: blocs.first,
            child: child,
          )
        : _BlocProviderInherited(
            bloc: blocs.removeAt(0),
            child: _buildBlocProviders(blocs, child),
          );
  }
}

class _BlocProviderInherited<B extends Bloc<dynamic, dynamic>>
    extends InheritedWidget {
  _BlocProviderInherited({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(key: key, child: child) {
    print('building ${_typeOf<B>()}');
  }

  final B bloc;

  static Type _typeOf<B>() => B;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}
