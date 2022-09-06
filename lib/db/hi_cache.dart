import 'package:shared_preferences/shared_preferences.dart';

///缓存管理类
class HiCache {
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // late Future<int> _counterA;
  late SharedPreferences prefs;

  HiCache._() {
    init();
  }

  static var _instance;
  // static HiCache _instance;

  HiCache._pre(SharedPreferences prefs) {
    this.prefs = prefs;
  }

  ///预初始化，防止在使用get时，prefs还未完成初始化
  static Future<HiCache> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = HiCache._pre(prefs);
    }
    return _instance;
  }

  static HiCache getInstance() {
    if (_instance == null) {
      _instance = HiCache._();
    }
    return _instance;
  }

  void init() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  setString(String key, String value) {
    prefs.setString(key, value);
  }

  setDouble(String key, double value) {
    prefs.setDouble(key, value);
  }

  setInt(String key, int value) {
    prefs.setInt(key, value);
  }

  setBool(String key, bool value) {
    prefs.setBool(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs.setStringList(key, value);
  }

  Object? get<T>(String key) {
    return prefs.get(key);
  }
}

/// 使用方法
/// 第一步： 引入文件
/// import 'package:flu_bili/db/hi_cache.dart';
///
///
/// 第二步
// @override
//   void initState() {
//     super.initState();

//     HiCache.preInit(); // 核心代码，必须把父级的初始化钩子先执行，再执行缓存初始化
//   }

/// 第三步、第四步
///
/// 设置本地存储
//     HiCache.getInstance().setString('local-wen', '12345本地存储内容');
/// 获取本地存储
//     var val = HiCache.getInstance().get('local-wen');
//     print('获取本地存储: $val');