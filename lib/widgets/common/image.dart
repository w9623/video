import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildAvatarWidget({String? url, double? size, String? asset}) {
  return ImageWidget(
    url,
    width: size,
    height: size,
    circular: size == null ? 0 : size / 2 + 1,
    defaultAsset: asset ?? 'assets/images/ic_un_login_head.png',
  );
}

class ImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final double? circular;
  final Color? progressColor;
  final BoxFit? fit;
  final String? defaultAsset;

  const ImageWidget(
    this.imageUrl, {
    key,
    this.width,
    this.height,
    this.circular,
    this.progressColor,
    this.fit,
    this.defaultAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      child: ClipRRect(
        // 圆角效果
        borderRadius: BorderRadius.circular(circular ?? 0),
        child: imageUrl?.isNotEmpty == true
            ? CachedNetworkImage(
                fit: fit ?? BoxFit.cover,
                imageUrl: imageUrl ?? 'http://via.placeholder.com/640x480',
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progressColor ?? const Color(0xFF666666),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) =>
                    defaultAsset?.isNotEmpty == true
                        ? Image.asset(
                            defaultAsset ?? '',
                            width: width ?? double.infinity,
                            height: height ?? double.infinity,
                          )
                        : Icon(
                            Icons.error,
                            color: Colors.black.withOpacity(0.7),
                            size: 15.w,
                          ),
              )
            : defaultAsset?.isNotEmpty == true
                ? Image.asset(
                    defaultAsset ?? '',
                    width: width ?? double.infinity,
                    height: height ?? double.infinity,
                  )
                : Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progressColor ?? const Color(0xFF666666),
                      ),
                    ),
                  ),
      ),
    );
  }
}

class ImageWidget2 extends StatelessWidget {
  final double circular;
  final String? url;
  final Color? progressColor;
  final double? width;
  final double? height;

  const ImageWidget2({
    Key? key,
    this.circular = 0,
    this.url,
    this.progressColor,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(circular),
      child: SizedBox(
        width: width,
        height: height,
        child: url?.isNotEmpty == true
            ? CachedNetworkImage(
                imageUrl: url ?? 'http://via.placeholder.com/640x480',
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progressColor ?? const Color(0xFF666666),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Colors.black.withOpacity(0.7),
                  size: 15.w,
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    progressColor ?? const Color(0xFF666666),
                  ),
                ),
              ),
      ),
    );
  }
}
