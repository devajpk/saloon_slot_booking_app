import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:project_k/comman/error_handling/error_local_data.dart';
import 'package:project_k/comman/utilse/app_exception/app_exception.dart';
import 'package:project_k/comman/utilse/url/app_url.dart';

class NetworkService {
  static final Dio _dio = Dio();
  static final Connectivity _connectivity = Connectivity();
  static bool isConnected = false;
  static String? authToken;

  static StreamSubscription<List<ConnectivityResult>>? subscription;

  static void refreshApisOnNetworkChange() async {
    var status = await _connectivity.checkConnectivity();
    if (status.contains(ConnectivityResult.mobile) ||
        status.contains(ConnectivityResult.wifi)) {
      isConnected = true;
    } else {
      isConnected = false;
    }
  }

  static void initAuthToken(String Function() callBack) {
    authToken = callBack();
  }

  static String _getAuthToken() {
    if (authToken == null) {
      throw AppException("Auth token is null");
    }
    return authToken!;
  }

  static String? _optionalAuthToken() {
    return authToken;
  }

  static void onDispose() {
    subscription?.cancel();
  }

  // ignore: prefer_final_fields
  static Map<String, String>? _header = {
    'Content-Type': 'application/json',
    'Authorization': '',
  };

  static Future<http.Response> postApi(
    String url,
    Map map, [
    String? userToken,
  ]) async {
    final uri = Uri.parse(url);
    if (userToken != null) {
      _header!['Authorization'] = "Bearer $userToken";
    }

    final body = jsonEncode(map);

    return await http.post(uri, body: body, headers: _header);
  }

  static Future<http.Response> putApi(
    String url,
    Map map, [
    String? userToken,
  ]) async {
    final uri = Uri.parse(url);
    if (userToken != null) {
      _header!['Authorization'] = "Bearer $userToken";
    }
    final body = jsonEncode(map);

    return await http.put(uri, body: body, headers: _header);
  }

  static Future<http.Response> getApi(
    String url, {
    String? token,
    Map<String, String>? params,
  }) async {
    String newUrl = url;
    if (params != null) {
      String endParams = '';
      if (url.contains("?")) {
        endParams = "&";
      } else {
        endParams = "?";
      }
      endParams =
          endParams +
          params.entries
              .map((e) => "${e.key}=${e.value}")
              .reduce((val, ele) => "$val&$ele");
      newUrl = url + endParams;
    }
    print("utl ${newUrl} with $token");
    final uri = Uri.parse(newUrl);
    if (token != null) {
      _header!['Authorization'] = "Bearer $token";
    }

    return await http.get(uri, headers: _header);
  }

  static Future<http.Response> deleteApi(
    String url, [
    String? token,
    Map<String, dynamic>? map,
  ]) async {
    final uri = Uri.parse(url);
    if (token != null) {
      _header!['Authorization'] = "Bearer $token";
    }
    final body = jsonEncode(map);
    return await http.delete(
      uri,
      headers: _header,
      body: map == null ? null : body,
    );
  }

  static Future<String> uploadImage<T>(String url, String imagePath) async {
    final file = await MultipartFile.fromFile(imagePath);

    final formData = FormData.fromMap({'file': file});

    var result = await _dio.post(
      url,
      data: formData,
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
    );
    if (result.statusCode == 200) {
      return result.data['url'];
    } else {
      throw BadRequestException("Error in uploading image");
    }
  }

  static transformResponse(http.Response response) {
    final responseBody = jsonDecode(response.body);
    print("sssss${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return responseBody;
    } else {
      final errorMessage = responseBody['message'] ?? 'An error occurred';
      throw BadRequestException(errorMessage);
    }
  }

  static Future<Either<String, Result>> _putEither<Json, Result>({
    required String endPoint,
    required Map<String, dynamic> body,
    required Result Function(Json) jsonTransform,
    Map<String, String?> queryParams = const {},
    String? param,
    bool showSnackBarOnError = true,
    bool useBaseUrl = true,
    bool useAuthToken = true,
  }) async {
    String url;
    if (useBaseUrl) {
      url = AppUrl.baseUrl + endPoint;
    } else {
      url = endPoint;
    }

    //if params available add it.
    if (param != null) {
      url += "/$param";
    }

    //if query param available, add it.
    Map<String, String> nonNullQueryParams = removeNullValues(queryParams);
    if (nonNullQueryParams.entries.isNotEmpty) {
      url +=
          "?${queryParams.entries.map((e) => "${e.key}=${e.value}").reduce((val, ele) => "$val&$ele")}";
    }

    try {
      http.Response response = await putApi(
        url,
        body,
        useAuthToken ? _getAuthToken() : null,
      );

      Json decoded = _decodeApiResponse(response);
      return Right(jsonTransform(decoded));
    } catch (e, stackTrace) {
      if (e is BadRequestException) {
        return Left(e.message);
      }
      return Left("Something went wrong");
    }
  }

  static Future<Either<String, Result>> putEither<Json, Result>({
    required String endPoint,
    required Map<String, dynamic> body,
    required Result Function(Json) jsonTransform,
    Map<String, String?> queryParams = const {},
    String? param,
    bool showSnackBarOnError = true,
    bool useBaseUrl = true,
    bool useAuthToken = true,
  }) {
    return _putEither(
      endPoint: endPoint,
      body: body,
      jsonTransform: jsonTransform,
      queryParams: queryParams,
      param: param,
      showSnackBarOnError: showSnackBarOnError,
      useBaseUrl: useBaseUrl,
      useAuthToken: useAuthToken,
    );
  }

  static Future<Either<String, Result>> postEither<Json, Result>({
    required String endPoint,
    required Map<String, dynamic> body,
    required Result Function(Json) jsonTransform,
    Map<String, String?> queryParams = const {},
    String? param,
    bool showSnackBarOnError = true,
    bool useBaseUrl = true,
    bool useAuthToken = true,
    bool removeBodyNullKeys = false,
  }) async {
    print(" $body");
    String url;
    if (useBaseUrl) {
      url = AppUrl.baseUrl + endPoint;
    } else {
      url = endPoint;
    }

    //if params available add it.
    if (param != null) {
      url += "/$param";
    }

    //if query param available, add it.
    Map<String, String> nonNullQueryParams = removeNullValues(queryParams);
    if (nonNullQueryParams.entries.isNotEmpty) {
      url +=
          "?${queryParams.entries.map((e) => "${e.key}=${e.value}").reduce((val, ele) => "$val&$ele")}";
    }
    if (removeBodyNullKeys) {
      body = removeNullValues(body);
    }
    late http.Response response;
    try {
      response = await postApi(url, body);

      Json decoded = _decodeApiResponse(response);
      return Right(jsonTransform(decoded));
    } catch (e, stackTrace) {
      if (e is FormatException) {
        ErrorLocalData.writeException(
          AppException(
            "Format exception,\ncode: ${response.statusCode} \n body: ${response.body}",
            stackTrace: stackTrace,
            apiEndPoint: url,
          ),
        );
        return Left("Format Error");
      }
      if (e is AppException) {
        return Left(e.message);
      }
      ErrorLocalData.writeException(
        e is AppException
            ? e
            : AppException(
              e.toString(),
              stackTrace: stackTrace,
              apiEndPoint: url,
            ),
      );
      return Left("Something went wrong");
    }
  }

  static Future<Either<String, Result>> deleteEither<Json, Result>({
    required String endPoint,
    Map<String, dynamic>? body,
    required Result Function(Json) jsonTransform,
    Map<String, String?> queryParams = const {},
    String? param,
    bool showSnackBarOnError = true,
    bool useBaseUrl = true,
    bool useAuthToken = true,
    bool removeBodyNullKeys = false,
  }) async {
    // Build the URL using the utility function
    String url = buildUrl(
      endPoint: endPoint,
      useBaseUrl: useBaseUrl,
      param: param,
      queryParams: queryParams,
    );

    // Remove null keys from body if specified
    Map<String, dynamic>? finalBody = body;
    if (removeBodyNullKeys && body != null) {
      finalBody = removeNullValues(body);
    }
    late http.Response response;
    try {
      response = await deleteApi(
        url,
        useAuthToken ? _getAuthToken() : null,
        finalBody,
      );

      // Decode the response
      Json decoded = _decodeApiResponse(response);
      return Right(jsonTransform(decoded));
    } catch (e, stackTrace) {
      if (e is FormatException) {
        ErrorLocalData.writeException(
          AppException(
            "Format exception,\ncode: ${response.statusCode} \n body: ${response.body}",
            stackTrace: stackTrace,
            apiEndPoint: url,
          ),
        );
        return Left("Format Error");
      }
      if (e is BadRequestException) {
        return Left(e.message);
      }
      ErrorLocalData.writeException(
        AppException(e.toString(), stackTrace: stackTrace, apiEndPoint: url),
      );
      return Left("Something went wrong");
    }
  }

  static T _decodeApiResponse<T>(
    http.Response response, {
    T Function(Map<String, dynamic>)? fromJson,
  }) {
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    dynamic decoded;
    try {
      decoded = jsonDecode(response.body);
    } catch (e) {
      throw AppException("Invalid JSON structure");
    }

    // If the response is a List (array), return it directly
    if (decoded is List) {
      return decoded as T;
    }

    if (decoded is Map<String, dynamic>) {
      switch (response.statusCode) {
        case 200:
        case 201:
          if (decoded['code'] == '200' ||
              decoded['result'] != null ||
              decoded['detail'] != null ||
              decoded['message'] != null ||
              decoded['start_time'] != null ||
              decoded['barber_id'] != null) {
            try {
              if (fromJson != null) {
                return fromJson(decoded);
              } else {
                return decoded as T;
              }
            } catch (e) {
              throw AppException("Failed to parse response: $e");
            }
          } else {
            throw AppException(
              decoded['message'] ?? 'Unexpected error $decoded',
            );
          }

        case 400:
        case 401:
        case 403:
          throw BadRequestException(
            decoded['message'] ?? decoded['detail'] ?? 'Bad request',
          );
        default:
          throw AppException(decoded['message'] ?? response.body);
      }
    }

    throw AppException("Invalid JSON structure");
  }

  static Future<Either<String, Result>> fetchEither<Json, Result>({
    required String endPoint,
    Map<String, String?> queryParams = const {},
    required Result Function(Json) jsonTransform,
    bool useBaseUrl = true,
    bool useAuthToken = true,
  }) async {
    String url = buildUrl(
      endPoint: endPoint,
      useBaseUrl: useBaseUrl,
      queryParams: queryParams,
    );

    try {
      http.Response response = await getApi(
        url,
        token: useAuthToken ? _getAuthToken() : _optionalAuthToken(),
      );
      Json decoded = _decodeApiResponse(response);
      return Right(jsonTransform(decoded));
    } catch (e, stackTrace) {
      if (e is BadRequestException) {
        return Left(e.message);
      }
      ErrorLocalData.writeException(
        AppException(e.toString(), stackTrace: stackTrace, apiEndPoint: url),
      );
      return Left("Something went wrong");
    }
  }

  static Map<String, T> removeNullValues<T>(Map<String, T?> data) {
    return Map<String, T>.fromEntries(
      data.entries
          .where((entry) => entry.value != null)
          .map((entry) => MapEntry(entry.key, entry.value as T)),
    );
  }

  /// A utility function that builds a URL by combining base URL, endpoint, path parameter,
  /// and query parameters.
  ///
  /// Parameters:
  /// - [endPoint] The API endpoint path (required)
  /// - [useBaseUrl] Whether to prepend the base URL to the endpoint (default: true)
  /// - [param] Optional path parameter to append to the endpoint
  /// - [queryParams] Optional map of query parameters to append to the URL
  ///
  /// Returns a complete formatted URL string
  static String buildUrl({
    required String endPoint,
    bool useBaseUrl = true,
    String? param,
    Map<String, String?>? queryParams,
  }) {
    // Start building the URL
    String url;
    if (useBaseUrl) {
      url = AppUrl.baseUrl + endPoint;
    } else {
      url = endPoint;
    }

    // Add path parameter if available
    if (param != null) {
      url += "/$param";
    }

    // Add query parameters if available
    if (queryParams != null && queryParams.isNotEmpty) {
      // Remove null values from query parameters
      Map<String, String> nonNullQueryParams = removeNullValues(queryParams);

      // Only add query parameters if there are non-null entries
      if (nonNullQueryParams.entries.isNotEmpty) {
        url +=
            "?${nonNullQueryParams.entries.map((e) => "${e.key}=${e.value}").join("&")}";
      }
    }

    return url;
  }
}
