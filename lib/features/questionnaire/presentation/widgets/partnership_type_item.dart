import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partnext/app/assets/assets.gen.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_shadows.dart';
import 'package:partnext/common/form_fields/app_check_box.dart';

class PartnershipTypeItem extends StatefulWidget {
  final String label;
  final bool selected;
  final Function(bool) onSelect;

  const PartnershipTypeItem({
    required this.label,
    required this.selected,
    required this.onSelect,
    super.key,
  });

  @override
  State<PartnershipTypeItem> createState() => _PartnershipTypeItemState();
}

class _PartnershipTypeItemState extends State<PartnershipTypeItem> {
  OverlayEntry _overlayEntry = OverlayEntry(builder: (_) => const SizedBox.shrink());
  bool selected = false;

  void _onSelect() {
    setState(() {
      selected = !selected;
      widget.onSelect(selected);
    });
  }

  void _openDescription() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        final size = MediaQuery.of(context).size;

        return Positioned(
          width: 56,
          height: 56,
          top: size.height - 72,
          left: size.width - 72,
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: _overlayEntry.remove,
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.redAccent),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8).r;

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 250),
      child: Container(
        key: ValueKey(selected),
        height: 48.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: borderRadius,
          boxShadow: selected ? [AppShadows.questionnaireItem] : null,
        ),
        child: Material(
          borderRadius: borderRadius,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: _onSelect,
            child: Row(
              children: [
                Expanded(
                  child: AppCheckBox(
                    label: widget.label,
                    checked: selected,
                    onChanged: (_) => _onSelect(),
                  ),
                ),
                IconButton(
                  onPressed: _openDescription,
                  icon: SvgPicture.asset(
                    Assets.icons.questionMark.path,
                    width: 24.r,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
