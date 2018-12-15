import 'dart:convert';

import 'package:uuid/uuid.dart';
import 'package:bloc/bloc.dart';
import 'package:web_socket_channel/io.dart';

class DevBlocDelegate extends BlocDelegate {
  final IOWebSocketChannel channel =
      IOWebSocketChannel.connect("ws://localhost:34263");
  final Map<String, Transition> _blocMap = Map<String, Transition>();

  DevBlocDelegate() {
    print('DevBlocDelegate()');
    channel.stream.listen((dynamic event) {
      final Map<String, dynamic> map = json.decode(event as String);
      final String uuid = map['uuid'].toString();
      final Transition transition = _blocMap[uuid];
      print('dispatching $transition');
      transition.bloc.currentState = transition.nextState;
    });
  }

  @override
  void onTransition(Transition transition) {
    final String uuid = Uuid().v1();
    print(uuid);
    _blocMap[uuid] = transition;

    channel.sink.add(
      '''{
        "currentState": ${transition.currentState},
        "event": ${transition.event},
        "nextState": ${transition.nextState},
        "timestamp":  ${DateTime.now().millisecondsSinceEpoch},
        "uuid": "$uuid"
      }''',
    );
  }
}
