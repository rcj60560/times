import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutterapp/dio/result_code.dart';
import 'package:flutterapp/utils/gloable_config.dart';

class DioManager {
  static DioManager _instance;
  Dio dio = Dio();

  static DioManager getInstance() {
    if (_instance == null) {
      _instance = DioManager();
    }
    return _instance;
  }

  DioManager() {
    dio.options.headers = {};
    dio.options.baseUrl = "";
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
    dio.interceptors.add(LogInterceptor(
        requestHeader: GloableConfig.isDebug,
        request: GloableConfig.isDebug,
        requestBody: GloableConfig.isDebug));
  }

  //get
  get(String url, Map params, Function successCallback,
      Function errorCallback) async {
    _requestHttp(url, successCallback, 'get', params, errorCallback);
  }

  Future<void> _requestHttp(String url, Function successCallback, String method,
      Map params, Function errorCallback) async {
    Response response;

    try {
      if (method == 'get') {
        if (params != null) {
          response = await dio.get(url, queryParameters: params);
        } else {
          response = await dio.get(url);
        }
      } else if (method == 'post') {
        if (params != null) {
          response = await dio.post(url, queryParameters: params);
        } else {
          response = await dio.post(url);
        }
      }
    } on DioError catch (error) {
      Response errorResponse;

      //错误请求
      if (error != null) {
        errorResponse = error.response;
      } else {
        errorResponse = Response(statusCode: 666);
      }

      //请求超时
      if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = ResultCode.CONNECT_TIMEOUT;
      }
//      一般服务器错误
      else if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = ResultCode.RECEIVE_TIMEOUT;
      }

      if (GloableConfig.isDebug) {
        print('请求异常:' + error.toString());
        print('请求异常 url :' + url);
        print('请求头:' + dio.options.headers.toString());
        print('请求method:' + dio.options.method.toString());
      }
      _error(errorCallback, error.message);
    }

    //debug 打印相关数据
    if (GloableConfig.isDebug) {
      print('请求URL：' + url);
      print('请求头：' + dio.options.headers.toString());
      print('请求URL：');
      if (params != null) {
        print('请求参数：' + params.toString());
      }
      if (response != null) {
        print('返回参数：' + response.toString());
      }
    }

    String dataStr = json.encode(response.data);

    Map<String, dynamic> dataMap = json.decode(dataStr);
    if (dataMap == null) {
      _error(errorCallback, '错误信息：' + '，' + response.data.toString());
    } else if (successCallback != null) {
      successCallback(dataMap);
    }
  }

  void _error(Function errorCallback, String message) {
    if (errorCallback != null) {
      errorCallback(message);
    }
  }
}
