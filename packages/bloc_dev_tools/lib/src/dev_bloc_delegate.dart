import 'package:bloc/bloc.dart';
import 'package:web_socket_channel/io.dart';

class DevBlocDelegate extends BlocDelegate {
  final IOWebSocketChannel channel =
      IOWebSocketChannel.connect("ws://localhost:34263");

  @override
  void onTransition(Transition transition) {
    channel.sink.add(
      '''{
        "currentState": ${transition.currentState.toString()},
        "event": ${transition.event.toString()},
        "nextState": ${transition.nextState.toString()},
        "timestamp":  ${DateTime.now().millisecondsSinceEpoch}
      }''',
    );
  }
}
