import 'dart:async';

import 'package:flutter/material.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/layouts/simple_layout.dart';
import 'package:partnext/common/utils/date_time_ext.dart';
import 'package:partnext/config.dart';
import 'package:partnext/features/profile/presentation/upgrade/upgrade_screen_vm.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UpgradeThirdPage extends StatefulWidget {
  const UpgradeThirdPage({super.key});

  @override
  State<UpgradeThirdPage> createState() => _UpgradeThirdPageState();
}

class _UpgradeThirdPageState extends State<UpgradeThirdPage> {
  late final UpgradeScreenVm vm;
  late final WebViewController webViewController;

  final _timeoutThreshold = DateTime.now().add(Config.paymentTimeoutDuration);
  final _timeLeft = ValueNotifier<String>(Config.paymentTimeoutDuration.toCountDown());
  Timer? _timeoutTimer;

  @override
  void initState() {
    super.initState();
    vm = context.read<UpgradeScreenVm>();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('payment_success')) {
              vm.onPurchaseSuccess();

              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(vm.purchaseUrl));

    _startTimeoutTimer();
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    _timeLeft.dispose();
    super.dispose();
  }

  void _startTimeoutTimer() {
    _timeoutTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        final timeDifference = _timeoutThreshold.difference(DateTime.now());
        if (timeDifference.isNegative) {
          _timeoutTimer?.cancel();
          vm.onPurchaseTimeout();

          return;
        }

        _timeLeft.value = timeDifference.toCountDown();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<UpgradeScreenVm>();

    return SimpleLayout(
      backgroundColor: AppColors.white,
      onBackButtonPressed: vm.onBackButtonPressed,
      title: ValueListenableBuilder(
        valueListenable: _timeLeft,
        builder: (context, timeLeft, _) {
          return Text(
            '${context.l10n.payment_timeout_in}: $timeLeft',
            style: AppTextStyles.s16w400,
          );
        },
      ),
      body: WebViewWidget(controller: webViewController),
    );
  }
}
