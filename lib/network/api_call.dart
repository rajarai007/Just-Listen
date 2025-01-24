import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import '../apiguard.dart';
import '../listenners/call_back_listeners.dart';
import '../provider/file_upload_provider.dart';
import 'api_client.dart';
import 'api_constants.dart';
import 'method.dart';
import 'package:http/http.dart' as http;

class ApiCall {
  static Future<void> makeApiCall(
      Enum requestCode,
      Map<String, dynamic>? params,
      Method m,
      String apiName,
      ApiResponse apiResponse,
      {String? baseUrl,
      FormData? formData,
      FileUploadProgressProvider? progressProvider,
      Map<String, dynamic>? queryParameters,
      String? authorization,
      bool f5Header = true,
      String? userAgent,
      String? xAppVersion,
      String contentType = 'application/json'}) async {
    var dio = ApiClient.getInstance(baseUrl: baseUrl);
    dio.options.headers['Content-Type'] = contentType;
    dio.options.headers["Authorization"] = authorization;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      switch (m) {
        case Method.GET:
          {
            debugPrint(
                "GET Api:${ApiConstants.BASE_URL}$apiName Params: $queryParameters");
            dio.get(apiName, queryParameters: queryParameters).then((value) {
              //debugPrint(value.data.toString());
              apiResponse.onResponse(
                  json.encode(value.data), value.statusCode!, requestCode);
            }).catchError((err) {
              try {
                if (err is DioError) {
                  debugPrint('Dio Error....${err.response!.data}');
                  apiResponse.onError(json.encode(err.response!.data),
                      err.response!.statusCode!, requestCode);
                } else {
                  debugPrint('Not Dio Error....${err.toString()}');
                  apiResponse.onError(err.toString(), 01, requestCode);
                }
              } catch (e) {
                debugPrint('catchError Error.... ${err.toString()}');
                apiResponse.onError(err.toString(), 02, requestCode);
              }
            });
          }
          break;
        case Method.POST:
          {
            final apiEndPoint =
                '${(requestCode == ApiRequest.GENERATE_AUTH_CODE || requestCode == ApiRequest.GET_UAE_PASS_PROFILE) ? baseUrl : ApiConstants.BASE_URL}$apiName';
            debugPrint("POST Api: $apiEndPoint Params: ${jsonEncode(params)}");

            Map<String, String> apiguardHeaders =
                await APIGuard.getRequestHeaders(
                    apiEndPoint, params != null ? jsonEncode(params) : '');
            apiguardHeaders["content-Type"] = contentType;
            apiguardHeaders["authorization"] = authorization ?? 'null';
            log(jsonEncode(apiguardHeaders));
            dio
                .post(apiName,
                    queryParameters: queryParameters,
                    options: Options(headers: apiguardHeaders),
                    data: params != null ? jsonEncode(params) : null)
                .then((value) async {
              // debugPrint(value.data.toString());
              Map<String, String> responseHeaders = {};
              value.headers.map.forEach((key, value) {
                responseHeaders[key] = value.join(';');
              });
              log(jsonEncode(responseHeaders));
              apiResponse.onResponse(
                  json.encode(value.data), value.statusCode!, requestCode);
              await APIGuard.parseResponseHeaders(responseHeaders);
            }).catchError((err) {
              try {
                if (err is DioError) {
                  debugPrint('Dio Error....${err.response!.data}');
                  apiResponse.onError(json.encode(err.response!.data),
                      err.response!.statusCode!, requestCode);
                } else {
                  debugPrint('Not Dio Error....${err.toString()}');
                  apiResponse.onError(err.toString(), 01, requestCode);
                }
              } catch (e) {
                debugPrint('catchError Error.... ${err.toString()}');
                apiResponse.onError(err.toString(), 02, requestCode);
              }
            });
          }
          break;
        case Method.DIO_POST:
          {
            final apiEndPoint =
                '${(requestCode == ApiRequest.GENERATE_AUTH_CODE || requestCode == ApiRequest.GET_UAE_PASS_PROFILE) ? baseUrl : ApiConstants.BASE_URL}$apiName';
            debugPrint("POST Api: $apiEndPoint Params: ${jsonEncode(params)}");
            Map<String, String> apiguardHeaders =
                await APIGuard.getRequestHeaders(
                    apiEndPoint, params != null ? jsonEncode(params) : '');
            apiguardHeaders["content-Type"] = contentType;
            apiguardHeaders["authorization"] = authorization ?? 'null';
            apiguardHeaders['user-agent'] =
                userAgent ?? (Platform.isAndroid ? 'Android' : 'IOS');
            apiguardHeaders['x-app-version'] = xAppVersion ?? '';
            log(jsonEncode(apiguardHeaders));

            http
                .post(Uri.parse(apiEndPoint),
                    body: jsonEncode(params), headers: apiguardHeaders)
                .then((response) async {
              if (response.statusCode != 200) {
                log('${response.statusCode} ${jsonDecode(response.body)}');
              }
              log(jsonEncode(response.headers));
              apiResponse.onResponse(
                  response.body, response.statusCode, requestCode);
              log(jsonEncode(response.headers));
              await APIGuard.parseResponseHeaders(response.headers);
            }).onError((error, stackTrace) {
              debugPrint('catchError Error.... ${error.toString()}');
              apiResponse.onError(error.toString(), 300, requestCode);
            });

            /*  dio
                .post(apiName,
                    queryParameters: queryParameters,
                    data: params != null ? jsonEncode(params) : null)
                .then((value) {
              //debugPrint(value.data.toString());
              apiResponse.onResponse(
                  json.encode(value.data), value.statusCode!, requestCode);
            }).catchError((err) {
              try {
                if (err is DioError) {
                  debugPrint('Dio Error....${err.response!.data}');
                  apiResponse.onError(json.encode(err.response!.data),
                      err.response!.statusCode!, requestCode);
                } else {
                  debugPrint('Not Dio Error....${err.toString()}');
                  apiResponse.onError(err.toString(), 01, requestCode);
                }
              } catch (e) {
                debugPrint('catchError Error.... ${err.toString()}');
                apiResponse.onError(err.toString(), 02, requestCode);
              }
            }); */
          }
          break;
        case Method.FORM_DATA:
          {
            //debugPrint("POST Api: ${ApiConstants.BASE_URL}$apiName Params: ${jsonEncode(params)}");
            dio.post(apiName, data: formData).then((value) {
              apiResponse.onResponse(
                  json.encode(value.data), value.statusCode!, requestCode);
            }).catchError((err) {
              try {
                if (err is DioError) {
                  apiResponse.onError(json.encode(err.response!.data),
                      err.response!.statusCode!, requestCode);
                } else {
                  apiResponse.onError(err.toString(), 00, requestCode);
                }
              } catch (e) {
                apiResponse.onError(err.toString(), 00, requestCode);
              }
            });
          }
          break;
        case Method.PATCH:
          {
            //debugPrint("PATCH Api: ${ApiConstants.BASE_URL}$apiName Params: ${jsonEncode(params)}");
            dio.patch(apiName, data: jsonEncode(params)).then((value) {
              apiResponse.onResponse(
                  json.encode(value.data), value.statusCode!, requestCode);
            }).catchError((err) {
              try {
                if (err is DioError) {
                  apiResponse.onError(json.encode(err.response!.data),
                      err.response!.statusCode!, requestCode);
                } else {
                  apiResponse.onError(err.toString(), 00, requestCode);
                }
              } catch (e) {
                apiResponse.onError(err.toString(), 00, requestCode);
              }
            });
          }
          break;
        case Method.PUT:
          {
            /*   debugPrint(
                "PUT Api: ${ApiConstants.BASE_URL}$apiName Params: ${jsonEncode(params)}");
            Map<String, String> apiguardHeaders =
                await APIGuard.getRequestHeaders(
                    '${ApiConstants.BASE_URL}$apiName', jsonEncode(params));
            apiguardHeaders['Content-Type'] = contentType;
            apiguardHeaders["Authorization"] = authorization ?? '';
            http
                .put(Uri.parse('${ApiConstants.BASE_URL}$apiName'),
                    body: jsonEncode(params), headers: apiguardHeaders)
                .then((response) async {
              apiResponse.onResponse(
                  json.encode(response.body), response.statusCode, requestCode);
              await APIGuard.parseResponseHeaders(response.headers);
            }).onError((error, stackTrace) {
              debugPrint('catchError Error.... ${error.toString()}');
              apiResponse.onError(error.toString(), 300, requestCode);
            }); */

            debugPrint(
                "PUT Api: ${ApiConstants.BASE_URL}$apiName Params: ${jsonEncode(params)}");
            dio
                .put(apiName,
                    queryParameters: queryParameters, data: jsonEncode(params))
                .then((value) {
              apiResponse.onResponse(
                  json.encode(value.data), value.statusCode!, requestCode);
            }).catchError((err) {
              try {
                if (err is DioError) {
                  debugPrint('Dio Error....${err.response!.data}');
                  apiResponse.onError(json.encode(err.response!.data),
                      err.response!.statusCode!, requestCode);
                } else {
                  debugPrint('Not Dio Error....${err.toString()}');
                  apiResponse.onError(err.toString(), 01, requestCode);
                }
              } catch (e) {
                debugPrint('catchError Error.... ${err.toString()}');
                apiResponse.onError(err.toString(), 02, requestCode);
              }
            });
          }
          break;
        case Method.DELETE:
          {
            debugPrint(
                "DELETE Api: ${ApiConstants.BASE_URL}$apiName Params: ${jsonEncode(params)}");
            dio.delete(apiName, queryParameters: params).then((value) {
              apiResponse.onResponse(
                  json.encode(value.data), value.statusCode!, requestCode);
            }).catchError((err) {
              try {
                if (err is DioError) {
                  debugPrint('Dio Error....${err.response!.data}');
                  apiResponse.onError(json.encode(err.response!.data),
                      err.response!.statusCode!, requestCode);
                } else {
                  debugPrint('Not Dio Error....${err.toString()}');
                  apiResponse.onError(err.toString(), 01, requestCode);
                }
              } catch (e) {
                debugPrint('catchError Error.... ${err.toString()}');
                apiResponse.onError(err.toString(), 02, requestCode);
              }
            });
          }
          break;
        case Method.UPLOAD:
          dio.options.headers["Content-Type"] = "multipart/form-data";
          //debugPrint("UPLOAD Api: ${ApiConstants.BASE_URL}$apiName Params: ${jsonEncode(formData?.fields)}");
          dio.post(apiName, data: formData,
              onReceiveProgress: (int sentBytes, int totalBytes) {
            double progressPercent = sentBytes / totalBytes * 100;
            debugPrint("onReceiveProgress: $progressPercent %");
          }, onSendProgress: (int sentBytes, int totalBytes) {
            double progressPercent = sentBytes / totalBytes * 100;
            debugPrint("onSendProgress: $progressPercent %");
            progressProvider?.progressPercent = progressPercent;
          }).then((value) {
            debugPrint(value.data.toString());
            apiResponse.onResponse(value.data, value.statusCode!, requestCode);
          }).catchError((err) {
            try {
              if (err is DioError) {
                apiResponse.onError(json.encode(err.response!.data),
                    err.response!.statusCode!, requestCode);
              } else {
                apiResponse.onError(err.toString(), 00, requestCode);
              }
            } catch (e) {
              apiResponse.onError(err.toString(), 00, requestCode);
            }
          });
          break;
      }
    } else {
      apiResponse.onError("Internet not available", 500, requestCode);
    }
  }
}
