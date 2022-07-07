import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video/widgets/common/button.dart';
import 'package:video/widgets/common/card.dart';
import 'package:video/widgets/common/image.dart';
import 'package:video/widgets/common/indicator.dart';
import 'package:video/widgets/text_expand.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  List<String> tabTextList = ["推荐", "关注"];
  List<Tab> tabWidgetList = [];
  late TabController tabController;
  static const timerCount = 10;
  int count = timerCount; //初始倒计时时间
  Timer? timer; //倒计时的计时器

  @override
  void initState() {
    super.initState();

    for (var value in tabTextList) {
      tabWidgetList.add(Tab(
        text: "$value",
      ));
    }
    tabController = new TabController(length: tabTextList.length, vsync: this);
    // _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildRootBody();
  }

  Widget buildRootBody() {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: buildTableViewWidget(),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: buildTabBarWidget(),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: BuildBottomWidget(),
          ),
        ],
      ),
    );
  }

  ///构建 TabBarView
  buildTableViewWidget() {
    return TabBarView(
      controller: tabController,
      children: tabTextList
          .map((value) => Container(
                alignment: Alignment.center,
                child: Text(
                  "$value",
                  style: TextStyle(color: Colors.white),
                ),
              ))
          .toList(),
    );
  }

  //构建顶部标签部分
  buildTabBarWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 40.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 17.w),
          CardWidget(
            margin: EdgeInsets.only(top: 18.h),
            alignment: Alignment.center,
            height: 25.h,
            color: Colors.black.withOpacity(0.2),
            circular: 20.w,
            child: Row(
              children: [
                SizedBox(width: 10.w),
                Image.asset("assets/images/ic_hot.png", width: 12.w, height: 15.h),
                SizedBox(width: 8.w),
                Text(
                  "99999",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(width: 12.w)
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 15.w),
              height: 55.h,

              ///对齐在顶部中间
              alignment: Alignment.center,
              child: TabBar(
                controller: tabController,
                tabs: tabWidgetList,
                isScrollable: true,

                ///指示器的宽度与文字对齐
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.only(bottom: 8.h),
                indicator: RoundUnderlineTabIndicator(
                  width: 22.5.w,
                  borderSide: BorderSide(
                    width: 3.h,
                    color: Colors.white,
                  ),
                ),
                labelStyle: TextStyle(
                  fontSize: 20.sp,
                ),
                unselectedLabelStyle: TextStyle(fontSize: 15.sp),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.only(top: 14.h),
              height: 50.h,
              alignment: Alignment.centerRight,
              child: Image.asset(
                "assets/images/ic_search.png",
                width: 25.w,
                height: 25.w,
              ),
            ),
          ),
          SizedBox(width: 20.w)
        ],
      ),
    );
  }

  _startTimer() {
    setState(() {
      count = timerCount;
      _update();
    });
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      count--;
      _update();
    });
  }

  _stopTimer() {
    timer?.cancel(); //倒计时结束取消定时器
    count = timerCount; //重置时间
  }

  _update() {
    setState(() {
      if (count == 0) {
        timer?.cancel(); //倒计时结束取消定时器
        count = timerCount; //重置时间
        //预览结束弹窗
        showDialog(
          context: context,
          builder: (context) {
            return UnconstrainedBox(
              constrainedAxis: Axis.horizontal,
              child: Material(
                type: MaterialType.transparency,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/bg_dialog.png",
                      height: 440.h,
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DialogButton(
                          "开通贵族",
                          () {},
                        ),
                        SizedBox(width: 17.w),
                        DialogButton(
                          "邀请无限看",
                          () {},
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      }
    });
  }
}

class BuildBottomWidget extends StatefulWidget {
  const BuildBottomWidget({Key? key}) : super(key: key);

  @override
  State<BuildBottomWidget> createState() => _BuildBottomWidgetState();
}

class _BuildBottomWidgetState extends State<BuildBottomWidget> {
  List<String> tagList = ['标签', '标签', '标签'];
  bool isVideo = false; //是否在直播中
  bool isLove = false; //是否点赞
  List<int> moneyList = [10, 30, 50, 100, 300, 500];
  TextEditingController moneyController = TextEditingController();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      height: 370.h,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                //加入守护
                CardWidget(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return UnconstrainedBox(
                            constrainedAxis: Axis.horizontal,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(18.w),
                                  topRight: Radius.circular(18.w),
                                ),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 27.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 50.w),
                                          child: Center(
                                            child: Text(
                                              "确认支付",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Color(0xFFb4b4b4),
                                          size: 25.w,
                                        ),
                                      ),
                                      SizedBox(width: 20.w)
                                    ],
                                  ),
                                  SizedBox(height: 32.h),
                                  Text(
                                    "免费播放前10s，观看完整版请支付",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.75),
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  SizedBox(height: 38.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/ic_diamond.png",
                                        width: 40.w,
                                        height: 30.h,
                                      ),
                                      Text(
                                        "30钻石",
                                        style: TextStyle(color: Color(0xFF79A6FD), fontSize: 24.sp, height: 1.1),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 42.h),
                                  CardWidget(
                                    width: double.infinity,
                                    height: 44.h,
                                    margin: EdgeInsets.only(left: 19.w, right: 19.w),
                                    alignment: Alignment.center,
                                    color: Color(0xFF7AA6FE),
                                    circular: 20.r,
                                    child: Text(
                                      "确认支付",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    "*我们不生产视频，我们只做视频的搬运工*",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.75),
                                      fontSize: 9.sp,
                                    ),
                                  ),
                                  SizedBox(height: 15.h)
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  padding: EdgeInsets.only(left: 16.w, right: 8.w, top: 5.h, bottom: 5.h),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFFFF44AA),
                      Color(0xFFFF3566),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        "加入守护，视频免费看",
                        style: TextStyle(color: Colors.white, fontSize: 11.sp, height: 1.1),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 12.w,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                //标签
                Row(
                  children: List.generate(
                    3,
                    (index) => _buildTagWidget(tagList[index]),
                  ),
                ),
                SizedBox(height: 12.h),
                //名称
                CardWidget(
                  child: Row(
                    children: [
                      Text(
                        "@",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                        ),
                      ),
                      Text(
                        "汉服频道，小众爱好",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  constraints: BoxConstraints(maxWidth: 175.w),
                  child: ExpandableText(
                    text: "这里是视频介绍，最多两行，多的视频省略弄查看更多查看更多查看更多查看查看更多查看12",
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      fontSize: 11.sp,
                    ),
                    expand: false,
                  ),
                ),
                SizedBox(height: 11.h),
                Row(
                  children: [
                    CardWidget(
                      onTap: () {},
                      padding: EdgeInsets.only(left: 7.w, top: 5.h, bottom: 5.h, right: 15.w),
                      color: Color(0xFF7AA6FE),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/ic_diamond.png",
                            width: 15.w,
                            height: 13.w,
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            "111",
                            style: TextStyle(color: Colors.white, fontSize: 10.sp, height: 1.1),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 6.w),
                    CardWidget(
                      padding: EdgeInsets.only(top: 5.h, bottom: 5.h, right: 10.h, left: 9.h),
                      color: Color(0xFF7AA6FE),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/ic_video.png",
                            width: 15.w,
                            height: 13.w,
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            "预览10s,邀请好友观看完整版",
                            style: TextStyle(color: Colors.white, fontSize: 10.sp, height: 1.1),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 7.w),
                    Text(
                      "03:25",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 19.h)
              ],
            ),
          ),
          const Spacer(),
          Container(
            child: Column(
              children: [
                //头像
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(border: Border.all(width: 2.w, color: Color(0xFF7ba9fb)), shape: BoxShape.circle),
                      child: ImageWidget(
                        "",
                        width: 39.w,
                        height: 39.w,
                      ),
                    ),
                    isVideo == true
                        ? Container(
                            margin: EdgeInsets.only(top: 39.h, left: 0.w),
                            padding: EdgeInsets.only(top: 3.h, bottom: 3.h, left: 6.w, right: 6.w),
                            decoration: BoxDecoration(
                              color: Color(0xFF7ba9fb),
                              borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/ic_hot.png",
                                  width: 9.w,
                                  height: 6.w,
                                ),
                                SizedBox(width: 1.w),
                                Text(
                                  "直播中",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 7.sp,
                                  ),
                                )
                              ],
                            ),
                          )
                        : InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(top: 37.h, left: 15.w),
                              width: 13.w,
                              height: 13.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFF7ba9fb)),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 10.w,
                              ),
                            ),
                          )
                  ],
                ),
                SizedBox(height: 27.h),
                //爱心
                InkWell(
                  onTap: () {
                    setState(() {
                      isLove = !isLove;
                    });
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        isLove == false ? "assets/images/ic_love.png" : "assets/images/ic_love_click.png",
                        width: 25.w,
                        height: 22.w,
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        "520k",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.sp,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 27.h),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: SingleChildScrollView(
                            child: UnconstrainedBox(
                              constrainedAxis: Axis.horizontal,
                              child: Container(
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 45.h),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(18.r),
                                          topLeft: Radius.circular(18.r),
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 27.h),
                                          Row(
                                            children: [
                                              const Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Icon(
                                                  Icons.close,
                                                  color: Color(0xFFb4b4b4),
                                                  size: 25.w,
                                                ),
                                              ),
                                              SizedBox(width: 20.w)
                                            ],
                                          ),
                                          SizedBox(height: 11.h),
                                          Center(
                                            child: Text(
                                              "打赏视频博主",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.sp,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 17.h),
                                          Container(
                                            padding: EdgeInsets.only(right: 19.w, left: 19.w),
                                            child: GridView.builder(
                                              physics: const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                mainAxisSpacing: 10,
                                                crossAxisSpacing: 5,
                                                childAspectRatio: 1 / 0.5,
                                              ),
                                              itemCount: moneyList.length,
                                              itemBuilder: (context, index) => _buildRewardWidget(moneyList[index], () {}),
                                            ),
                                            // constraints: BoxConstraints(maxHeight: 150.h),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 10.h, right: 19.w, left: 19.w),
                                            height: 49.h,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(5.r)),
                                              border: Border.all(
                                                color: Color(0xFF79A6FD),
                                                width: 0.5.w,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(width: 15.w),
                                                Image.asset(
                                                  "assets/images/ic_diamond.png",
                                                  width: 24.w,
                                                  height: 19.h,
                                                ),
                                                SizedBox(width: 6.w),
                                                Expanded(
                                                  child: TextField(
                                                    keyboardType: TextInputType.number,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: Color(0xFF79A6FD),
                                                      fontSize: 14.sp,
                                                    ),
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "请输入自定义打赏钻石",
                                                        hintStyle: TextStyle(
                                                          color: Colors.black.withOpacity(0.5),
                                                          fontSize: 14.sp,
                                                        )),
                                                    controller: moneyController,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 13.h),
                                          CardWidget(
                                            width: double.infinity,
                                            height: 44.h,
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(right: 19.w, left: 19.w, bottom: 13.h),
                                            onTap: () {},
                                            color: Color(0xFF7AA6FE),
                                            circular: 22.r,
                                            child: Text(
                                              "确认打赏",
                                              style: TextStyle(color: Colors.white, fontSize: 14.sp, height: 1.1),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 10.h),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Color(0xFF81a7f7),
                                              width: 4.w,
                                            ),
                                          ),
                                          child: ImageWidget(
                                            "",
                                            width: 88.w,
                                            height: 88.w,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/ic_gift.png",
                        width: 23.w,
                        height: 23.w,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "打赏",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 27.h),
                InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/ic_share.png",
                        width: 23.w,
                        height: 23.w,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "分享",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 69.h)
              ],
            ),
          ),
          SizedBox(width: 18.w)
        ],
      ),
    );
  }

  _buildTagWidget(String tag) {
    return CardWidget(
      padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 6.h, bottom: 6.h),
      margin: EdgeInsets.only(right: 6.w),
      circular: 12.w,
      color: Colors.black.withOpacity(0.3),
      child: Text(
        "# ${tag}",
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  //打赏网格组件
  Widget _buildRewardWidget(int money, GestureTapCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.r)),
          border: Border.all(
            color: Color(0xFF79A6FD),
            width: 0.5.w,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/ic_diamond.png",
              width: 24.w,
              height: 19.h,
            ),
            SizedBox(width: 6.w),
            Text(
              "${money}钻石",
              style: TextStyle(
                color: Color(0xFF79A6FD),
                fontSize: 14.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
