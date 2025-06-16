import 'package:flutter/material.dart';
import 'package:kurban_custom_widgets/kurban_custom_widgets.dart';
import 'package:kurban_custom_widgets/src/logger/widgets/logger_list_card.dart';

class DioLoggerScreen extends StatefulWidget {
  const DioLoggerScreen({super.key, required this.logic});

  final DioLoggerScreenLogic logic;

  @override
  State<DioLoggerScreen> createState() => _DioLoggerScreenState();
}

class _DioLoggerScreenState extends State<DioLoggerScreen> {
  @override
  void initState() {
    super.initState();
    widget.logic.onLogUpdated = () => setState(() {});
  }

  @override
  void dispose() {
    widget.logic.onLogUpdated = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(title: Text('Network Log')),
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemBuilder: (BuildContext context, int index) {
              var item = widget.logic.logList.reversed.toList()[index];
              return LoggerListCard(
                item: item,
                onTap: () => widget.logic.toDetails(context, item),
              );
            },
            itemCount: widget.logic.logList.length,
          ),
        ),
      ),
    );
  }
}
