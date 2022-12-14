import 'package:flutter/material.dart';

/// 解决键盘背景色 必须写 white 的境况
const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);

///主色调
const MaterialColor primary = const MaterialColor(
  0xfffb7299,
  const <int, Color>{50: const Color(0xffff9db5)},
);
