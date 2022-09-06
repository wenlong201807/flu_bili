

enum HttpMethod { GET, POST, DELETE }

///基础请求
abstract class BaseRequest {
  // curl -X GET "http://api.devio.org/uapi/test/test?requestPrams=11" -H "accept: */*"
  // curl -X GET "https://api.devio.org/uapi/test/test/1
  var pathParams;
  var useHttps = true;

  String authority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathStr = path();
    //拼接path参数
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }
    //http和https切换
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    if (needLogin()) {
      //给需要登录的接口携带登录令牌
      // addHeader(LoginDao.BOARDING_PASS, LoginDao.getBoardingPass());
    }
    print('url:${uri.toString()}');
    return uri.toString();
  }

  /// 是否需要登录
  bool needLogin();

  /// 存放所有的参数
  Map<String, String> params = Map();

  ///添加参数
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this; /// 链式调用
  }

  /// 鉴权
  Map<String, dynamic> header = {
    'course-flag': 'fa',
    //访问令牌，在课程公告获取
    "auth-token": "MjAyMC0wNi0yMyAwMzoyNTowMQ==fa",
  };

  ///添加header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
