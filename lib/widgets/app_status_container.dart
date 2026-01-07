import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvp_shared_components/core/extensions.dart';
import 'package:mvp_shared_components/core/models/status/status.dart';

class AppStatusContainer extends StatelessWidget {
  const AppStatusContainer({
    super.key,
    required this.status,
    this.text,
    this.textStyle,
    this.child,
  });

  final Status status;
  final String? text;
  final TextStyle? textStyle;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.w),
      decoration: BoxDecoration(
        color: status.color.toColor(),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: child ??
          Text(
            text ?? status.name,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: textStyle ??
                TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
          ),
    );
  }
}
