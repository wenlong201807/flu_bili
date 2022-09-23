import 'package:flutter/material.dart';
import 'package:flu_bili/http/core/hi_error.dart';
import 'package:flu_bili/http/dao/login_dao.dart';
import 'package:flu_bili/util/string_util.dart';
// import 'package:flu_bili/util/toast.dart';
import 'package:flu_bili/widget/appbar.dart';
import 'package:flu_bili/widget/login_button.dart';
import 'package:flu_bili/widget/login_effect.dart';
import 'package:flu_bili/widget/login_input.dart';

///注册页面
class RegistrationPage extends StatefulWidget {
  final VoidCallback onJumpToLogin; /// 登录成功后的回调函数

  const RegistrationPage({required Key key, required this.onJumpToLogin}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;
  bool loginEnable = false; /// 注册按钮是否可点击状态
  String userName = '';
  String password = '';
  String rePassword = '';
  String imoocId = '';
  String orderId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", widget.onJumpToLogin),
      body: Container(
        /// ListView 包裹住所有列表项，如果有键盘出现，对应列表可以自适应，不被键盘遮挡
        child: ListView(
          /// 自适应键盘弹起，防止遮挡
          children: [
            LoginEffect(
              protect: protect, key: UniqueKey(),
            ),
            LoginInput(
              "用户名",
              "请输入用户名",
              onChanged: (text) {
                userName = text;
                checkInput();
              }, key: null,
            ),
            LoginInput(
              "密码",
              "请输入密码",
              obscureText: true,
              onChanged: (text) {
                password = text;
                checkInput();
              },
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
            ),
            LoginInput(
              "确认密码",
              "请再次输入密码",
              lineStretch: true,
              obscureText: true,
              onChanged: (text) {
                rePassword = text; /// onChanged 中不需要setState 去更新数据?
                checkInput();
              },
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
            ),
            LoginInput(
              "慕课网ID",
              "请输入你的慕课网用户ID",
              keyboardType: TextInputType.number, /// 展示键盘的类型
              onChanged: (text) {
                imoocId = text;
                checkInput();
              },
            ),
            LoginInput(
              "课程订单号",
              "请输入课程订单号后四位",
              keyboardType: TextInputType.number,
              lineStretch: true,
              onChanged: (text) {
                orderId = text;
                checkInput();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: LoginButton('注册',
                  enable: loginEnable, onPressed: checkParams, key: UniqueKey()),
            )
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword) &&
        isNotEmpty(imoocId) &&
        isNotEmpty(orderId)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  void send() async {
    try {
      var result =
      await LoginDao.registration(userName, password, imoocId, orderId);
      print(result);
      if (result['code'] == 0) {
        print('注册成功');
        // showToast('注册成功');
        if (widget.onJumpToLogin != null) {
          widget.onJumpToLogin();
        }
      } else {
        print(result['msg']);
        // showWarnToast(result['msg']);
      }
    } on NeedAuth catch (e) {
      print(e);
      // showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
      // showWarnToast(e.message);
    }
  }

  void checkParams() {
    String? tips;
    if (password != rePassword) {
      tips = '两次密码不一致';
    } else if (orderId.length != 4) {
      tips = "请输入订单号的后四位";
    }
    if (tips != null) {
      print(tips);
      return;
    }
    send();
  }
}
