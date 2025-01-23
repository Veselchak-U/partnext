import 'package:partnext/features/initial/data/repository/user_repository.dart';
import 'package:partnext/features/questionnaire/data/repository/questionnaire_repository.dart';

class LogoutUseCase {
  final UserRepository _userRepository;
  final QuestionnaireRepository _questionnaireRepository;

  LogoutUseCase(
    this._userRepository,
    this._questionnaireRepository,
  );

  Future<void> call() async {
    await _userRepository.setUser(null);
    await _questionnaireRepository.clearQuestionnaire();
  }
}
