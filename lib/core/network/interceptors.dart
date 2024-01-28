
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class Record {
  final String id;
  final Stopwatch stopwatch;

  Record(this.id, this.stopwatch);
}

const uuid = Uuid();
ValueNotifier<List<Record>> trackers = ValueNotifier([]);

class HeaderInterceptor extends Interceptor {
  final Dio dio;
  final bool hasAuthorization;

  HeaderInterceptor({required this.dio, this.hasAuthorization = true});

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    Map<String, String> headers = {};
    try {

      String? token = "";

      //token = (await serviceLocator<LocalStorage>().myToken)?.bearerToken;
      headers = {
        if (hasAuthorization) 'Authorization': token,
        'Content-Type': 'application/json',
        'RequestSource': 'Web',
        'accept': 'application/json',
        "token": "ApiConstants.myToken",
      };

      // print(headers);
      //tracking durations for network calls
      var stopwatch = Stopwatch();
      String id = uuid.v4();
      options.headers["trackerId"] = id;
      trackers.value.add(Record(id, stopwatch));
      stopwatch.start();
    } catch (_) {
      headers = {
        'Content-Type': 'application/json',
        'accept': '/',
        'Authorization': '',
      };
    }

    options.headers.addAll(headers);
    // print(headers);
    return super.onRequest(options, handler);
  }

  @override
  onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.requestOptions.headers.containsKey("trackerId")) {
      final id = err.requestOptions.headers['trackerId'];
      var trackerData = trackers.value.where((element) => element.id == id);
      if (trackerData.isNotEmpty) {
        final tracker = trackerData.first;
        tracker.stopwatch.stop();

        trackers.value.removeWhere((element) => element.id == id);
      }
    }
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.headers.containsKey("trackerId")) {
      final id = response.requestOptions.headers['trackerId'];
      final tracker = trackers.value.firstWhere((element) => element.id == id);
      tracker.stopwatch.stop();
      trackers.value.removeWhere((element) => element.id == id);
    }

    super.onResponse(response, handler);
  }
}

extension ResponseExt on Response {
  String get message {
    try {
      return data["responseDescription"] ??
          data["description"] ??
          data['responseMessage'] ??
          '';
    } catch (_) {
      return '';
    }
  }

  bool get isSuccessful => statusCode == 200 || statusCode == 201;
}
