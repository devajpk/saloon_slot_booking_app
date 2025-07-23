import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_k/comman/utilse/app_exception/app_exception.dart';

class ErrorLocalData {
  final StreamController<String> _errorController = StreamController();

  static ErrorLocalData get instance => Get.find<ErrorLocalData>();

  void writeError(AppException exception) async {
    _errorController.add(exception.message);
    final file = await _getErrorFile();

    final logEntry = '''
[${DateTime.now().toIso8601String()}]
Message    : ${exception.message}
API Endpoint: ${exception.apiEndPoint ?? 'N/A'}
StackTrace : ${exception.stackTrace ?? 'No stack trace available'}
----------------------------
''';

    await file.writeAsString(logEntry, mode: FileMode.append);
  }

  static void writeMessage(dynamic message) {
    instance._writeMessage(message.toString());
  }

  void _writeMessage(String message) async {
    final file = await _getErrorFile();

    final logEntry = '''
----------------------------
[${DateTime.now().toIso8601String()}]
Message    : $message
----------------------------
''';

    await file.writeAsString(logEntry, mode: FileMode.append);
  }

  static writeException(AppException e) {
    instance.writeError(e);
  }

  Stream<String> streamErrorMessage() => _errorController.stream;

  Future<File> getErrorLog() async => _getErrorFile();

  Future<File> _getErrorFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/error_log.txt';
    return File(path);
  }
}
