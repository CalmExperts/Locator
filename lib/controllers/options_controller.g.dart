// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OptionsController on _OptionsControllerBase, Store {
  final _$heightAtom = Atom(name: '_OptionsControllerBase.height');

  @override
  double get height {
    _$heightAtom.reportRead();
    return super.height;
  }

  @override
  set height(double value) {
    _$heightAtom.reportWrite(value, super.height, () {
      super.height = value;
    });
  }

  final _$isModalActiveAtom =
      Atom(name: '_OptionsControllerBase.isModalActive');

  @override
  bool get isModalActive {
    _$isModalActiveAtom.reportRead();
    return super.isModalActive;
  }

  @override
  set isModalActive(bool value) {
    _$isModalActiveAtom.reportWrite(value, super.isModalActive, () {
      super.isModalActive = value;
    });
  }

  final _$isColorActiveAtom =
      Atom(name: '_OptionsControllerBase.isColorActive');

  @override
  bool get isColorActive {
    _$isColorActiveAtom.reportRead();
    return super.isColorActive;
  }

  @override
  set isColorActive(bool value) {
    _$isColorActiveAtom.reportWrite(value, super.isColorActive, () {
      super.isColorActive = value;
    });
  }

  final _$numberAtom = Atom(name: '_OptionsControllerBase.number');

  @override
  int get number {
    _$numberAtom.reportRead();
    return super.number;
  }

  @override
  set number(int value) {
    _$numberAtom.reportWrite(value, super.number, () {
      super.number = value;
    });
  }

  final _$buttonColorAtom = Atom(name: '_OptionsControllerBase.buttonColor');

  @override
  String get buttonColor {
    _$buttonColorAtom.reportRead();
    return super.buttonColor;
  }

  @override
  set buttonColor(String value) {
    _$buttonColorAtom.reportWrite(value, super.buttonColor, () {
      super.buttonColor = value;
    });
  }

  final _$_OptionsControllerBaseActionController =
      ActionController(name: '_OptionsControllerBase');

  @override
  dynamic changeModal(dynamic value) {
    final _$actionInfo = _$_OptionsControllerBaseActionController.startAction(
        name: '_OptionsControllerBase.changeModal');
    try {
      return super.changeModal(value);
    } finally {
      _$_OptionsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeHeight(dynamic value) {
    final _$actionInfo = _$_OptionsControllerBaseActionController.startAction(
        name: '_OptionsControllerBase.changeHeight');
    try {
      return super.changeHeight(value);
    } finally {
      _$_OptionsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeColor(dynamic value) {
    final _$actionInfo = _$_OptionsControllerBaseActionController.startAction(
        name: '_OptionsControllerBase.changeColor');
    try {
      return super.changeColor(value);
    } finally {
      _$_OptionsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeButtonColor(dynamic value) {
    final _$actionInfo = _$_OptionsControllerBaseActionController.startAction(
        name: '_OptionsControllerBase.changeButtonColor');
    try {
      return super.changeButtonColor(value);
    } finally {
      _$_OptionsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
height: ${height},
isModalActive: ${isModalActive},
isColorActive: ${isColorActive},
number: ${number},
buttonColor: ${buttonColor}
    ''';
  }
}
