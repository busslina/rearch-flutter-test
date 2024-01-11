import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rearch/flutter_rearch.dart';
import 'package:gap/gap.dart';
import 'package:rearch/rearch.dart';

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
    final pages = use.value(IList([
      Page(
        key: GlobalKey(),
        name: 'First',
      ),
      Page(
        key: GlobalKey(),
        name: 'Second',
      ),
      Page(
        key: GlobalKey(),
        name: 'Third',
      ),
    ]));

    final (currentIndex, setCurrentIndex) = use.state(0);

    return Container(
      width: 400,
      height: 300,
      color: Colors.blue,
      child: Column(
        children: [
          // Button previous page
          if (currentIndex > 0)
            ElevatedButton.icon(
                onPressed: () {
                  if (currentIndex == 0) return;

                  setCurrentIndex(currentIndex - 1);
                },
                icon: const Icon(Icons.arrow_circle_left),
                label: const Text('Previous')),

          // Button next page
          if (currentIndex < pages.length - 1)
            ElevatedButton.icon(
                onPressed: () {
                  if (currentIndex == pages.length - 1) return;

                  setCurrentIndex(currentIndex + 1);
                },
                icon: const Icon(Icons.arrow_circle_right),
                label: const Text('Next')),

          // Pages
          IndexedStack(
            index: currentIndex,
            children: pages.toList(),
          ),
        ],
      ),
    );
  }
}

class Page extends RearchConsumer {
  final String name;

  const Page({
    required super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetHandle use) {
    final (counter, setCounter) = use.state(0);

    return Column(
      children: [
        // Title
        Text('Page: $name'),

        const Gap(100),

        // Counter text
        Text('Counter: $counter'),

        const Gap(10),

        // Counter button
        ElevatedButton.icon(
          onPressed: () {
            setCounter(counter + 1);
          },
          icon: const Icon(Icons.add),
          label: const Text('Increment'),
        ),
      ],
    );
  }
}
