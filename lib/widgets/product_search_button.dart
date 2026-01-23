import 'package:flutter/material.dart';
import 'package:mvp_shared_components/widgets/app_search_field.dart';
import 'package:mvp_shared_components/widgets/qr_code_scanner_page.dart';

class ProductSearchField extends StatefulWidget {
  const ProductSearchField({
    super.key,
    required this.onChange,
    required this.onDecode,
    this.hintText,
  });

  final Function(String?) onChange;
  final Function(String) onDecode;
  final String? hintText;

  @override
  State<ProductSearchField> createState() => _ProductSearchFieldState();
}

class _ProductSearchFieldState extends State<ProductSearchField> {
  final GlobalKey<AppSearchFieldState> _searchKey = GlobalKey();

  void _openScanner(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (cxt) => QRCodeScannerPage(
          onDecode: (decodedValue) {
            _searchKey.currentState?.setTextSilently(decodedValue);
            widget.onDecode(decodedValue);
            FocusScope.of(context).unfocus();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppSearchField(
      key: _searchKey,
      hintText: widget.hintText ?? "Search Product",
      onChange: widget.onChange,
      suffixIcon: IconButton(
        icon:
            Icon(Icons.qr_code_scanner, color: Theme.of(context).primaryColor),
        onPressed: () => _openScanner(context),
      ),
    );
  }
}
