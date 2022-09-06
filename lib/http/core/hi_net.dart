import 'package:flu_bili/http/core/dio_adapter.dart';

import '../request/base_request.dart';
import 'hi_error.dart';
import 'hi_net_adapter.dart';
import 'mock_adapter.dart';

///1.支持网络库插拔设计，且不干扰业务层
///2.基于配置请求请求，简洁易用
///3.Adapter设计，扩展性强
///4.统一异常和返回处理
class HiNet {
  HiNet._();

  static var _instance;

  /// 创建一个单例
  static HiNet getInstance() {
    _instance ??= HiNet._();
    return _instance;
  }

  /// 发送请求，可能是异步的
  Future fire(BaseRequest request) async {
    var error;
    // HiNetResponse response;
    var response;

    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      //其它异常
      error = e;
      printLog('其他异常: $e');
    }

    if (response == null) {
      printLog('null 的结果: $error');
    }
    var result = response.data;
    printLog(result);
    var status = response.statusCode;
    switch (status) {
      case 200:
        return result;
        break;
      case 401:
        throw NeedLogin();
        break;
      case 403:
        throw NeedAuth(result.toString(), data: result);
        break;
      default:
        throw HiNetError(status, result.toString(), data: result);
        break;
    }
  }

  /// 基础类，统一封装调用
  // Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
  //   ///使用Dio发送请求
  //   HiNetAdapter adapter = DioAdapter();
  //   return adapter.send(request);
  // }

  // Future fire (BaseRequest request) async {
  //   var response = await send(request);
  //   var result = response['data'];
  //   printTLog(result);
  //   return result;
  // }

  Future<dynamic> send<T>(BaseRequest request) async {
    printLog('完整的url: ${request.url()}');
    // printLog('httpMethod: ${request.httpMethod()}');
    // request.addHeader('token', '123');
    // printLog('header: ${request.header}');
    // return Future.value({
    //   "statusCode": 200,
    //   "data": {"code":0, "message": "ok"}
    // });
    /// 使用mock发送请求
    // HiNetAdapter adapter = MockAdapter();
    /// 真是接口处理发送请求
    HiNetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    print('${log.toString()}');
  }
}
