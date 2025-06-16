import 'package:flutter/material.dart';
import 'package:kurban_custom_widgets/kurban_custom_widgets.dart';

class TitleChildCard extends StatelessWidget {
  const TitleChildCard({
    super.key,
    required this.title,
    required this.child,
    this.isLtr = true,
  });

  final bool isLtr;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KurbanUniversalCard(
      elevation: 3,
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
              textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
