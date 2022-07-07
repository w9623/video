import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar buildAppBar({
  final Widget? leading,
  final Widget? title,
  final String? titleText,
  final Color? backgroundColor,
  final Color? titleTextColor,
  final Color? backIconColor,
  final List<Widget>? actions,
  final double? leadingWidth,
  final Widget? flexibleSpace,
  final VoidCallback? onBackPressed,
}) {
  return AppBar(
    flexibleSpace: flexibleSpace,
    leadingWidth: leadingWidth,
    centerTitle: true,
    backgroundColor: backgroundColor ?? Colors.white,
    elevation: 0,
    leading: leading ??
        Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: backIconColor ?? const Color(0xFF242424),
              ),
              iconSize: 20,
              onPressed: onBackPressed ?? () => Navigator.maybePop(context),
            );
          },
        ),
    title: title ??
        Text(
          titleText ?? '',
          style: TextStyle(
            color: titleTextColor ?? const Color(0xFF242424),
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
    actions: actions,
  );
}
