import 'package:dio/dio.dart';

class DioLogModel {
  final RequestOptions request;
  final Response? response;
  final dynamic error;
  final DateTime timestamp;
  final Duration? duration;

  DioLogModel({
    required this.request,
    this.response,
    this.error,
    required this.timestamp,
    this.duration,
  });

  DioLogModel copyWith({
    RequestOptions? request,
    Response? response,
    dynamic error,
    DateTime? timestamp,
    Duration? duration,
  }) {
    return DioLogModel(
      request: request ?? this.request,
      response: response ?? this.response,
      error: error ?? this.error,
      timestamp: timestamp ?? this.timestamp,
      duration: duration ?? this.duration,
    );
  }
}
