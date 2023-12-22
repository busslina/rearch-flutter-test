import 'package:flutter/material.dart';
import 'package:flutter_rearch/flutter_rearch.dart';

import 'countdown/capsules.dart';

void main() {
  runApp(const RearchBootstrapper(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: const Color.fromARGB(255, 186, 178, 178),
          child: const Center(
            child: CounterWidget(),
          ),
        ),
      ),
    );
  }
}

class CounterWidget extends RearchConsumer {
  const CounterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetHandle use) {
    final countdown = use(countdownCapsule);

    return Container(
      width: 400,
      height: 300,
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Button
          ElevatedButton.icon(
            onPressed: () => {},
            // onPressed: () => use(counterCapsule).incrementCounter(),
            icon: const Icon(Icons.pause),
            label: const Text('Pause'),
          ),

          // Counter text
          Text('Counter: ${countdown.value}'),
        ],
      ),
    );
  }
}
