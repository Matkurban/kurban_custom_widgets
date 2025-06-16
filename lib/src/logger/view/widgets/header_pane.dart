import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kurban_custom_widgets/kurban_custom_widgets.dart';

class HeaderPane extends StatelessWidget {
  const HeaderPane({super.key, required this.header});

  final Map<String, dynamic> header;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: KurbanJsonViewer(
        jsonData: header,
        onLongPress: () {
          ///复制到剪切板
          Clipboard.setData(ClipboardData(text: jsonEncode(header)));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('复制成功'), duration: Duration(seconds: 2)),
          );
        },
      ),
    );
  }
}
