import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:video/app/routes.dart';
import 'package:video/app/runtime.dart';

import 'widgets/over_scroll_behavior.dart';

void main() {
  // 不加这个强制横/竖屏会报错
  WidgetsFlutterBinding.ensureInitialized();
  // 强制竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(OKToast(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key) {
    Routes.configureRoutes(router);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 813),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.generator,
        theme: ThemeData(
          // 点击时的高亮效果设置为透明
          splashColor: Colors.transparent,
          // 长按时的扩散效果设置为透明
          highlightColor: Colors.transparent,
          //
          dividerTheme: DividerTheme.of(context).copyWith(
            color: const Color(0XFF43445B),
            space: 0.5.h,
            thickness: 0.5.h,
          ),
          //
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: const Color(0XFF03E2A4),
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.h),
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: const Size(0, 0),
              padding: EdgeInsets.zero,
              textStyle: TextStyle(fontSize: 16.sp, color: Colors.white),
              elevation: 0,
              splashFactory: NoSplash.splashFactory,
            ),
          ),
        ),
        // 全局点击空白处隐藏键盘
        builder: (context, child) => Scaffold(
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: ScrollConfiguration(
              behavior: OverScrollBehavior(), // 取消滚动组件滑到顶部和尾部水波纹效果
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
