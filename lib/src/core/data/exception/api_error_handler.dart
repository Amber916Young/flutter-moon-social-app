// ignore_for_file: empty_catches

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:moon/main.dart';
import 'package:moon/localization/language_constrants.dart';
import 'package:moon/src/core/data/model/response/error_response.dart';
import 'package:moon/src/core/helper/api_checker.dart';

class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              errorDescription = "Request to API server was cancelled";
              break;

            case DioExceptionType.receiveTimeout:
              errorDescription =
                  "Receive timeout in connection with API server";
              break;
            case DioExceptionType.badResponse:
              switch (error.response!.statusCode) {
                case 500:
                case 503:
                  errorDescription = error.response!.statusMessage;
                  break;
                default:
                  ErrorResponse? errorResponse;
                  try {
                    errorResponse =
                        ErrorResponse.fromJson(error.response!.data);
                  } catch (e) {
                    if (kDebugMode) {
                      //print('error is -> ${e.toString()}');
                    }
                  }

                  if (errorResponse != null &&
                      errorResponse.errors != null &&
                      errorResponse.errors!.isNotEmpty) {
                    if (kDebugMode) {
                      //print('error----------------== ${errorResponse.errors![0].message} || error: ${error.response!.requestOptions.uri}');
                    }
                    errorDescription = errorResponse.toJson();
                    errorDescription = ApiChecker.checkError(errorResponse);
                  } else {
                    errorDescription =
                        "Failed to load data - status code: ${error.response!.statusCode}";
                  }
              }
              break;
            case DioExceptionType.sendTimeout:
              errorDescription =
                  getTranslated('send_timeout_with_server', Get.context!);
              break;
            case DioExceptionType.connectionTimeout:
              errorDescription =
                  getTranslated('send_timeout_with_server', Get.context!);
              break;
            case DioExceptionType.badCertificate:
              errorDescription =
                  getTranslated('incorrect_certificate', Get.context!);
              break;
            case DioExceptionType.connectionError:
              errorDescription =
                  '${getTranslated('unavailable_to_process_data', Get.context!)} '
                  '${error.response?.statusCode}';
              // errorDescription = '${getTranslated('unavailable_to_process_data', Get.context!)} '
              //     '${AppMode.demo == AppConstants.appMode ? error.response?.requestOptions.path : error.response?.statusCode}';
              break;
            case DioExceptionType.unknown:
              //debugPrint('error----------------== ${error.response?.requestOptions.path} || ${error.response?.statusCode} ${error.response?.data}');

              errorDescription =
                  getTranslated('unavailable_to_process_data', Get.context!);
              break;
          }
        } else {
          errorDescription = "Unexpected error occured";
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "is not a subtype of exception";
    }
    return errorDescription;
  }
}
