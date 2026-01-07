import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef DisplayStringForOption<T> = String Function(T option);
typedef OnChanged<T> = void Function(T? value);
typedef OnAddItem<T> = T Function(String value);
final double searchFieldHeight = 60.h;
final double itemHeight = 48.h;
final double maxDropdownHeight = 300.h;

class GenericSearchableDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final DisplayStringForOption<T?> displayStringForOption;
  final DisplayStringForOption<T?>? displaySubStringForOption;
  final bool Function(T item, String query) matchItem;
  final OnChanged<T?> onChanged;
  final String hintText;
  final String searchHint;
  final OnAddItem<T>? onAddItem;
  final Decoration? decoration;
  final bool canAddNewItems;
  const GenericSearchableDropdown({
    super.key,
    required this.items,
    this.selectedItem,
    required this.displayStringForOption,
    this.displaySubStringForOption,
    required this.onChanged,
    required this.matchItem,
    this.hintText = 'Select an item',
    this.searchHint = 'search',
    this.onAddItem,
    this.decoration,
    this.canAddNewItems = false,
  }) : assert(
          !canAddNewItems || onAddItem != null,
          'onAddItem must be provided when canAddNewItems is true',
        );

  @override
  State<GenericSearchableDropdown<T>> createState() =>
      _GenericSearchableDropdownState<T>();
}

class _GenericSearchableDropdownState<T>
    extends State<GenericSearchableDropdown<T>> {
  late List<T> _filteredItems;
  late List<T> _allItems;
  bool _isDropdownOpened = false;
  late T? _selectedItem;
  final TextEditingController _searchController = TextEditingController();

  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  final _fousNode = FocusNode();

  @override
  void didUpdateWidget(covariant GenericSearchableDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items != oldWidget.items ||
        widget.selectedItem != oldWidget.selectedItem) {
      _allItems = List<T>.from(widget.items);
      _filteredItems = List<T>.from(_allItems);
      _selectedItem = widget.selectedItem;
      // _overlayEntry?.markNeedsBuild();
    }
  }

  @override
  void initState() {
    super.initState();
    _allItems = List<T>.from(widget.items);
    _filteredItems = List<T>.from(_allItems);
    _selectedItem = widget.selectedItem;
    _fousNode.addListener(() {
      if (_fousNode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 300),
            alignment: maxDropdownHeight,
            curve: Curves.easeInOut,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _fousNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _toggleDropdown() {
    if (_isDropdownOpened) {
      _fousNode.unfocus();
      _removeOverlay();
      setState(() {
        _isDropdownOpened = false;
        _searchController.clear();
        _filteredItems = List<T>.from(_allItems);
      });
    } else {
      _fousNode.unfocus();
      _insertOverlay();
      setState(() {
        _isDropdownOpened = true;
      });
    }
  }

  void _insertOverlay() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.of(context).size.height;

    _overlayEntry = OverlayEntry(builder: (context) {
      final searchText = _searchController.text;

      final bool canAddNew = widget.canAddNewItems &&
          searchText.isNotEmpty &&
          !_allItems.any((item) =>
              widget.displayStringForOption(item).toLowerCase() ==
              searchText.toLowerCase());

      final int listLength = _filteredItems.isEmpty && !canAddNew
          ? 0
          : _filteredItems.length + (canAddNew ? 1 : 0);

      final int itemCount = listLength + 1;
      final spaceBelow = screenHeight - offset.dy - size.height;
      final spaceAbove = offset.dy;
      final double calculatedHeight = math.min(
          searchFieldHeight + (itemCount * itemHeight), maxDropdownHeight);
      final bool showAbove =
          spaceBelow < calculatedHeight && spaceAbove > spaceBelow;

      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _toggleDropdown,
        child: Stack(
          children: [
            Positioned(
              width: size.width,
              left: offset.dx,
              top: showAbove ? null : offset.dy + size.height + 5.0,
              bottom: showAbove ? screenHeight - offset.dy + 5.0 : null,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0,
                    showAbove ? -calculatedHeight - 5.0 : size.height + 5.0),
                child: _buildDropdown(
                    context, calculatedHeight, listLength, canAddNew),
              ),
            ),
          ],
        ),
      );
    });

    Overlay.of(context).insert(_overlayEntry!);
  }
  // void _insertOverlay() {
  //   RenderBox renderBox = context.findRenderObject() as RenderBox;
  //   Size size = renderBox.size;

  //   _overlayEntry = OverlayEntry(
  //     builder: (context) => GestureDetector(
  //       // Detect taps outside dropdown to close it
  //       behavior: HitTestBehavior.translucent,
  //       onTap: () {
  //         _toggleDropdown();
  //       },
  //       child: Stack(
  //         children: [
  //           Positioned.fill(
  //             child: Container(
  //               color: Colors.transparent,
  //             ),
  //           ),
  //           Positioned(
  //             width: size.width,
  //             child: CompositedTransformFollower(
  //               link: _layerLink,
  //               showWhenUnlinked: false,
  //               offset: Offset(0.0, size.height + 5.0),
  //               child: _buildDropdown(context),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );

  //   Overlay.of(context).insert(_overlayEntry!);
  // }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = List<T>.from(_allItems);
      } else {
        _filteredItems =
            _allItems.where((item) => widget.matchItem(item, query)).toList();
      }
    });
    _overlayEntry?.markNeedsBuild();
  }

  void _selectItem(T item) {
    setState(() {
      _selectedItem = item;
      widget.onChanged(_selectedItem);
      _searchController.clear();
      _filteredItems = List<T>.from(_allItems);
      _toggleDropdown();
    });
  }

  void _clearSelected() {
    setState(() {
      _selectedItem = null;
      widget.onChanged(null);
    });
  }

  void _addNewItem(String newValue) {
    if (widget.onAddItem != null) {
      T newItem = widget.onAddItem!(newValue.trim());
      setState(() {
        _allItems.add(newItem);
        _selectItem(newItem);
      });
    }
  }

  Widget _buildDropdown(BuildContext context, double calculatedHeight,
      int listLength, bool canAddNew) {
    final textTheme = Theme.of(context).textTheme;
    final searchText = _searchController.text;

    if (listLength == 0) {
      return Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'No items found',
                style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
              SizedBox(height: 8.h),
              _buildSearchField(),
            ],
          ),
        ),
      );
    }

    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(6),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: calculatedHeight.h,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSearchField(),
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: listLength,
                  itemBuilder: (context, index) {
                    if (canAddNew) {
                      if (index == 0) {
                        return ListTile(
                          leading: const Icon(Icons.add),
                          title: Text('Add "$searchText"'),
                          onTap: () => _addNewItem(searchText),
                        );
                      }
                      final itemIndex = index - 1;
                      if (itemIndex >= 0 && itemIndex < _filteredItems.length) {
                        final item = _filteredItems[itemIndex];
                        return ListTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.displayStringForOption(item)),
                            ],
                          ),
                          onTap: () => _selectItem(item),
                        );
                      }
                    } else {
                      if (index >= 0 && index < _filteredItems.length) {
                        final item = _filteredItems[index];
                        return ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.displayStringForOption(item),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              if (widget.displaySubStringForOption != null)
                                Text(
                                  widget.displaySubStringForOption!(item),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                            ],
                          ),
                          onTap: () => _selectItem(item),
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: TextField(
        focusNode: _fousNode,
        controller: _searchController,
        decoration: InputDecoration(
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          hintText: widget.searchHint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _onSearchChanged('');
                  },
                )
              : null,
        ),
        onChanged: _onSearchChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayString = _selectedItem == null
        ? widget.hintText
        : widget.displayStringForOption(_selectedItem!);

    final theme = Theme.of(context);

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: widget.decoration ??
              BoxDecoration(
                color: Theme.of(context).colorScheme.primaryFixed,
                borderRadius: BorderRadius.circular(12.w),
              ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  displayString,
                  style: _selectedItem == null
                      ? TextStyle(color: Colors.grey, fontSize: 12.sp)
                      : theme.textTheme.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (_selectedItem != null)
                GestureDetector(
                  onTap: () {
                    _clearSelected();
                    if (_isDropdownOpened) {
                      _toggleDropdown();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.clear,
                      size: 20,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              Icon(
                _isDropdownOpened ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Colors.grey.shade700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
