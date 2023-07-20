import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:inside_1/app/di.dart';
import 'package:inside_1/domain/model/model.dart';
import 'package:inside_1/presentation/profile/profile_view_model.dart';
import 'package:inside_1/presentation/resources/assets_manager.dart';
import 'package:inside_1/presentation/resources/color_manager.dart';
import 'package:inside_1/presentation/resources/route_manager.dart';
import 'package:inside_1/presentation/resources/value_manager.dart';
import 'package:provider/provider.dart';

class RootLayout extends StatelessWidget {
  const RootLayout({Key? key, required this.body})
      : super(key: key);

  // final List<NavigationDestination> destinations;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UsersInfo?>.value(
          value: instance<ProfileViewModel>().userInfoStream,
          initialData: null,
        ),
      ],
      child: WillPopScope(
        onWillPop: () async {
          if (_calculateSelectedIndex(context) == 0) {
            return true;
          } else {
            GoRouter.of(context).goNamed(AppPageRouteName.home);
            return false;
          }
        },
        child: LayoutBuilder(
          builder: (context, dimens) {
            if (dimens.maxWidth > 600) {
              return Scaffold(
                body: Row(
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: Theme.of(context).colorScheme.copyWith(
                          primary: ColorManager.lightSecondary,
                        ),
                      ),
                      child: NavigationRail(
                        selectedIndex: _calculateSelectedIndex(context),
                        onDestinationSelected: (index) =>
                            _onDestinationSelected(index, context),
                        destinations: [
                          NavigationRailDestination(
                            label: const Text(AppPageRouteName.home),
                            icon: SvgPicture.asset(
                              IconsAsset.homeRegular,
                              colorFilter: ColorFilter.mode(ColorManager.white, BlendMode.srcIn),
                              width: AppSize.s24,
                              height: AppSize.s24,
                            ),
                            selectedIcon: SvgPicture.asset(
                              IconsAsset.homeFilled,
                              colorFilter: ColorFilter.mode(ColorManager.backgroundColor, BlendMode.srcIn),
                              width: AppSize.s24,
                              height: AppSize.s24,
                            ),
                          ),
                          NavigationRailDestination(
                            label: const Text(AppPageRouteName.explore),
                            icon: SvgPicture.asset(
                              IconsAsset.searchRegular,
                              colorFilter: ColorFilter.mode(ColorManager.white, BlendMode.srcIn),
                              width: AppSize.s24,
                              height: AppSize.s24,
                            ),
                            selectedIcon: SvgPicture.asset(
                              IconsAsset.searchRegular,
                              colorFilter: ColorFilter.mode(ColorManager.backgroundColor, BlendMode.srcIn),
                              width: AppSize.s24,
                              height: AppSize.s24,
                            ),
                          ),
                          NavigationRailDestination(
                            label: const Text(AppPageRouteName.profile),
                            icon: SvgPicture.asset(
                              IconsAsset.personRegular,
                              colorFilter: ColorFilter.mode(ColorManager.white, BlendMode.srcIn),
                              width: AppSize.s24,
                              height: AppSize.s24,
                            ),
                            selectedIcon: SvgPicture.asset(
                              IconsAsset.personFilled,
                              colorFilter: ColorFilter.mode(ColorManager.backgroundColor, BlendMode.srcIn),                      width: AppSize.s24,
                              height: AppSize.s24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: body,
                    ),
                  ],
                ),
              );
            }
            return Scaffold(
              bottomNavigationBar: NavigationBar(
                selectedIndex: _calculateSelectedIndex(context),
                destinations: [
                  NavigationDestination(
                    label: AppPageRouteName.home,
                    icon: SvgPicture.asset(
                      IconsAsset.homeRegular,
                      colorFilter: ColorFilter.mode(ColorManager.white, BlendMode.srcIn),
                      width: AppSize.s24,
                      height: AppSize.s24,
                    ),
                    selectedIcon: SvgPicture.asset(
                      IconsAsset.homeFilled,
                      colorFilter: ColorFilter.mode(ColorManager.backgroundColor, BlendMode.srcIn),
                      width: AppSize.s24,
                      height: AppSize.s24,
                    ),
                  ),
                  NavigationDestination(
                    label: AppPageRouteName.explore,
                    icon: SvgPicture.asset(
                      IconsAsset.searchRegular,
                      colorFilter: ColorFilter.mode(ColorManager.white, BlendMode.srcIn),
                      width: AppSize.s24,
                      height: AppSize.s24,
                    ),
                    selectedIcon: SvgPicture.asset(
                      IconsAsset.searchFilled,
                      colorFilter: ColorFilter.mode(ColorManager.backgroundColor, BlendMode.srcIn),
                      width: AppSize.s24,
                      height: AppSize.s24,
                    ),
                  ),
                  NavigationDestination(
                    label: AppPageRouteName.profile,
                    icon: SvgPicture.asset(
                      IconsAsset.personRegular,
                      colorFilter: ColorFilter.mode(ColorManager.white, BlendMode.srcIn),
                      width: AppSize.s24,
                      height: AppSize.s24,
                    ),
                    selectedIcon: SvgPicture.asset(
                      IconsAsset.personFilled,
                      colorFilter: ColorFilter.mode(ColorManager.backgroundColor, BlendMode.srcIn),                      width: AppSize.s24,
                      height: AppSize.s24,
                    ),
                  ),
                ],
                onDestinationSelected: (index) =>
                    _onDestinationSelected(index, context),
              ),
              body: body,
            );
          },
        ),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final GoRouterState route = GoRouterState.of(context);
    final String location = route.location;
    if (location.startsWith(AppPageRoutePath.home)) {
      return 0;
    }
    if (location.startsWith(AppPageRoutePath.explore)) {
      return 1;
    }
    if (location.startsWith(AppPageRoutePath.profile)) {
      return 2;
    }
    return 0;
  }

  void _onDestinationSelected(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).goNamed(AppPageRouteName.home);
        break;
      case 1:
        GoRouter.of(context).goNamed(AppPageRouteName.explore);
        break;
      case 2:
        GoRouter.of(context).goNamed(AppPageRouteName.profile);
        break;
    }
  }
}
