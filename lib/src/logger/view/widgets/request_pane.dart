import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kurban_custom_widgets/kurban_custom_widgets.dart';

class RequestPane extends StatelessWidget {
  const RequestPane({super.key, required this.requestOptions});

  final RequestOptions requestOptions;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          KeyValueRow(keys: "Method", value: requestOptions.method),
          KeyValueRow(keys: "Scheme", value: requestOptions.uri.scheme),
          KeyValueRow(
            keys: "Url",
            value: "${requestOptions.baseUrl}${requestOptions.path}",
          ),
          KeyValueRow(
            keys: "QueryParameters",
            value: requestOptions.uri.queryParameters.toString(),
          ),
          KeyValueRow(
            keys: "ContentType",
            value: requestOptions.contentType ?? "",
          ),
          KeyValueRow(keys: "Header", value: ""),
          KurbanJsonViewer(
            jsonData: requestOptions.headers,
            onLongPress: () {
              ///复制到剪切板
              Clipboard.setData(
                ClipboardData(text: jsonEncode(requestOptions.headers)),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('复制成功'), duration: Duration(seconds: 2)),
              );
            },
          ),
        ],
      ),
    );
  }
}

class KeyValueRow extends StatelessWidget {
  const KeyValueRow({super.key, required this.keys, required this.value});

  final String keys;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        SizedBox(),
        Row(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(keys), Expanded(child: SelectableText(value))],
        ),
        DottedDividerWidget(color: Colors.grey.shade400, height: 1),
      ],
    );
  }
}
