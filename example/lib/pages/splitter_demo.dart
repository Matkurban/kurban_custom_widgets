import 'package:flutter/material.dart';
import 'package:kurban_custom_widgets/kurban_custom_widgets.dart';

class SplitterDemo extends StatelessWidget {
  const SplitterDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Splitter Demo")),
      body: KurbanSplitter(
        direction: Axis.horizontal,
        initialFirstFraction: 0.3,
        splitterDecoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(2),
        ),
        child1: Container(color: Colors.red),
        child2: KurbanSplitter(
          direction: Axis.vertical,
          initialFirstFraction: 0.3,
          splitterDecoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(2),
          ),
          child1: Container(color: Colors.yellow),
          child2: Container(color: Colors.black),
        ),
      ),
    );
  }
}
