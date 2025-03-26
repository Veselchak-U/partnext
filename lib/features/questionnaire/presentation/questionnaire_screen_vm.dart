import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/common/dialogs/app_dialogs.dart';
import 'package:partnext/common/overlays/app_overlays.dart';
import 'package:partnext/common/widgets/row_selector.dart';
import 'package:partnext/features/chat/data/model/file_api_model.dart';
import 'package:partnext/features/chat/domain/entity/remote_file_type.dart';
import 'package:partnext/features/file/data/repository/file_repository.dart';
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
  final FileRepository _fileRepository;
  final QuestionnaireScreenParams? params;

  QuestionnaireScreenVm(
    this._context,
    this._questionnaireRepository,
    this._fileRepository, {
    this.params,
  }) {
    _init();
  }

  final initializing = ValueNotifier<bool>(false);
  final loading = ValueNotifier<bool>(false);
  final loadingPhoto = ValueNotifier<List<bool>>(List<bool>.filled(4, false));
  final isFirstPage = ValueNotifier<bool>(true);
  final isLastPage = ValueNotifier<bool>(false);
  final photos = ValueNotifier<List<FileApiModel?>>(List<FileApiModel?>.filled(4, null));
  final currentPhotoIndex = ValueNotifier<int>(0);

  final pageController = PageController();

  final fifthFormKey = GlobalKey<FormState>();
  final experienceKey = GlobalKey<RowSelectorState>();

  OverlayEntry? _overlayEntry;

  QuestionnaireApiModel questionnaire = QuestionnaireApiModel();

  bool get isEditMode => params?.isEdit == true;

  bool _hasChanges = false;

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
    _hasChanges = true;
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
    _hasChanges = true;
  }

  void onSelectMyInterest(InterestType item, bool selected) {
    final interests = [...questionnaire.myInterests];
    if (selected) {
      interests.add(item);
    } else {
      interests.remove(item);
    }

    questionnaire = questionnaire.copyWith(myInterests: interests);
    _hasChanges = true;
  }

  void onSelectPartnerInterest(InterestType item, bool selected) {
    final interests = [...questionnaire.partnerInterests];
    if (selected) {
      interests.add(item);
    } else {
      interests.remove(item);
    }

    questionnaire = questionnaire.copyWith(partnerInterests: interests);
    _hasChanges = true;
  }

  void onDateOfBirthChanged(DateTime? value) {
    questionnaire = questionnaire.copyWith(dateOfBirth: value);
    _hasChanges = true;
  }

  void onPositionChanged(String value) {
    questionnaire = questionnaire.copyWith(position: value);
    _hasChanges = true;
  }

  void onBioChanged(String value) {
    questionnaire = questionnaire.copyWith(bio: value);
    _hasChanges = true;
  }

  void onExperienceSelected(ExperienceDuration? value) {
    questionnaire = questionnaire.copyWith(experience: value);
    _hasChanges = true;
  }

  void onProfileUrlChanged(String value) {
    questionnaire = questionnaire.copyWith(profileUrl: value);
    _hasChanges = true;
  }

  void onTapImage(int index) {
    final image = photos.value[index];
    if (image == null) {
      addImage(index);
    } else {
      setCurrentPhotoIndex(index);
    }
  }

  Future<void> addImage(int index) async {
    setCurrentPhotoIndex(index);

    _setLoadingPhoto(index, true);
    try {
      final file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        requestFullMetadata: false,
      );
      if (file == null) {
        _setLoadingPhoto(index, false);

        return;
      }

      final model = await _fileRepository.uploadFile(
        path: file.path,
        type: RemoteFileType.image,
      );
      if (!_context.mounted) return;

      final newList = [...photos.value];
      newList[index] = model;
      photos.value = newList;
      _hasChanges = true;

      setCurrentPhotoIndex(index);
    } on Object catch (e, st) {
      LoggerService().e(error: e, stackTrace: st);
      _onError('$e');
    }
    _setLoadingPhoto(index, false);
  }

  void removeImage(int index) {
    final newList = [...photos.value];
    newList[index] = null;
    photos.value = newList;
    _hasChanges = true;
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

  void onBackButtonPressed(BuildContext context) {
    if (isFirstPage.value && isEditMode) {
      _confirmLostChanges(context);
    } else {
      onPreviousPage();
    }
  }

  Future<void> _confirmLostChanges(BuildContext context) async {
    if (!_hasChanges) {
      _context.pop();

      return;
    }

    final confirm = await AppDialogs.showConfirmationDialog(
      context: _context,
      title: _context.l10n.confirmation,
      description: _context.l10n.all_unsaved_data_will_be_lost,
      confirmLabel: _context.l10n.yes,
    );
    if (confirm != true) return;

    if (!_context.mounted) return;
    _context.pop();
  }

  Future<void> _sendQuestionnaire() async {
    _setLoading(true);
    try {
      final notEmptyPhotos = photos.value.nonNulls.toList();
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

  void _setLoadingPhoto(int index, bool value) {
    if (!_context.mounted) return;
    final newList = [...loadingPhoto.value];
    newList[index] = value;

    loadingPhoto.value = newList;
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
