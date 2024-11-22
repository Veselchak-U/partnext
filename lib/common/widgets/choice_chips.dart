import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';

class ChoiceChips<T> extends StatefulWidget {
  final List<T> items;
  final Function(T, bool) onTap;
  final List<T> selectedItems;

  const ChoiceChips({
    required this.items,
    required this.onTap,
    this.selectedItems = const [],
    super.key,
  });

  @override
  State<ChoiceChips<T>> createState() => _ChoiceChipsState<T>();
}

class _ChoiceChipsState<T> extends State<ChoiceChips<T>> {
  final List<T> selectedItems = [];

  @override
  void initState() {
    super.initState();
    selectedItems.addAll(widget.selectedItems);
  }

  void onSelected(T item, bool selected) {
    setState(() {
      if (selected) {
        selectedItems.add(item);
      } else {
        selectedItems.remove(item);
      }
    });

    widget.onTap(item, selected);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 11.w,
      runSpacing: 8.h,
      children: List.generate(
        widget.items.length,
        (index) {
          final item = widget.items[index];
          final selected = selectedItems.contains(item);

          return ChoiceChip(
            label: Text('$item'),
            labelStyle: selected ? AppTextStyles.s12w600.copyWith(color: AppColors.white) : AppTextStyles.s12w400,
            labelPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
            showCheckmark: false,
            selected: selected,
            onSelected: (selected) => onSelected(item, selected),
          );
        },
      ),
    );
  }
}
