import 'package:partnext/features/chat/domain/provider/chat_list_provider.dart';
import 'package:partnext/features/chat/domain/provider/message_list_provider.dart';
import 'package:partnext/features/grow/domain/provider/partners_provider.dart';
import 'package:partnext/features/initial/data/repository/user_repository.dart';
import 'package:partnext/features/nav_bar/domain/provider/nav_bar_index_provider.dart';
import 'package:partnext/features/questionnaire/data/repository/questionnaire_repository.dart';

class LogoutUseCase {
  final UserRepository _userRepository;
  final QuestionnaireRepository _questionnaireRepository;
  final NavBarIndexProvider _navBarIndexProvider;
  final PartnersProvider _partnersProvider;
  final ChatListProvider _chatListProvider;
  final MessageListProvider _messageListProvider;

  LogoutUseCase(
    this._userRepository,
    this._questionnaireRepository,
    this._navBarIndexProvider,
    this._partnersProvider,
    this._chatListProvider,
    this._messageListProvider,
  );

  Future<void> call() async {
    await _userRepository.setAccessToken(null);
    await _userRepository.setUser(null);
    await _questionnaireRepository.clearQuestionnaire();
    _navBarIndexProvider.reset(notify: false);
    _partnersProvider.clearCache();
    _chatListProvider.clearCache();
    _messageListProvider.clearCache();
  }
}
