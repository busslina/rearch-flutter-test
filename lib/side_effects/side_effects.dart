import 'dart:async';

import 'package:rearch/rearch.dart';

extension _UseConvenience on SideEffectRegistrar {
  SideEffectRegistrar get use => this;
}

extension ResourceSideEffects on SideEffectRegistrar {
  CountdownSideEffectController asCountdown(
    int initialSecondsCount, {
    bool autoStart = false,
  }) =>
      use.register((api) {
        final (state, setState) = use.state(initialSecondsCount);

        Timer startTimer() =>
            Timer.periodic(const Duration(seconds: 1), (timer) {
              setState(state - 1);

              if (state == 0) {
                timer.cancel();
              }

              api.rebuild();
            });

        final (timer, setTimer) =
            use.state<Timer?>(autoStart ? startTimer() : null);

        bool isActive() => timer?.isActive ?? false;

        return (
          value: '$state seconds',
          isActive: isActive(),
          pause: () {
            if (!isActive()) {
              return false;
            }

            timer!.cancel();

            return true;
          },
          resume: () {
            if (isActive()) {
              return false;
            }

            setTimer(startTimer());

            return true;
          },
          reset: () => setState(initialSecondsCount),
        );
      });
}

typedef CountdownSideEffectController = ({
  String value,
  bool isActive,
  bool Function() pause,
  bool Function() resume,
  void Function() reset,
});
