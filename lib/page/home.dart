import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video/widgets/common/indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  List<String> tabTextList = ["推荐", "关注"];
  List<Tab> tabWidgetList = [];
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    for (var value in tabTextList) {
      tabWidgetList.add(Tab(
        text: "$value",
      ));
    }
    tabController = new TabController(length: tabTextList.length, vsync: this);
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
              color: Colors.black,
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
        child: Text("$value",style: TextStyle(color: Colors.white),),
      ))
          .toList(),
    );
  }

  //构建顶部标签部分
  buildTabBarWidget() {
    return Row(
      children: [
        Container(),
        Container(
          margin: EdgeInsets.only(top: 19.5.h),
          ///对齐在顶部中间
          alignment: Alignment.topCenter,
          child: TabBar(
            controller: tabController,
            tabs: tabWidgetList,
            isScrollable: true,
            ///指示器的宽度与文字对齐
            indicatorSize: TabBarIndicatorSize.label,
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
            unselectedLabelStyle: TextStyle(
              fontSize: 15.sp
            ),
          ),
        ),
      ],
    );
  }

}
