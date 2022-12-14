import 'package:flutter/material.dart';
import 'package:flu_bili/http/core/hi_error.dart';
import 'package:flu_bili/http/dao/login_dao.dart';
import 'package:flu_bili/util/string_util.dart';
import 'package:flu_bili/util/toast.dart';
import 'package:flu_bili/widget/appbar.dart';
import 'package:flu_bili/widget/login_button.dart';
import 'package:flu_bili/widget/login_effect.dart';
import 'package:flu_bili/widget/login_input.dart';

///登录页面
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool protect = false;
  bool loginEnable = false;
  String userName = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('密码登录', '注册', () {}),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(protect: protect, key: UniqueKey()),
            LoginInput(
              '用户名',
              '请输入用户',
              onChanged: (text) {
                userName = text;
                checkInput();
              },
            ),
            LoginInput(
              '密码',
              '请输入密码',
              obscureText: true, /// 是否为密码输入类型
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
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: LoginButton(
                  '登录',
                  enable: loginEnable,
                  onPressed: send, key: UniqueKey(),
                ))
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) && isNotEmpty(password)) {
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
      var result = await LoginDao.login(userName, password);
      print(result);
      if (result['code'] == 0) {
        // print('登录成功');
        showToast('登录成功');
      } else {
        // print(result['msg']);
        showWarnToast(result['msg']);
      }
    } on NeedAuth catch (e) {
      // print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      // print(e);
      showWarnToast(e.message);
    }
  }
}
