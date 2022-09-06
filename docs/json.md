第一种方式，依赖flutter内部包
  import 'dart:convert';
  
  Map<String, dynamic> jsonMap = jsonDecode(jsonString);
  String json = jsonEncode(jsonMap);

第二种方式
  网页自动转json https://www.devio.org/io/tools/json-to-dart

第三种方式
  需要自定定义字段 /model/result.dart
  然后添加三个依赖包
  dependencies:
    json_annotation: ^4.6.0
  dev_dependencies:
    json_serializable: ^6.3.1
    build_runner: ^2.2.0
  最后，需要自己执行命令生产对应的json格式转换定义
    flutter packages pub run build_runner build