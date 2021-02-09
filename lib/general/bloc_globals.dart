import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocDelegate extends BlocObserver {
  final Map<Bloc, List<Transition>> blocHistory = {};

  SimpleBlocDelegate() {
    debugPrint(
        '[INFO] Initializing SimpleBlocDelegate. Logging all Bloc events to the console');
  }

  /// To benefit fully from this function, have your main event class
  /// from each bloc extend the [Event] class from this file.
  @override
  void onEvent(Bloc bloc, Object event) {
    debugPrintSynchronously(
        '[INFO] ${event.runtimeType} added to ${bloc.runtimeType}');
    if (event is Event) {
      debugPrintSynchronously(
          '[INFO] Event called by ${_getCallingMethod(event)}');
    }
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    blocHistory.update(bloc, (value) => value..add(transition),
        ifAbsent: () => [transition]);
    super.onTransition(bloc, transition);
  }
}

class Event {
  final StackTrace debugInfo;

  Event() : debugInfo = StackTrace.current;
}

String _getCallingMethod(Event event) {
  List<String> stackTraceLines = event.debugInfo.toString().split('\n');
  final String callingFunction =
      stackTraceLines[3].replaceFirst(RegExp(r'#3\s+'), '');
  return callingFunction;
}
