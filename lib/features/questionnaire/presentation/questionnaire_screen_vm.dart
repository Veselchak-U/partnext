import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/features/questionnaire/data/model/questionnaire_api_model.dart';
import 'package:partnext/features/questionnaire/domain/model/partnership_type.dart';

class QuestionnaireScreenVm {
  final BuildContext _context;

  QuestionnaireScreenVm(
    this._context,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);

  final pageController = PageController();

  final firstFormKey = GlobalKey<FormState>();

  OverlayEntry? _overlayEntry;

  QuestionnaireApiModel _questionnaire = QuestionnaireApiModel();

  void _init() {}

  void dispose() {
    loading.dispose();

    pageController.dispose();
  }

  void openPartnershipTypeDescription(BuildContext context, PartnershipType item) {
    if (_overlayEntry != null) {
      closeItemDescription();
    }

    final renderBox = context.findRenderObject() as RenderBox?;
    final hPadding = 52.h;
    final offset = renderBox?.localToGlobal(Offset(0, hPadding));
    if (offset == null) return;

    final overlayEntry = OverlayEntry(
      builder: (context) {
        final wPadding = 32.r;
        final width = MediaQuery.of(context).size.width - wPadding * 2;

        return Positioned.directional(
          textDirection: _context.locale.isLtr ? TextDirection.ltr : TextDirection.rtl,
          width: width,
          top: offset.dy,
          end: offset.dx,
          child: GestureDetector(
            onTap: closeItemDescription,
            child: Material(
              borderRadius: BorderRadius.circular(8).r,
              color: AppColors.white.withOpacity(1),
              shadowColor: AppColors.shadow,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16).r,
                child: Text(
                  PartnershipTypeHelper.getWhoIAmDescription(item),
                  style: AppTextStyles.s10w400,
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(overlayEntry);
    _overlayEntry = overlayEntry;
  }

  void closeItemDescription() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void onMyPartnershipTypeSelected(
    PartnershipType item,
    bool selected,
  ) {
    closeItemDescription();

    final types = [..._questionnaire.myPartnershipTypes];
    if (selected) {
      types.add(item);
    } else {
      types.remove(item);
    }

    _questionnaire = _questionnaire.copyWith(myPartnershipTypes: types);
  }

  void onNextPage() {}

  void _goNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.decelerate,
    );
  }

  void goPreviousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.decelerate,
    );
  }

  void _setLoading(bool value) {
    if (!_context.mounted) return;
    loading.value = value;
  }

  void _onError(String message) {
    if (!_context.mounted) return;
    AppOverlays.showErrorBanner(message);
  }
}
