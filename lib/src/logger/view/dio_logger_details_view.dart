import 'package:flutter/material.dart';
import 'package:kurban_custom_widgets/src/model/dio_log_model.dart';
import 'package:kurban_custom_widgets/src/logger/view/widgets/header_pane.dart';
import 'package:kurban_custom_widgets/src/logger/view/widgets/request_pane.dart';
import 'package:kurban_custom_widgets/src/logger/view/widgets/response_pane.dart';

class DioLoggerDetailsView extends StatelessWidget {
  const DioLoggerDetailsView({super.key, required this.logModel});

  final DioLogModel logModel;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(
            title: Text(logModel.request.path),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Header'),
                Tab(text: 'Request'),
                Tab(text: 'Response'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              HeaderPane(header: logModel.request.headers),
              RequestPane(requestOptions: logModel.request),
              ResponsePane(data: logModel.response?.data ?? {}),
            ],
          ),
        ),
      ),
    );
  }
}
