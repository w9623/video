import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video/page/search/search.dart';
import 'package:video/widgets/common/image.dart';

class VideoWidget extends StatefulWidget {
  VideoBean videoBean;
  GestureTapCallback onTap;

  VideoWidget({
    Key? key,
    required this.videoBean,
    required this.onTap,
  }) : super(key: key);

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r), color: Colors.black.withOpacity(0.2)),
        child: Stack(
          children: [
            ImageWidget(
              widget.videoBean.imageUrl ?? "",
              height: 167.h,
              width: 110.w,
            ),
            Column(
              children: [
                SizedBox(height: 8.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Spacer(),
                    Image.asset(
                      "assets/images/ic_video_chuang.png",
                      width: 35.w,
                      height: 28.h,
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    SizedBox(width: 8.w),
                    Image.asset(
                      "assets/images/ic_love.png",
                      width: 10.w,
                      height: 9.w,
                    ),
                    Text(
                      widget.videoBean.loveNum,
                      style: TextStyle(color: Colors.white, fontSize: 9.sp, height: 1.1),
                    ),
                    const Spacer(),
                    Image.asset(
                      "assets/images/ic_love.png",
                      width: 10.w,
                      height: 12.h,
                    ),
                    Text(
                      widget.videoBean.playNum,
                      style: TextStyle(color: Colors.white, fontSize: 9.sp, height: 1.1),
                    ),
                    SizedBox(width: 6.w),
                  ],
                ),
                SizedBox(height: 9.h)
              ],
            )
          ],
        ),
      ),
    );
  }
}
