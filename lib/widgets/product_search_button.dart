import 'package:flutter/material.dart';
import 'package:mvp_shared_components/widgets/app_search_field.dart';
import 'package:mvp_shared_components/widgets/qr_code_scanner_page.dart';

class ProductSearchField extends StatelessWidget {
  const ProductSearchField({
    super.key,
    required this.onChange,
    required this.onDecode,
    this.hintText,
  });
  final Function(String?) onChange;
  final String? hintText;
  final Function(String decodedString) onDecode;
  @override
  Widget build(BuildContext context) {
    return AppSearchField(
      hintText: hintText ?? "Search Product",
      suffixIcon: _buildScannerButton(context),
      onChange: onChange,
    );
  }

  Widget _buildScannerButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.qr_code_scanner,
        color: Theme.of(context).colorScheme.primary,
      ),
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (cxt) {
            return QRCodeScannerPage(onDecode: onDecode);
          }),
        );
      },
    );
  }
}
