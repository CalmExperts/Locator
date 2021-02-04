import 'package:locator_app/map/models/range.dart';

class TimeRange extends RangeBase<DateTime> {
  TimeRange(start, end) : super(start, end);

  @override
  bool isWithin(DateTime value) => value.isAfter(start) && value.isBefore(end);

  @override
  String toString() => 'TimeRange{start: $start, end: $end}';
}
