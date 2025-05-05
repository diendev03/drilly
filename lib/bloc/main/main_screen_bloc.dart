import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc()
      : super(
          const MainScreenState(),
        ) {
    on<OnChangeTab>(_onChangeTab);
  }

  void _onChangeTab(
    OnChangeTab event,
    Emitter<MainScreenState> emit,
  ) {
    if (event.selectedIndex == state.selectedIndex) return;
    emit(
      state.copyWith(
        selectedIndex: event.selectedIndex,
      ),
    );
  }
}
