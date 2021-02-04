import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

String _capitalize(String source) {
  if (source == null || source.isEmpty) {
    return source;
  }
  String result = '';
  var split = source.trim().split(' ');
  for (final word in split) {
    result += '${word.substring(0, 1).toUpperCase()}${word.substring(1)}';
    if (word != split.last) {
      result += ' ';
    }
  }
  return result;
}

extension Extensions on String {
  String capitalize() => _capitalize(this);

  String get initial {
    if (isNotEmpty) {
      return this[0];
    } else {
      return '';
    }
  }
}

String memberSince(int date) {
  DateTime joined = DateTime.fromMillisecondsSinceEpoch(date);
  Duration delta = DateTime.now().difference(joined);
  return 'Member for ${delta.inDays} days';
}

extension JumpToIndex on ScrollController {
  jumpToIndex({@required double extent, @required int index}) {
    double minScrollExtent = this.position.minScrollExtent;
    double maxScrollExtent = this.position.maxScrollExtent;
    var position = (index * extent).clamp(minScrollExtent, maxScrollExtent);
    assert(position >= minScrollExtent && position <= maxScrollExtent);
    jumpTo(position);
  }

  Future<void> get clientHasAttached {
    final completer = Completer();
    if (hasClients && !completer.isCompleted) {
      completer.complete();
      debugPrint('client attached to ScrollController');
    }

    return completer.future;
  }

  Future<void> animateToIndex(
    int index, {
    @required double itemExtent,
    @required Duration duration,
    @required Curve curve,
  }) {
    double minScrollExtent = this.position.minScrollExtent;
    double maxScrollExtent = this.position.maxScrollExtent;
    var position = (index * itemExtent).clamp(minScrollExtent, maxScrollExtent);
    assert(position >= minScrollExtent && position <= maxScrollExtent);
    return animateTo(position, duration: duration, curve: curve);
  }
}

extension IsWithin on num {
  bool isWithin(num beginning, num end, {bool inclusive = true}) {
    if (inclusive) {
      return beginning <= this && this <= end;
    } else {
      return beginning < this && this < end;
    }
  }
}

extension SizedBoxExtension on SizedBox {
  SizedBox expandForFinite(
      {double width = double.infinity, double height = double.infinity}) {
    return SizedBox(
      width: width,
      height: height,
      child: child,
    );
  }
}

extension Inversion<K, V> on Map<K, V> {
  Map<V, K> get inverse => map((key, value) => MapEntry<V, K>(value, key));

  V get<T>(Object key) => this[key];
}

extension ListExtension<T> on List<T> {
  List<T> withElementAsFirst(T element) {
    List<T> newList = List.from(this);
    if (element == null) {
      return newList;
    }
    bool wasRemoved = newList.remove(element);
    if (wasRemoved) {
      newList.insert(0, element);
      return newList;
    } else {
      throw StateError('Bad state no element');
    }
  }
}

extension CollectionExtensions on CollectionReference {
  Query whereIf(
    dynamic field, {
    dynamic isEqualTo,
    dynamic isLessThan,
    dynamic isLessThanOrEqualTo,
    dynamic isGreaterThan,
    dynamic isGreaterThanOrEqualTo,
    dynamic arrayContains,
    List<dynamic> arrayContainsAny,
    List<dynamic> whereIn,
    bool isNull,
    @required bool condition,
  }) {
    if (condition) {
      return where(
        field,
        isEqualTo: isEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        arrayContains: arrayContains,
        arrayContainsAny: arrayContainsAny,
        whereIn: whereIn,
        isNull: isNull,
      );
    } else {
      return this;
    }
  }
}
