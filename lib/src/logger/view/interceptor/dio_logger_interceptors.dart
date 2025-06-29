import 'package:dio/dio.dart';
import 'package:kurban_custom_widgets/kurban_custom_widgets.dart';
import 'package:kurban_custom_widgets/src/model/dio_log_model.dart';

class DioLoggerInterceptors extends Interceptor {
  final DioLoggerScreenLogic loggerLogic =
      DioLoggerScreenLogic.instance; // 使用单例

  final Map<int, DateTime> _requestStartTimes = {};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final now = DateTime.now();
    _requestStartTimes[options.hashCode] = now;
    loggerLogic.addLog(
      DioLogModel(request: options, timestamp: now),
    ); // 使用 addLog 方法
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var index = loggerLogic.logList.indexWhere((item) {
      return item.request.hashCode == response.requestOptions.hashCode;
    });
    if (index != -1) {
      final start =
          _requestStartTimes[response.requestOptions.hashCode] ??
          loggerLogic.logList[index].timestamp;
      final duration = DateTime.now().difference(start);
      loggerLogic.updateLog(
        index,
        loggerLogic.logList[index].copyWith(
          response: response,
          duration: duration,
        ),
      ); // 使用 updateLog 方法
    }
    _requestStartTimes.remove(response.requestOptions.hashCode);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    var index = loggerLogic.logList.indexWhere((item) {
      return item.request.hashCode == err.requestOptions.hashCode;
    });
    if (index != -1) {
      final start =
          _requestStartTimes[err.requestOptions.hashCode] ??
          loggerLogic.logList[index].timestamp;
      final duration = DateTime.now().difference(start);
      loggerLogic.updateLog(
        index,
        loggerLogic.logList[index].copyWith(
          response: err.response,
          error: err,
          duration: duration,
        ),
      ); // 使用 updateLog 方法
    }
    _requestStartTimes.remove(err.requestOptions.hashCode);
    super.onError(err, handler);
  }
}
