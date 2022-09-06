import 'package:flu_bili/http/core/hi_net_adapter.dart';
import 'package:flu_bili/http/request/base_request.dart';

///测试适配器，mock数据
class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) {
    return Future<HiNetResponse<T>>.delayed(const Duration(milliseconds: 1000),
        () {
      return HiNetResponse(
        data: {"code": 0, "message": 'success'},
        // statusCode: 403, // 未登录 需要登录Instance of 'NeedAuth' 不同状态码对应不同的异常捕获
        // statusCode: 200, // 正常
        statusCode: 500, // 正常
      );
    });
  }
}
