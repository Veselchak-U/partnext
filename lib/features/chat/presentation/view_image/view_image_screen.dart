import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:partnext/common/layouts/main_layout.dart';
import 'package:partnext/features/chat/presentation/view_image/view_image_screen_params.dart';

class ViewImageScreen extends StatelessWidget {
  final ViewImageScreenParams params;

  const ViewImageScreen({
    required this.params,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      titleText: params.name,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return CachedNetworkImage(
            height: constraints.maxHeight,
            imageUrl: params.url,
            fit: BoxFit.contain,
          );
        },
      ),
    );
  }
}
