import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:web_socket_channel/io.dart';

class DevBlocSnapshot {
  final Bloc bloc;
  final Transition transition;

  const DevBlocSnapshot({this.bloc, this.transition});
}

class DevBlocDelegate extends BlocDelegate {
  final IOWebSocketChannel channel =
      IOWebSocketChannel.connect("ws://localhost:34263");
  final Map<String, dynamic> _blocMap = Map<String, DevBlocSnapshot>();

  DevBlocDelegate() {
    print('DevBlocDelegate()');
    channel.stream.listen((dynamic event) {
      final Map<String, dynamic> map = json.decode(event as String);
      final String uuid = map['uuid'].toString();
      final DevBlocSnapshot snapshot = _blocMap[uuid];
      snapshot.bloc.dispatch(snapshot.transition.event);
      print('DevBlocDelegate recieved ${snapshot.transition.event}');
    });
  }

  @override
  void onTransition({Bloc bloc, Transition transition}) {
    final String uuid = '1';
    _blocMap[uuid] = DevBlocSnapshot(bloc: bloc, transition: transition);

    channel.sink.add(
      '''{
        "currentState": ${transition.currentState.toString()},
        "event": ${transition.event.toString()},
        "nextState": ${transition.nextState.toString()},
        "timestamp":  ${DateTime.now().millisecondsSinceEpoch},
        "uuid": $uuid     
      }''',
    );
  }
}
