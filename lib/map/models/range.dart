abstract class RangeBase<T> {
  final T start;
  final T end;

  RangeBase(this.start, this.end);

  /// returns whether or not [value] is within the range of this
  bool isWithin(T value);
}
