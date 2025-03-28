import 'package:partnext/features/initial/data/repository/user_repository.dart';
import 'package:partnext/features/profile/data/repository/profile_repository.dart';
import 'package:partnext/features/questionnaire/data/model/questionnaire_api_model.dart';
import 'package:partnext/features/questionnaire/data/repository/questionnaire_repository.dart';

class UpdateQuestionnaireUseCase {
  final QuestionnaireRepository _questionnaireRepository;
  final ProfileRepository _profileRepository;
  final UserRepository _userRepository;

  UpdateQuestionnaireUseCase(
    this._questionnaireRepository,
    this._profileRepository,
    this._userRepository,
  );

  Future<void> call(QuestionnaireApiModel value) async {
    await _questionnaireRepository.updateQuestionnaire(value);

    // After updating the questionnaire, update the user's profile
    final user = await _profileRepository.getUserProfile();
    await _userRepository.setUser(user);
  }
}
