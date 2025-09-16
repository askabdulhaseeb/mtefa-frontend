import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Enhanced dropdown with add new entry functionality
/// Features a "+" icon that opens a dialog to add new entries to the dropdown
class CustomDropdownWithAdd<T> extends StatefulWidget {
  const CustomDropdownWithAdd({
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.onAddNew,
    this.validator,
    this.isSearchable = true,
    this.hint,
    this.addNewButtonText = 'Add New',
    this.addDialogTitle = 'Add New Entry',
    super.key,
  });

  final String title;
  final List<DropdownMenuItem<T>> items;
  final T? selectedItem;
  final void Function(T?) onChanged;
  final Future<T?> Function() onAddNew;
  final String? Function(T?)? validator;
  final bool isSearchable;
  final String? hint;
  final String addNewButtonText;
  final String addDialogTitle;

  @override
  State<CustomDropdownWithAdd<T>> createState() => _CustomDropdownWithAddState<T>();
}

class _CustomDropdownWithAddState<T> extends State<CustomDropdownWithAdd<T>> {
  List<DropdownMenuItem<T>> _items = [];

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
  }

  @override
  void didUpdateWidget(CustomDropdownWithAdd<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _items = List.from(widget.items);
    }
  }

  Future<void> _handleAddNew() async {
    try {
      final T? newItem = await widget.onAddNew();
      if (newItem != null && mounted) {
        // The parent should handle adding the new item to the list
        // and updating the selectedItem if needed
        setState(() {
          _items = List.from(widget.items);
        });
        widget.onChanged(newItem);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding new item: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: theme.hintColor),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<T>(
                    isExpanded: true,
                    hint: Text(
                      widget.hint ?? 'select_item'.tr(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.hintColor,
                      ),
                    ),
                    items: _items,
                    value: widget.selectedItem,
                    onChanged: widget.onChanged,
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      height: 48,
                    ),
                    dropdownSearchData: widget.isSearchable
                        ? DropdownSearchData<T>(
                            searchInnerWidgetHeight: 50,
                            searchInnerWidget: Container(
                              height: 50,
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  hintText: 'Search...',
                                  hintStyle: const TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            searchMatchFn: (item, searchValue) {
                              return item.value
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchValue.toLowerCase());
                            },
                          )
                        : null,
                    menuItemStyleData: const MenuItemStyleData(height: 40),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: IconButton(
                onPressed: _handleAddNew,
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                tooltip: widget.addNewButtonText,
              ),
            ),
          ],
        ),
      ],
    );
  }
}