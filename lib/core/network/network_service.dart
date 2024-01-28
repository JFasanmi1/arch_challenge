import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:arch_challenge/core/config/config.dart';
import 'package:arch_challenge/core/enums/request_type.dart';
import 'package:arch_challenge/core/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'interceptors.dart';

class NetworkService {
  Dio _dio = Dio();
  final bool hasAuthorization;
  static const int timeoutSeconds = 120;

  NetworkService({this.hasAuthorization = true}) {
    _dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: timeoutSeconds),
      receiveTimeout: const Duration(seconds: timeoutSeconds),
    ));

    _dio.interceptors
        .add(HeaderInterceptor(dio: _dio, hasAuthorization: hasAuthorization ));
  }

  Future call({
    Map? payload,
    required String url,
    String? action,
    required RequestType requestType,
  }) async {
    Response? response;
    final DateTime startTime = DateTime.now();
    try {
      if (requestType == RequestType.get) {
        response = await _getRequest(url);
      } else if (requestType == RequestType.post) {
        response = await _postRequest(url, payload: payload);
      } else if (requestType == RequestType.put) {
        response = await _putRequest(url, payload: payload);
      } else if (requestType == RequestType.patch) {
        response = await _patchRequest(url, payload: payload);
      }
      if (response == null || response.statusCode == 401) {
        return null;
      }
      // if (response.statusCode == 401) {
      //     logoutUser(LoginSource.tokenExpired);
      //   return null;
      // }

      //unsure of what the response can be
      //if (response.data is Map) return response.data as Map<String, dynamic>;

      return response.data;

    } on TimeoutException catch (e) {
      debugPrint('TIMEOUT ${e.duration}');
      // return null;
      rethrow;
    } catch (ex) {
      debugPrint(ex.toString());
      // return null;
      rethrow;
    } finally {
      // Log
      if (AppConfig.environment == Environment.dev || kDebugMode) {
        debugPrint('----------------MY API----------------------');
        log("statusCode: ${response?.statusCode}");
        log("payload: ${jsonEncode(payload)}");
        log("url: $url\tTime: ${DateTime.now().difference(startTime).toString()}\n\n responseBody: ${response?.data}");
        log('----------------MY API----------------------');
      }
    }
  }

  Future<Response> _getRequest(String urlEndPoint) async => await _dio.get(
        urlEndPoint,
      );

  Future<Response> _postRequest(urlEndpoint, {Map? payload}) async =>
      await _dio.post(urlEndpoint, data: payload);

  Future<Response> _putRequest(urlEndpoint, {Map? payload}) async =>
      await _dio.put(
        urlEndpoint,
        data: payload,
      );

  Future<Response> _patchRequest(urlEndpoint, {Map? payload}) async =>
      await _dio.patch(
        urlEndpoint,
        data: payload,
      );

  //i can optionally check for slow network here
}

String errorHandler(error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.badResponse:
        if (error.response != null) {
          if (error.response?.statusCode == 401) {
            return 'user unathorised';
          } else if (error.response?.statusCode == 403) {
            return 'Session expired';
          } else if (error.response?.statusCode == 500) {
            return AppConstants.exceptionMessage;
          }
        }

        return error.response?.message ??
            error.response?.message ??
            AppConstants.exceptionMessage;
      case DioExceptionType.connectionTimeout:
        return 'Connection Timeout. Please try again later or check your connection.';

      case DioExceptionType.sendTimeout:
        return 'Connection Timeout. Please try again later or check your connection.';
      case DioExceptionType.receiveTimeout:
        return 'Connection Timeout. Please try again later or check your connection.';
      case DioExceptionType.cancel:
        return "Request cancelled";
      case DioExceptionType.unknown:
        return "No Internet Connection";
      default:
        return AppConstants.exceptionMessage;
    }
  }
  if (AppConfig.environment == Environment.dev || kDebugMode) {
    debugPrint('----------------MY errorHandler----------------------');
    log("statusCode: ${error.toString()}");
    log('----------------MY errorHandler----------------------');
  }
  return AppConstants.exceptionMessage;
}
