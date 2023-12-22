import 'package:rearch/rearch.dart';

({
  int counter,
  void Function() incrementCounter,
}) counterCapsule(
  CapsuleHandle use,
) {
  final (counter, setCounter) = use.state(0);

  return (counter: counter, incrementCounter: () => setCounter(counter + 1));
}
