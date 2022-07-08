import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fold_wrap/fold_wrap.dart';
import 'package:video/widgets/common/appbar.dart';
import 'package:video/widgets/common/image.dart';
import 'package:video/widgets/video.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<String> _listHistory = [
    "关键词",
    "关键词关键词",
  ];
  final List<String> _listHot = [
    "关键词",
    "关键词关键词",
    "关键词关键词",
    "关键词",
    "关键词",
    "关键词关键词关键词",
  ];
  final List<VideoBean> _videoList = [
    VideoBean("", "520K", "520K", ""),
    VideoBean("", "520K", "520K", ""),
    VideoBean("", "520K", "520K", ""),
    VideoBean("", "520K", "520K", ""),
    VideoBean("", "520K", "520K", ""),
    VideoBean("", "520K", "520K", ""),
  ];
  List<VideoBean> _videoList1 = [];
  bool isSearch = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(
        backIconColor: Colors.black,
        backgroundColor: Colors.white,
        title: Text(
          "搜索",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: Column(
            children: [
              SizedBox(height: 21.h),
              Container(
                alignment: Alignment.center,
                height: 30.h,
                padding: EdgeInsets.only(left: 20.w),
                decoration: BoxDecoration(color: Color(0xFFF4F4F4), borderRadius: BorderRadius.all(Radius.circular(15.r))),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/ic_search.png",
                      width: 12.w,
                      height: 12.w,
                      color: Color(0xFF888888),
                    ),
                    SizedBox(width: 7.w),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.black, fontSize: 13.sp, height: 1.1),
                        decoration: InputDecoration(
                          hintText: "输入用户名、视频关键字",
                          hintStyle: TextStyle(
                            color: Color(0xFF888888),
                            fontSize: 13.sp,
                          ),
                          border: InputBorder.none,
                        ),
                        controller: searchController,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              searchController.text == "" ? _buildHistoryPage(_listHistory) : _buildHistoryEmpty(),
              _buildTitle("assets/images/ic_hot_search.png", "热门搜索"),
              SizedBox(height: 13.h),
              FoldWrap(
                children: List.generate(
                  _listHot.length,
                  (index) => _buildKeySearchWidget(_listHot[index]),
                ),
                spacing: 12.w,
                runSpacing: 12.h,
                extentHeight: 30,
              ),
              SizedBox(height: 17.h),
              _buildTitle("assets/images/ic_hot_search.png", "精选原创"),
              SizedBox(height: 20.h),
              Container(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 7,
                    crossAxisSpacing: 6,
                    childAspectRatio: 1.09 / 1.67,
                  ),
                  itemCount: _videoList.length,
                  itemBuilder: (context, index) => VideoWidget(
                    videoBean: _videoList[index],
                    onTap: () {},
                  ),
                ),
              ),
              SizedBox(height: 40.h)
            ],
          ),
        ),
      ),
    );
  }

  //搜索历史未搜索的页面
  _buildHistoryPage(List<String> listHistory) {
    return Column(
      children: [
        Row(
          children: [
            _buildTitle("assets/images/ic_history.png", "搜索历史"),
            const Spacer(),
            InkWell(
              child: Image.asset(
                "assets/images/ic_hot.png",
                width: 17.w,
                height: 17.w,
              ),
            ),
          ],
        ),
        SizedBox(height: 13.h),
        FoldWrap(
          children: List.generate(
            listHistory.length,
            (index) => _buildKeySearchWidget(listHistory[index]),
          ),
          spacing: 12.w,
          runSpacing: 12.h,
          extentHeight: 30,
        ),
        SizedBox(height: 17.h),
      ],
    );
  }

  //搜索历史为空的页面
  _buildHistoryEmpty() {
    return Padding(
      padding: EdgeInsets.only(left: 63.w, right: 63.w),
      child: Stack(
        children: [
          Image.asset("assets/images/ic_search_empty.png"),
          Container(
            height: 185.h,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "抱歉，没有发现相关内容",
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 11.h),
                  Text(
                    "换个关键词试试吧",
                    style: TextStyle(
                      color: Color(0xFF666666).withOpacity(0.75),
                      fontSize: 12.sp,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildKeySearchWidget(String keySearch) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 5.w, bottom: 5.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.w), color: Color(0xFFEDEDED)),
      child: Text(
        keySearch,
        style: TextStyle(color: Color(0xFF888888), fontSize: 12.sp, height: 1.1),
      ),
    );
  }

  _buildTitle(String imageUrl, String title) {
    return Row(
      children: [
        Image.asset(
          imageUrl,
          width: 18.w,
          height: 18.w,
        ),
        SizedBox(width: 7.w),
        Text(
          title,
          style: TextStyle(
            color: Color(0xFF1C1C1C),
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}

class VideoBean {
  String imageUrl;
  String loveNum;
  String playNum;
  String title;

  VideoBean(this.imageUrl, this.loveNum, this.playNum, this.title);
}
