import 'dart:convert';

import 'package:flu_bili/http/core/hi_error.dart';
import 'package:flu_bili/model/owner.dart';
import 'package:flutter/material.dart';
import 'package:flu_bili/http/core/hi_net.dart';
import 'package:flu_bili/http/request/test_request.dart';

import 'package:flu_bili/model/result.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() async {
    TestRequest request = TestRequest();
    request.add('aa', 'ddd').add('bb', 'bbbb').add('requestPrams', '必穿的参数');
    try {
      var result = await HiNet.getInstance().fire(request);
      print('实际结果:r, $result');
    } on NeedAuth catch (e) {
      print(e);
    }
    // on HiNetLogin catch (e) {
    //   print(e);
    // }
    on HiNetError catch (e) {
      print('HiNetError: $e');
    }
    setState(() {
      _counter++;
    });
    // test();
    test1();
  }

  void test() {
    const jsonString = "{\"name\": \"flutter\", \"url\": \"https://666.com\"}";
    // json 转 map
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    print('name: ${jsonMap['name']}');
    print('url: ${jsonMap['url']}');

    /// map 转json
    String json = jsonEncode(jsonMap);
    print('json: $json');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: _increment,
          child: const Text('Increment 1接口数据测试'),
        ),
        const SizedBox(width: 16),
        Text('Count: $_counter'),
      ],
    );
  }

  void test1() {
    var ownerMap = {
      "name": "woshi shi",
      "face": "haha",
      "fans": 66,
    };
    Owner owner = Owner.fromJson(ownerMap);
    print('name: ${owner.name}');
    print('face: ${owner.face}');
    print('fans: ${owner.fans}');

    /// 半自动实现json格式化转换功能
    /// 需要定义字段，易维护， 适合中大型项目中使用
    Result r = Result.fromJson(ownerMap);
    print('r: $r ${r.name}');
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Counter(),
        ),
      ),
    ),
  );
}
