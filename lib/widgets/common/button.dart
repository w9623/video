import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video/widgets/common/card.dart';

Widget DialogButton(String text, GestureTapCallback onTap) {
  return CardWidget(
    onTap: onTap,
    child: Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 21.w, right: 19.w),
          margin: EdgeInsets.only(top: 3.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.w)),
            border: Border.all(
              width: 1.w,
              color: Colors.white.withOpacity(0.51),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Color(0xFF59567B),
              fontSize: 17.sp,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 21.w, right: 21.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.w)),
            color: Colors.white,
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Color(0xFF59567B),
              fontSize: 17.sp,
            ),
          ),
        )
      ],
    ),
  );
}
