import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStatusContainer extends StatelessWidget {
  const AppStatusContainer({
    super.key,
    required this.status,
    required this.child,
  });

  final String status;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.w),
      decoration: BoxDecoration(
        color: status == 'pending'
            ? Colors.orange
            : status == 'approved'
                ? Colors.green
                : status == 'rejected'
                    ? Colors.red
                    : status == 'completed'
                        ? Colors.blue
                        : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
