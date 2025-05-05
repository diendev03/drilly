part of 'main_screen_bloc.dart';

class MainScreenState {
  final int selectedIndex;

  const MainScreenState({
    this.selectedIndex = 0,
  });

  MainScreenState copyWith({
    int? selectedIndex,
  }) {
    return MainScreenState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
