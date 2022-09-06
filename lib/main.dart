import 'package:flu_bili/http/core/hi_error.dart';
import 'package:flutter/material.dart';
import 'package:flu_bili/http/core/hi_net.dart';
import 'package:flu_bili/http/request/test_request.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() async {
    TestRequest request = TestRequest();
    request.add('aa', 'ddd').add('bb', 'bbbb');
    try {
      var result = await HiNet.getInstance().fire(request);
      print(result);
    } on NeedAuth catch (e) {
      print(e);
    }
    // on HiNetLogin catch (e) {
    //   print(e);
    // }
    on HiNetError catch (e) {
      print(e);
    }
    setState(() {
      _counter++;
    });
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
