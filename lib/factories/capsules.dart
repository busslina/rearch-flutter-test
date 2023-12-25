import 'package:rearch/rearch.dart';

ConnectionController Function(String key) connectionFactoryCapsule(
    CapsuleHandle use) {
  final connections = use.value(<int, Connection>{});
  final (count, setCount) = use.state(0);

  return (key) => (
        // (01) Get connection
        getConnection: (key) => connections[key]!,

        // (02) Add connection
        addConnection: (serverSide) {
          connections[count] = Connection(key: count);
          setCount(count + 1);

          return 0;
        },
      );
}

typedef ConnectionController = ({
  // (01) Get connection
  Connection Function(int key) getConnection,

  // (02) Add connection
  int Function(bool serverSide) addConnection,
});

class Connection {
  final int key;

  Connection({
    required this.key,
  });
}
