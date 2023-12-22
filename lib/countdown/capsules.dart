import 'dart:async';

import 'package:rearch/rearch.dart';

CountdownSideEffectController countdownCapsule(CapsuleHandle use) {
  final (getValue, setValue) = use.stateGetterSetter(60);

  use.callonce(() {
    return Timer.periodic(const Duration(seconds: 1), (_) {
      setValue(getValue() - 1);
    });
  });

  return (value: '${getValue()} seconds',);
}

typedef CountdownSideEffectController = ({
  String value,
});
