import 'package:flutter/material.dart';

class AppException implements Exception {
  final String message;
  dynamic? stackTrace;
  final String? apiEndPoint;
  AppException(this.message, {dynamic stackTrace, this.apiEndPoint }) {
    this.stackTrace = stackTrace ?? StackTrace.current;
    debugPrint("$message $apiEndPoint ${this.stackTrace.toString()}");
  }

  @override
  String toString() {
    return "AppException: $message";
  }
}

class BadRequestException extends AppException {
  BadRequestException(
    
    super.message,
  );

  @override
  String toString() {
    return "Bad Request: $message";
  }
}

