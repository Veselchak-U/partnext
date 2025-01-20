import 'package:flutter/material.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/features/grow/presentation/start_chat/widgets/start_chat_advice.dart';

class StartChatAdviceBlock extends StatelessWidget {
  const StartChatAdviceBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StartChatAdvice(
          text: context.l10n.leave_your_ego_aside,
        ),
        StartChatAdvice(
          text: context.l10n.keep_positive_attitude,
        ),
        StartChatAdvice(
          text: context.l10n.keep_it_simple,
        ),
      ],
    );
  }
}
