// result.g.dart 将在我们运行生成命令后自动生成
import 'package:json_annotation/json_annotation.dart';

/// 此文件有报错，暂时忽略，执行此行命令即可 flutter packages pub run build_runner build
/// 将在同级文件中生成此文件 result.g.dart

part 'result.g.dart';

@JsonSerializable()
class Result {
  //定义字段
  int fans;
  String name;
  String face;

  Result(this.fans, this.name, this.face);

  //固定格式，不同的类使用不同的mixin即可
  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  //固定格式，
  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
