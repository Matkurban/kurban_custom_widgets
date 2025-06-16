import 'package:flutter/material.dart';
import 'package:kurban_custom_widgets/src/logger/model/dio_log_model.dart';
import 'package:kurban_custom_widgets/src/logger/view/dio_logger_details_view.dart';

class DioLoggerScreenLogic {
  DioLoggerScreenLogic._privateConstructor(); // 私有构造函数

  static final DioLoggerScreenLogic _instance =
      DioLoggerScreenLogic._privateConstructor();

  static DioLoggerScreenLogic get instance => _instance; // 单例实例

  /// 日志集合
  final List<DioLogModel> logList = [];
  VoidCallback? onLogUpdated; // 添加回调函数

  void addLog(DioLogModel log) {
    logList.add(log);
    onLogUpdated?.call(); // 通知页面更新
  }

  void updateLog(int index, DioLogModel log) {
    logList[index] = log;
    onLogUpdated?.call(); // 通知页面更新
  }

  void toDetails(BuildContext context, DioLogModel item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DioLoggerDetailsView(logModel: item);
        },
      ),
    );
  }
}
