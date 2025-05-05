part of 'main_screen_bloc.dart';

abstract class MainScreenEvent {}

class OnChangeTab extends MainScreenEvent {
  final int selectedIndex;

  OnChangeTab({required this.selectedIndex});
}
