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

  const AppCustomDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.label,
    required this.placeholder,
    required this.onChanged,
    this.validator,
    required this.itemToString,
    required this.itemDisplayText,
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
          child: DropdownButtonFormField<T>(
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
            icon: Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 30.sp,
              color: primary,
            ),
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
            items: items.map((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(
                  itemDisplayText(item),
                  style: TextStyle(
                    fontSize: 16.sp,
                  ), // Adjust font size as needed
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
