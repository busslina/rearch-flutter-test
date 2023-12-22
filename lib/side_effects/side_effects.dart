import 'dart:async';

import 'package:rearch/rearch.dart';

extension _UseConvenience on SideEffectRegistrar {
  SideEffectRegistrar get use => this;
}

extension ResourceSideEffects on SideEffectRegistrar {
  CountdownSideEffectController asCountdown(
    int initialSecondsCount, {
    bool autoStart = false,
  }) {
    final (getState, setState) = use.stateGetterSetter(initialSecondsCount);

    final (getTimer, setTimer) = use.stateGetterSetter<Timer?>(null);

    final rebuilder = use.rebuilder();
    final rebuild = () {
      print('REBUILDING');
      rebuilder();
    };

    Timer startTimer() {
      // print('startTimer()');

      return Timer.periodic(const Duration(seconds: 1), (timer) {
        // print('TIMER -- ${getState()}');

        setState(getState() - 1);

        if (getState() == 0) {
          timer.cancel();
        }

        rebuild();
      });
    }

    if (autoStart) {
      setTimer(startTimer());
    }

    bool isActive() => getTimer()?.isActive ?? false;

    return (
      value: '${getState()} seconds',
      isActive: isActive(),
      pause: () {
        if (!isActive()) {
          return false;
        }

        getTimer()!.cancel();

        rebuild();

        return true;
      },
      resume: () {
        if (isActive()) {
          return false;
        }

        // setTimer(startTimer());
        startTimer();

        return true;
      },
      reset: () => setState(initialSecondsCount),
      debug: () =>
          print('Countdown -- Value: ${getState()}, active: ${isActive()}'),
    );
  }
}

typedef CountdownSideEffectController = ({
  String value,
  bool isActive,
  bool Function() pause,
  bool Function() resume,
  void Function() reset,
  void Function() debug,
});
