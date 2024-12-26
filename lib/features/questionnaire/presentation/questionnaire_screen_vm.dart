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
import 'package:partnext/features/questionnaire/presentation/questionnaire_screen_params.dart';
import 'package:partnext/features/questionnaire/presentation/widgets/partnership_description_overlay.dart';

class QuestionnaireScreenVm {
  final BuildContext _context;
  final QuestionnaireRepository _questionnaireRepository;
  final QuestionnaireScreenParams? params;

  QuestionnaireScreenVm(
    this._context,
    this._questionnaireRepository, {
    this.params,
  }) {
    _init();
  }

  final initializing = ValueNotifier<bool>(false);
  final loading = ValueNotifier<bool>(false);
  final loadingPhoto = ValueNotifier<bool>(false);
  final isFirstPage = ValueNotifier<bool>(true);
  final isLastPage = ValueNotifier<bool>(false);
  final photos = ValueNotifier<List<String>>(List<String>.filled(4, ''));
  final currentPhotoIndex = ValueNotifier<int>(0);

  final pageController = PageController();

  final fifthFormKey = GlobalKey<FormState>();
  final experienceKey = GlobalKey<RowSelectorState>();

  OverlayEntry? _overlayEntry;

  QuestionnaireApiModel questionnaire = QuestionnaireApiModel();

  bool get isEditMode => params?.isEdit == true;

  void _init() {
    _initQuestionnaire();
  }

  void dispose() {
    initializing.dispose();
    loading.dispose();
    loadingPhoto.dispose();
    isFirstPage.dispose();
    isLastPage.dispose();
    photos.dispose();
    currentPhotoIndex.dispose();

    pageController.dispose();
  }

  Future<void> _initQuestionnaire() async {
    if (!isEditMode) return;

    _setInitializing(true);
    try {
      final result = await _questionnaireRepository.getQuestionnaire();
      if (!_context.mounted) return;

      if (result == null) {
        _onError(_context.l10n.questionnaire_init_error);

        return;
      }

      questionnaire = result;
      for (int i = 0; i < questionnaire.photos.length; i++) {
        photos.value[i] = questionnaire.photos[i];
      }
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setInitializing(false);
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

    final types = [...questionnaire.myPartnershipTypes];
    if (selected) {
      types.add(item);
    } else {
      types.remove(item);
    }

    questionnaire = questionnaire.copyWith(myPartnershipTypes: types);
  }

  void onPartnerPartnershipTypeSelected(PartnershipType item, bool selected) {
    closeOverlay();

    final types = [...questionnaire.partnerPartnershipTypes];
    if (selected) {
      types.add(item);
    } else {
      types.remove(item);
    }

    questionnaire = questionnaire.copyWith(partnerPartnershipTypes: types);
  }

  void onSelectMyInterest(InterestType item, bool selected) {
    final interests = [...questionnaire.myInterests];
    if (selected) {
      interests.add(item);
    } else {
      interests.remove(item);
    }

    questionnaire = questionnaire.copyWith(myInterests: interests);
  }

  void onSelectPartnerInterest(InterestType item, bool selected) {
    final interests = [...questionnaire.partnerInterests];
    if (selected) {
      interests.add(item);
    } else {
      interests.remove(item);
    }

    questionnaire = questionnaire.copyWith(partnerInterests: interests);
  }

  void onDateOfBirthChanged(DateTime? value) {
    questionnaire = questionnaire.copyWith(dateOfBirth: value);
  }

  void onPositionChanged(String value) {
    questionnaire = questionnaire.copyWith(position: value);
  }

  void onBioChanged(String value) {
    questionnaire = questionnaire.copyWith(bio: value);
  }

  void onExperienceSelected(ExperienceDuration? value) {
    questionnaire = questionnaire.copyWith(experience: value);
  }

  void onProfileUrlChanged(String value) {
    questionnaire = questionnaire.copyWith(profileUrl: value);
  }

  void onTapImage(int index) {
    final imageUrl = photos.value[index];
    if (imageUrl.isEmpty) {
      addImage(index);
    } else {
      setCurrentPhotoIndex(index);
    }
  }

  Future<void> addImage(int index) async {
    setCurrentPhotoIndex(index);

    _setLoadingPhoto(true);
    try {
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file == null) {
        _setLoadingPhoto(false);

        return;
      }

      final imageUrl = await _questionnaireRepository.uploadImage(filePath: file.path);
      if (!_context.mounted) return;

      final newList = [...photos.value];
      newList[index] = imageUrl;
      photos.value = newList;

      setCurrentPhotoIndex(index);
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoadingPhoto(false);
  }

  void removeImage(int index) {
    final newList = [...photos.value];
    newList[index] = '';
    photos.value = newList;
  }

  void setCurrentPhotoIndex(int index) {
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
    final filled = questionnaire.myPartnershipTypes.isNotEmpty;
    if (!filled) {
      _onError(_context.l10n.select_at_least_one_item);
    }

    return filled;
  }

  bool _secondPageCheck() {
    final filled = questionnaire.partnerPartnershipTypes.isNotEmpty;
    if (!filled) {
      _onError(_context.l10n.select_at_least_one_item);
    }

    return filled;
  }

  bool _thirdPageCheck() {
    final filled = questionnaire.myInterests.isNotEmpty;
    if (!filled) {
      _onError(_context.l10n.select_at_least_one_item);
    }

    return filled;
  }

  bool _fourthPageCheck() {
    final filled = questionnaire.partnerInterests.isNotEmpty;
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

    if (questionnaire.experience == null) {
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
      questionnaire = questionnaire.copyWith(photos: notEmptyPhotos);
      await _questionnaireRepository.updateQuestionnaire(questionnaire);

      _goToNextScreen();
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoading(false);
  }

  void _goToNextScreen() {
    if (!_context.mounted) return;

    if (isEditMode) {
      _context.pop();
    } else {
      _context.goNamed(AppRoute.signUpSuccess.name);
    }
  }

  void _setInitializing(bool value) {
    if (!_context.mounted) return;
    initializing.value = value;
  }

  void _setLoadingPhoto(bool value) {
    if (!_context.mounted) return;
    loadingPhoto.value = value;
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
