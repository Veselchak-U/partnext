import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/common/widgets/row_selector.dart';
import 'package:partnext/features/questionnaire/data/model/questionnaire_api_model.dart';
import 'package:partnext/features/questionnaire/data/repository/questionnaire_repository.dart';
import 'package:partnext/features/questionnaire/domain/model/experience_duration.dart';
import 'package:partnext/features/questionnaire/domain/model/interest_type.dart';
import 'package:partnext/features/questionnaire/domain/model/partnership_type.dart';
import 'package:partnext/features/questionnaire/presentation/widgets/partnership_description_overlay.dart';

class QuestionnaireScreenVm {
  final BuildContext _context;
  final QuestionnaireRepository _questionnaireRepository;

  QuestionnaireScreenVm(
    this._context,
    this._questionnaireRepository,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final isFirstPage = ValueNotifier<bool>(true);
  final isLastPage = ValueNotifier<bool>(false);
  final photos = ValueNotifier<List<String>>(List<String>.filled(4, ''));
  final currentPhotoIndex = ValueNotifier<int>(0);

  final pageController = PageController();

  final fifthFormKey = GlobalKey<FormState>();
  final experienceKey = GlobalKey<RowSelectorState>();

  OverlayEntry? _overlayEntry;

  QuestionnaireApiModel _questionnaire = QuestionnaireApiModel();

  void _init() {}

  void dispose() {
    loading.dispose();
    isFirstPage.dispose();
    isLastPage.dispose();
    photos.dispose();
    currentPhotoIndex.dispose();

    pageController.dispose();
  }

  void openOverlay(
    BuildContext context, {
    required String text,
  }) {
    if (_overlayEntry != null) {
      closeOverlay();
    }

    final overlayEntry = PartnershipDescriptionOverlay(
      context,
      text: text,
      onTap: closeOverlay,
    ).build();
    if (overlayEntry == null) return;

    Overlay.of(context).insert(overlayEntry);
    _overlayEntry = overlayEntry;
  }

  void closeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void onMyPartnershipTypeSelected(PartnershipType item, bool selected) {
    closeOverlay();

    final types = [..._questionnaire.myPartnershipTypes];
    if (selected) {
      types.add(item);
    } else {
      types.remove(item);
    }

    _questionnaire = _questionnaire.copyWith(myPartnershipTypes: types);
  }

  void onPartnerPartnershipTypeSelected(PartnershipType item, bool selected) {
    closeOverlay();

    final types = [..._questionnaire.partnerPartnershipTypes];
    if (selected) {
      types.add(item);
    } else {
      types.remove(item);
    }

    _questionnaire = _questionnaire.copyWith(partnerPartnershipTypes: types);
  }

  void onSelectMyInterest(InterestType item, bool selected) {
    final interests = [..._questionnaire.myInterests];
    if (selected) {
      interests.add(item);
    } else {
      interests.remove(item);
    }

    _questionnaire = _questionnaire.copyWith(myInterests: interests);
  }

  void onSelectPartnerInterest(InterestType item, bool selected) {
    final interests = [..._questionnaire.partnerInterests];
    if (selected) {
      interests.add(item);
    } else {
      interests.remove(item);
    }

    _questionnaire = _questionnaire.copyWith(partnerInterests: interests);
  }

  void onPositionChanged(String value) {
    _questionnaire = _questionnaire.copyWith(position: value);
  }

  void onPartnershipDescriptionChanged(String value) {
    _questionnaire = _questionnaire.copyWith(partnershipDescription: value);
  }

  void onBioChanged(String value) {
    _questionnaire = _questionnaire.copyWith(bio: value);
  }

  void onExperienceSelected(ExperienceDuration value) {
    _questionnaire = _questionnaire.copyWith(experience: value);
  }

  void onProfileUrlChanged(String value) {
    _questionnaire = _questionnaire.copyWith(profileUrl: value);
  }

  void onTapImage(int index) {
    final path = photos.value[index];
    if (path == '') {
      addImage(index);
    } else {
      setCurrentImage(index);
    }
  }

  Future<void> addImage(int index) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final newList = [...photos.value];
    newList[index] = image.path;
    photos.value = newList;

    setCurrentImage(index);
  }

  void removeImage(int index) {
    final newList = [...photos.value];
    newList[index] = '';
    photos.value = newList;
  }

  void setCurrentImage(int index) {
    currentPhotoIndex.value = index;
  }

  void onNextPage() {
    final currentPage = pageController.page?.round();
    if (currentPage == null) return;

    FocusScope.of(_context).unfocus();
    closeOverlay();

    final bool checkResult = switch (currentPage) {
      0 => _firstPageCheck(),
      1 => _secondPageCheck(),
      2 => _thirdPageCheck(),
      3 => _fourthPageCheck(),
      4 => _fifthPageCheck(),
      5 => _sixthPageCheck(),
      _ => false,
    };
    if (!checkResult) return;

    _goNextPage();
  }

  bool _firstPageCheck() {
    final filled = _questionnaire.myPartnershipTypes.isNotEmpty;
    if (!filled) {
      _onError(_context.l10n.select_at_least_one_item);
    }

    return filled;
  }

  bool _secondPageCheck() {
    final filled = _questionnaire.partnerPartnershipTypes.isNotEmpty;
    if (!filled) {
      _onError(_context.l10n.select_at_least_one_item);
    }

    return filled;
  }

  bool _thirdPageCheck() {
    final filled = _questionnaire.myInterests.isNotEmpty;
    if (!filled) {
      _onError(_context.l10n.select_at_least_one_item);
    }

    return filled;
  }

  bool _fourthPageCheck() {
    final filled = _questionnaire.partnerInterests.isNotEmpty;
    if (!filled) {
      _onError(_context.l10n.select_at_least_one_item);
    }

    return filled;
  }

  bool _fifthPageCheck() {
    final invalidFields = fifthFormKey.currentState?.validateGranularly();
    if (invalidFields != null && invalidFields.isNotEmpty) {
      Scrollable.ensureVisible(invalidFields.first.context);

      return false;
    }

    if (_questionnaire.experience == null) {
      _onError(_context.l10n.specify_amount_of_experience);

      final experienceContext = experienceKey.currentContext;
      if (experienceContext != null) {
        Scrollable.ensureVisible(experienceContext);
      }

      return false;
    }

    return true;
  }

  bool _sixthPageCheck() {
    final notEmptyPhotos = photos.value.where((e) => e != '').toList();
    if (notEmptyPhotos.length < 2) {
      _onError(_context.l10n.add_least_2_photos_to_continue);

      return false;
    }

    return true;
  }

  Future<void> _goNextPage() async {
    if (isLastPage.value) {
      _sendQuestionnaire();

      return;
    }

    await pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.decelerate,
    );

    isFirstPage.value = false;
    isLastPage.value = pageController.page == 5;
  }

  Future<void> onPreviousPage() async {
    FocusScope.of(_context).unfocus();
    closeOverlay();

    await pageController.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.decelerate,
    );

    isFirstPage.value = pageController.page == 0;
    isLastPage.value = false;
  }

  Future<void> _sendQuestionnaire() async {
    _setLoading(true);
    try {
      final notEmptyPhotos = photos.value.where((e) => e != '').toList();
      await _questionnaireRepository.uploadAllPhotos(
        files: notEmptyPhotos.map((e) => File(e)).toList(),
      );

      await _questionnaireRepository.updateQuestionnaire(_questionnaire);

      _goToSuccessScreen();
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void _goToSuccessScreen() {
    if (!_context.mounted) return;
    _context.goNamed(AppRoute.signUpSuccess.name);
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
