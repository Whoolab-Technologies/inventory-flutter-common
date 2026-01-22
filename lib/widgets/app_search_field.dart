import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AppSearchField extends StatefulWidget {
  const AppSearchField({
    super.key,
    required this.hintText,
    required this.onChange,
    this.suffixIcon,
    this.controller,
  });

  final Widget? suffixIcon;
  final String hintText;
  final Function(String?) onChange;
  final TextEditingController? controller;

  @override
  State<AppSearchField> createState() => AppSearchFieldState();
}

class AppSearchFieldState extends State<AppSearchField> {
  late final TextEditingController _searchController;
  final _searchSubject = BehaviorSubject<String>();
  bool _showClearButton = false;
  bool _suppressOnChange = false;

  @override
  void initState() {
    super.initState();
    _searchController = widget.controller ?? TextEditingController();

    _searchSubject
        .debounceTime(const Duration(milliseconds: 500))
        .distinct()
        .listen((query) => widget.onChange(query));

    _searchController.addListener(_handleControllerChange);
  }

  void _handleControllerChange() {
    // ALWAYS update the clear button state
    final hasText = _searchController.text.isNotEmpty;
    if (_showClearButton != hasText) {
      setState(() {
        _showClearButton = hasText;
      });
    }

    // ONLY trigger search logic if not suppressed
    if (!_suppressOnChange) {
      _searchSubject.add(_searchController.text);
    }
  }

  void setTextSilently(String value) {
    _suppressOnChange = true;
    _searchController.text = value;
    _searchController.selection = TextSelection.collapsed(offset: value.length);

    // We force a rebuild here to ensure the Clear Icon appears immediately
    setState(() {
      _showClearButton = value.isNotEmpty;
    });

    Future.microtask(() => _suppressOnChange = false);
  }

  @override
  void dispose() {
    if (widget.controller == null) _searchController.dispose();
    _searchSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: widget.hintText,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (_showClearButton)
              IconButton(
                onPressed: () {
                  _searchController.clear();
                  widget.onChange("");
                },
                icon: const Icon(Icons.clear),
              ),
            if (widget.suffixIcon != null) widget.suffixIcon!,
          ],
        ),
      ),
    );
  }
}
