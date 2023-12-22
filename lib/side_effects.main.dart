import 'package:flutter/material.dart';
import 'package:flutter_rearch/flutter_rearch.dart';

import 'side_effects/capsules.dart';

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
          // Start / stop button
          ElevatedButton.icon(
            onPressed: () {},
            // onPressed: () =>
            //     countdown.isActive ? countdown.pause() : countdown.resume(),
            icon: countdown.isActive
                ? const Icon(Icons.pause)
                : const Icon(Icons.play_arrow),
            label:
                countdown.isActive ? const Text('Pause') : const Text('Resume'),
          ),

          // Counter text
          Text('Countdown: ${countdown.value}'),
        ],
      ),
    );
  }
}
