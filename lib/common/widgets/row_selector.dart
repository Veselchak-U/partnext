import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';

class RowSelector<T> extends StatefulWidget {
  final String label;
  final List<T> items;
  final Function(T) onSelect;
  final T? selectedItem;

  const RowSelector({
    required this.label,
    required this.items,
    required this.onSelect,
    this.selectedItem,
    super.key,
  });

  @override
  State<RowSelector> createState() => RowSelectorState<T>();
}

class RowSelectorState<T> extends State<RowSelector<T>> {
  final _selectedIndex = ValueNotifier<int>(-1);

  @override
  void initState() {
    super.initState();

    final selectedItem = widget.selectedItem;
    if (selectedItem != null) {
      _selectedIndex.value = widget.items.indexOf(selectedItem);
    }
  }

  void _onSelect(T item, int index) {
    _selectedIndex.value = index;
    widget.onSelect(item);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTextStyles.s14w400,
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            widget.items.length,
            (index) {
              final item = widget.items[index];

              return ValueListenableBuilder(
                valueListenable: _selectedIndex,
                builder: (context, selectedIndex, _) {
                  final selected = selectedIndex == index;
                  final foreground = selected ? AppColors.white : AppColors.primary;
                  final background = selected ? AppColors.primary : AppColors.white;
                  final borderRadius = BorderRadius.circular(8).r;

                  return Material(
                    color: background,
                    borderRadius: borderRadius,
                    child: InkWell(
                      borderRadius: borderRadius,
                      onTap: () => _onSelect(item, index),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                        child: Text(
                          '$item',
                          style: AppTextStyles.s14w400.copyWith(color: foreground),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
