import 'side_effects.dart';

import 'package:rearch/rearch.dart';

CountdownSideEffectController countdownCapsule(CapsuleHandle use) {
  return use.asCountdown(60, autoStart: false);
}
