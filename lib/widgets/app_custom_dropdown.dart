import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final String label;
  final String placeholder;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final String Function(T) itemToString;
  final String Function(T) itemDisplayText;
  final String? emptyMessage;
  final bool showClear;

  const AppCustomDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.label,
    required this.placeholder,
    required this.onChanged,
    required this.itemToString,
    required this.itemDisplayText,
    this.validator,
    this.emptyMessage,
    this.showClear = false,
  });

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).colorScheme.primary;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //  reusableText(label),
        SizedBox(
          height: 8.h,
        ),
        Container(
          constraints: BoxConstraints(
            minHeight: 50.h,
          ),
          child: items.isEmpty
              ? Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primary,
                    ),
                    borderRadius: BorderRadius.circular(12.w),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          emptyMessage ?? "No items available",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 30.sp,
                        color: primary,
                      )
                    ],
                  ),
                )
              : DropdownButtonFormField<T>(
                  decoration: InputDecoration(
                      helperStyle: TextStyle(
                        color: primary,
                      ),
                      labelStyle: TextStyle(
                        color: primary,
                      ),
                      hintStyle: TextStyle(
                        color: primary,
                      )),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  value: value,
                  icon: GestureDetector(
                      onTap: (value == null || !showClear)
                          ? null
                          : () {
                              onChanged(null);
                            },
                      child: SizedBox(
                        height: 20.w,
                        width: 20.w,
                        child: Icon(
                          value != null && showClear
                              ? Icons.close_outlined
                              : Icons.keyboard_arrow_down_outlined,
                          size: 30.sp,
                          color: primary,
                        ),
                      )),
                  hint: Text(
                    placeholder,
                    style: TextStyle(
                      color: primary,
                    ),
                  ),
                  onChanged: (T? newValue) {
                    onChanged(newValue);
                  },
                  validator: validator,
                  items: items.asMap().entries.map((entry) {
                    final item = entry.value;
                    return DropdownMenuItem<T>(
                      value: item,
                      child: Text(
                        itemDisplayText(item),
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    );
                  }).toList(),
                ),
        ),
      ],
    );
  }
}
