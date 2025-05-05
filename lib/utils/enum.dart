enum ScreenState {
  loading,
  failure,
  success,
  ;

  bool get isLoading => this == ScreenState.loading;
  bool get isFailure => this == ScreenState.failure;
  bool get isSuccess => this == ScreenState.success;
}

enum SyncState {
  none,
  loading,
  failure,
  success,
  ;

  bool get isLoading => this == SyncState.loading;
  bool get isFailure => this == SyncState.failure;
  bool get isSuccess => this == SyncState.success;
  bool get isNone => this == SyncState.none;
}
