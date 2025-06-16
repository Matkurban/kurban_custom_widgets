import 'package:flutter/material.dart';
import 'package:kurban_custom_widgets/kurban_custom_widgets.dart';

class DioLoggerNavButton extends StatelessWidget {
  const DioLoggerNavButton({
    super.key,
    this.child = const Icon(Icons.network_check, color: Color(0xFF4CAf50)),
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return DioLoggerScreen(logic: DioLoggerScreenLogic.instance);
              },
            ),
          );
        },
        icon: child,
      ),
    );
  }
}
