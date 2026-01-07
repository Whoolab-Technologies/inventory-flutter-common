import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AppSearchField extends StatefulWidget {
  const AppSearchField({
    super.key,
    required this.hintText,
    required this.onChange,
    this.suffixIcon,
  });

  final Widget? suffixIcon;
  final String hintText;
  final Function(String?) onChange;

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  late Color primaryColor;
  final TextEditingController _searchController = TextEditingController();
  final _searchSubject = BehaviorSubject<String>();
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();

    _searchSubject
        .debounceTime(const Duration(milliseconds: 500))
        .distinct()
        .skip(1)
        .listen((query) {
      widget.onChange(query);
    });

    _searchController.addListener(() {
      _searchSubject.add(_searchController.text);
      setState(() {
        _showClearButton = _searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    primaryColor = Theme.of(context).colorScheme.primary;

    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: widget.hintText,
        suffixIcon: _showClearButton
            ? SizedBox(
                height: kMinInteractiveDimension, // Ensures proper alignment
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Keeps the row compact
                  children: [
                    IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _showClearButton = false;
                        });
                      },
                      icon: const Icon(Icons.clear_outlined),
                    ),
                    if (widget.suffixIcon != null) widget.suffixIcon!,
                  ],
                ),
              )
            : widget.suffixIcon,
      ),
    );
  }
}
