import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardWidget extends StatelessWidget {
  final Color? color;
  final double? width;
  final double? height;
  final double? circular;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final GestureTapCallback? onTap;
  final List<BoxShadow>? boxShadow;
  final GestureLongPressCallback? onLongPress;
  final Gradient? gradient;

  final Widget? child;

  const CardWidget({
    key,
    this.color,
    this.width,
    this.height,
    this.circular,
    this.boxShadow,
    this.alignment,
    this.margin,
    this.padding,
    this.onTap,
    this.child,
    this.onLongPress,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        alignment: alignment,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(circular ?? 10.w)),
          boxShadow: boxShadow,
          gradient: gradient,
        ),
        child: child,
      ),
    );
  }
}
