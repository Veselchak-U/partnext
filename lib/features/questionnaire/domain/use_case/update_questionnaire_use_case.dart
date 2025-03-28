import 'package:partnext/features/profile/domain/use_case/refresh_user_profile_use_case.dart';
import 'package:partnext/features/questionnaire/data/model/questionnaire_api_model.dart';
import 'package:partnext/features/questionnaire/data/repository/questionnaire_repository.dart';

class UpdateQuestionnaireUseCase {
  final QuestionnaireRepository _questionnaireRepository;
  final RefreshUserProfileUseCase _refreshUserProfileUseCase;

  UpdateQuestionnaireUseCase(
    this._questionnaireRepository,
    this._refreshUserProfileUseCase,
  );

  Future<void> call(QuestionnaireApiModel value) async {
    await _questionnaireRepository.updateQuestionnaire(value);
    await _refreshUserProfileUseCase();
  }
}
