abstract class HomeEvent {}

class LoadHome extends HomeEvent {
  LoadHome();
}
class FilterTransaction extends HomeEvent {
  final bool? isIncome;
  final String? startDate;
  final String? endDate;
  final int? category;

  FilterTransaction({
    this.isIncome,
    this.startDate,
    this.endDate,
    this.category,
  });
}