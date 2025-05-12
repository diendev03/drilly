// ignore_for_file: deprecated_member_use, unused_import

import 'package:drilly/bloc/main/main_screen_bloc.dart';
import 'package:drilly/screens/auth/auth_screen.dart';
import 'package:drilly/screens/home/home_screen.dart';
import 'package:drilly/screens/message/message_screen.dart';
import 'package:drilly/screens/notification/notification_screen.dart';
import 'package:drilly/screens/profile/profile_screen.dart';
import 'package:drilly/screens/task/task_screen.dart';
import 'package:drilly/utils/app_res.dart';
import 'package:drilly/utils/asset_res.dart';
import 'package:drilly/utils/color_res.dart';
import 'package:drilly/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final MainScreenBloc _bloc;
  late PageController pageController;
  int backButtonTapCount = 0;
  DateTime? lastBackButtonPressTime;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 0,
      // keepPage: true,
    );
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    _bloc = MainScreenBloc();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, value) {
        if (didPop) {
          return;
        }
        final now = DateTime.now();
        if (lastBackButtonPressTime == null ||
            now.difference(lastBackButtonPressTime!) >
                const Duration(seconds: 2)) {
          lastBackButtonPressTime = now;
          backButtonTapCount = 1;
          AppRes.showSnackBar(S.current.pressBackAgainToExit);
          return;
        } else {
          backButtonTapCount++;
          if (backButtonTapCount >= 2) {
            SystemNavigator.pop(); // Exit the app
          }
          return;
        }
      },
      child: BlocProvider.value(
        value: _bloc,
        child: Scaffold(
          body: Builder(
            builder: (context) {
              return BlocListener<MainScreenBloc, MainScreenState>(
                bloc: _bloc,
                listener: (context, state) {
                  pageController.jumpToPage(state.selectedIndex);
                },
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          const HomeScreen(),
                          const MessageScreen(),
                          const TaskScreen(),
                          const NotificationScreen(),
                          ProfileScreen(),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: ColorRes.black.withOpacity(0.1),
                            blurRadius: 10,
                          )
                        ],
                        color: ColorRes.white,
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SafeArea(
                        top: false,
                        child: BlocBuilder<MainScreenBloc, MainScreenState>(
                          builder: (context, state) {
                            return Row(
                              children: [
                                Expanded(
                                  child: BottomMenuItem(
                                    image: AssetRes.icHome,
                                    menuIsSelected: state.selectedIndex == 0,
                                    onTap: () {
                                      _bloc.add(
                                        OnChangeTab(
                                          selectedIndex: 0,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: BottomMenuItem(
                                    image: AssetRes.icMessage,
                                    menuIsSelected: state.selectedIndex == 1,
                                    onTap: () {
                                      _bloc.add(
                                        OnChangeTab(
                                          selectedIndex: 1,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: BottomMenuItem(
                                    image: AssetRes.icExercise,
                                    menuIsSelected: state.selectedIndex == 2,
                                    onTap: () {
                                      _bloc.add(
                                        OnChangeTab(
                                          selectedIndex: 2,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: BottomMenuItem(
                                    image: AssetRes.icNotification,
                                    menuIsSelected: state.selectedIndex == 3,
                                    onTap: () {
                                      _bloc.add(
                                        OnChangeTab(
                                          selectedIndex: 3,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: BottomMenuItem(
                                    image: AssetRes.icProfile,
                                    menuIsSelected: state.selectedIndex == 4,
                                    onTap: () {
                                      _bloc.add(
                                        OnChangeTab(
                                          selectedIndex: 4,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class BottomMenuItem extends StatelessWidget {
  final String image;
  final bool menuIsSelected;
  final Function()? onTap;
  final double? imageSize;
  final double? nonSelectedImageSize;

  const BottomMenuItem({
    super.key,
    required this.image,
    required this.menuIsSelected,
    this.imageSize,
    this.nonSelectedImageSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.center,
      child: Image.asset(
        color: menuIsSelected ? ColorRes.accent : ColorRes.grey,
        image,
        height: menuIsSelected ? 30 : 20,
        fit: BoxFit.contain,
      ),
    ),
    );
  }
}
