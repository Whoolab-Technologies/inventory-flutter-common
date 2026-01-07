import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagePickerButton extends StatelessWidget {
  const ImagePickerButton(
      {super.key, required this.selectedFiles, required this.onImagesSelected});
  final List<Map<String, dynamic>> selectedFiles;
  final Future<void> Function() onImagesSelected;
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(12.w),
        onTap: onImagesSelected,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.w),
            border: Border.all(color: Theme.of(context).colorScheme.primary),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Selected Files: ${selectedFiles.length}",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: onImagesSelected,
                icon: Icon(
                  Icons.add_a_photo,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
