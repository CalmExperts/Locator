// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MapController on _MapControllerBase, Store {
  final _$isCardOpenAtom = Atom(name: '_MapControllerBase.isCardOpen');

  @override
  bool get isCardOpen {
    _$isCardOpenAtom.reportRead();
    return super.isCardOpen;
  }

  @override
  set isCardOpen(bool value) {
    _$isCardOpenAtom.reportWrite(value, super.isCardOpen, () {
      super.isCardOpen = value;
    });
  }

  @override
  String toString() {
    return '''
isCardOpen: ${isCardOpen}
    ''';
  }
}
