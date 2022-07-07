import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:video/app/runtime.dart';

class NavigatorUtil {
  //跳转方法
  static go(
    BuildContext context,
    String path, {
    clearStack,
    args,
  }) {
    return router.navigateTo(
      context, path, //路径
      transition: TransitionType.cupertino, //切换动画
      clearStack: clearStack ?? false,
      routeSettings: RouteSettings(
        arguments: args,
      ),
    );
  }

}
