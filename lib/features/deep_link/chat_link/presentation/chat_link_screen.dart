import 'package:flutter/material.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/common/layouts/main_layout.dart';
import 'package:partnext/common/widgets/item_not_found_widget.dart';
import 'package:partnext/common/widgets/loading_container_indicator.dart';
import 'package:partnext/features/deep_link/chat_link/presentation/chat_link_screen_vm.dart';
import 'package:provider/provider.dart';

class ChatLinkScreen extends StatelessWidget {
  const ChatLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ChatLinkScreenVm>();

    return MainLayout(
      body: ValueListenableBuilder(
        valueListenable: vm.loading,
        builder: (context, loading, _) {
          return Stack(
            children: [
              ValueListenableBuilder(
                valueListenable: vm.chat,
                builder: (context, chat, _) {
                  if (!loading && chat == null) {
                    return ItemNotFoundWidget(
                      title: context.l10n.chat_not_found,
                      description: context.l10n.chat_not_found_description,
                      buttonLabel: context.l10n.continue_browsing,
                      onTap: vm.goHome,
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
              LoadingContainerIndicator(loading: loading),
            ],
          );
        },
      ),
    );
  }
}
