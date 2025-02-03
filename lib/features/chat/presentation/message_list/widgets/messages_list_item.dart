import 'package:flutter/material.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';

class MessagesListItem extends StatelessWidget {
  final MessageApiModel item;
  final VoidCallback onTap;

  const MessagesListItem(
    this.item, {
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
