import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flu_bili/util/color.dart';

///登录输入框，自定义widget
class LoginInput extends StatefulWidget {
  /// 定义变量, 方法
  final String title;
  final String hint; /// 提示文字
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? focusChanged;
  final bool lineStretch;
  final bool obscureText; /// 是否启用密码输入
  final TextInputType? keyboardType; /// 对应输入键盘类型 数字键盘，字母键盘

  /// 默认构造函数
  const LoginInput(this.title, this.hint,
      { Key? key,
        this.onChanged,
        this.focusChanged,
        this.lineStretch = false,
        this.obscureText = false,
        this.keyboardType})
      : super(key: key);

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode(); /// 内置方法 是否获取焦点

  @override
  void initState() { /// 钩子函数 第一个: 初始化数据状态
    super.initState();
    /// 是否获取光标的监听
    _focusNode.addListener(() {
      print("Has focus: ${_focusNode.hasFocus}");
      /// 顶部定义的变量，使用方式 widget.focusChanged
      if (widget.focusChanged != null) {
        widget?.focusChanged!(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    /// 钩子函数，释放数据时使用
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// 钩子函数，每次数据有更新会执行一次，初始化时也会执行一次 render + update
    return Column(
      children: [
        Row(
          children: [
            /// 每一行: 左侧文字，右侧输入框
            Container(
              padding: const EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            _input()
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: !(widget.lineStretch) ? 15 : 0),
          child: const Divider(
            height: 1,
            thickness: 0.5,
          ),
        )
      ],
    );
  }

  /// 左侧文字写完后，将剩余宽度占满 Expanded [上下，左右皆可]
  _input() {
    return Expanded(
        child: TextField(
          focusNode: _focusNode,
          onChanged: widget.onChanged,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType, /// 键盘类型
          autofocus: !widget.obscureText, /// 是否自动获取焦点
          cursorColor: primary,
          style: const TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300),
          /// 输入框的样式
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 20, right: 20),
              border: InputBorder.none,
              hintText: widget.hint ?? '', /// 提示文案
              hintStyle: const TextStyle(fontSize: 15, color: Colors.grey)),
        ));
  }
}
