import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_shadows.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/features/nav_bar/domain/entity/nav_bar_tab.dart';
import 'package:partnext/features/nav_bar/presentation/nav_bar_screen_vm.dart';
import 'package:provider/provider.dart';

class NavBarScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const NavBarScreen(
    this.navigationShell, {
    super.key,
  });

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  late final NavBarScreenVm vm;

  @override
  void initState() {
    super.initState();
    vm = context.read<NavBarScreenVm>();
  }

  void _onPageIndexChangedOutside(int value) {
    final currentIndex = widget.navigationShell.currentIndex;
    if (value == currentIndex) return;

    _goNavigationBranch(value);
  }

  void _goNavigationBranch(int newIndex) {
    final isTheSameTab = newIndex == widget.navigationShell.currentIndex;

    // final currentUrl = GoRouterState.of(context).uri.toString();
    // final currentLevel = currentUrl.split('/').length;
    // final isInitialLocation = currentLevel == 2; // Example: "/accounting"
    //
    // if (isTheSameTab && isInitialLocation) return;
    if (isTheSameTab) return;

    widget.navigationShell.goBranch(
      newIndex,
      // initialLocation: isTheSameTab,
    );
  }

  void _onTabSelected(int index) {
    _goNavigationBranch(index);
    vm.onPageSelectedInside(index);
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = widget.navigationShell.currentIndex;

    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    final navBarHeight = max(72, 72.h) + bottomPadding;
    final navBarRadius = 25.h;
    final navBarOverlap = navBarHeight - navBarRadius - bottomPadding;

    final borderRadius = BorderRadius.vertical(top: Radius.circular(navBarRadius));

    return ValueListenableBuilder(
      valueListenable: vm.pageIndex,
      builder: (context, pageIndex, child) {
        _onPageIndexChangedOutside(pageIndex);

        return child ?? const SizedBox.shrink();
      },
      child: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return Scaffold(
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: widget.navigationShell,
                    ),
                    SizedBox(height: isKeyboardVisible ? 0 : navBarOverlap),
                  ],
                ),
                isKeyboardVisible
                    ? SizedBox.shrink()
                    : Directionality(
                        textDirection: TextDirection.ltr,
                        child: Container(
                          height: navBarHeight,
                          decoration: BoxDecoration(
                            borderRadius: borderRadius,
                            boxShadow: const [AppShadows.bottomNavBar],
                          ),
                          child: Material(
                            color: AppColors.white,
                            borderRadius: borderRadius,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16).h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _NavigationBarItem(
                                    iconPath: Assets.icons.handshakeNavBar.path,
                                    selected: currentIndex == NavBarTab.home.index,
                                    onTap: () => _onTabSelected(NavBarTab.home.index),
                                  ),
                                  ValueListenableBuilder(
                                    valueListenable: vm.unreadChatCount,
                                    builder: (context, unreadChatCount, _) {
                                      return _NavigationBarItem(
                                        iconPath: Assets.icons.chatNavBar.path,
                                        selected: currentIndex == NavBarTab.chats.index,
                                        onTap: () => _onTabSelected(NavBarTab.chats.index),
                                        counter: unreadChatCount,
                                      );
                                    },
                                  ),
                                  _NavigationBarItem(
                                    iconPath: Assets.icons.rocketNavBar.path,
                                    selected: currentIndex == NavBarTab.grow.index,
                                    onTap: () => _onTabSelected(NavBarTab.grow.index),
                                  ),
                                  _NavigationBarItem(
                                    iconPath: Assets.icons.userNavBar.path,
                                    selected: currentIndex == NavBarTab.profile.index,
                                    onTap: () => _onTabSelected(NavBarTab.profile.index),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  final String iconPath;
  final bool selected;
  final VoidCallback onTap;
  final int counter;

  const _NavigationBarItem({
    required this.iconPath,
    required this.selected,
    required this.onTap,
    this.counter = 0,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = selected ? AppColors.primary : Colors.transparent;
    final iconColor = selected ? AppColors.white : AppColors.primary;
    final isLtr = context.locale.isLtr;
    final counterText = counter < 10 ? '$counter' : '9+';

    return InkResponse(
      onTap: onTap,
      containedInkWell: true,
      splashColor: Colors.transparent,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              key: ValueKey(selected),
              width: max(48, 48.r),
              height: max(48, 48.r),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8).r,
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                iconPath,
                width: max(48, 48.r),
                height: max(48, 48.r),
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
            ),
            Positioned(
              top: -8.h,
              right: isLtr ? -8.w : null,
              left: !isLtr ? -8.w : null,
              child: AnimatedSize(
                duration: Duration(milliseconds: 250),
                child: counter == 0
                    ? const SizedBox.shrink()
                    : IgnorePointer(
                        child: Container(
                          width: 20.h,
                          height: 20.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.backgroundBright,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            counterText,
                            style: AppTextStyles.s12w700.copyWith(color: AppColors.white),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
