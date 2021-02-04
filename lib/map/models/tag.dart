import 'package:flutter/foundation.dart';

class Tag<T> {
  final String name;
  final List<T> options;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Tag({
    @required this.name,
    @required this.options,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          options == other.options);

  @override
  int get hashCode => name.hashCode ^ options.hashCode;

  @override
  String toString() {
    return 'Tag{name: $name, options: $options}';
  }

  Tag copyWith({
    String name,
    List<T> options,
  }) {
    return Tag(
      name: name ?? this.name,
      options: options ?? this.options,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'options': options,
    };
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      name: map['name'] as String,
      options: map['options'] as List<T>,
    );
  }

//</editor-fold>
}
