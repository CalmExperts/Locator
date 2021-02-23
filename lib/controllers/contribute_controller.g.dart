// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contribute_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ContributeController on _ContributeControllerBase, Store {
  final _$pageIndexAtom = Atom(name: '_ContributeControllerBase.pageIndex');

  @override
  int get pageIndex {
    _$pageIndexAtom.reportRead();
    return super.pageIndex;
  }

  @override
  set pageIndex(int value) {
    _$pageIndexAtom.reportWrite(value, super.pageIndex, () {
      super.pageIndex = value;
    });
  }

  final _$contributeModeAtom =
      Atom(name: '_ContributeControllerBase.contributeMode');

  @override
  bool get contributeMode {
    _$contributeModeAtom.reportRead();
    return super.contributeMode;
  }

  @override
  set contributeMode(bool value) {
    _$contributeModeAtom.reportWrite(value, super.contributeMode, () {
      super.contributeMode = value;
    });
  }

  final _$_ContributeControllerBaseActionController =
      ActionController(name: '_ContributeControllerBase');

  @override
  dynamic changeIndex(int page) {
    final _$actionInfo = _$_ContributeControllerBaseActionController
        .startAction(name: '_ContributeControllerBase.changeIndex');
    try {
      return super.changeIndex(page);
    } finally {
      _$_ContributeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeToContributeMode(bool value) {
    final _$actionInfo = _$_ContributeControllerBaseActionController
        .startAction(name: '_ContributeControllerBase.changeToContributeMode');
    try {
      return super.changeToContributeMode(value);
    } finally {
      _$_ContributeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pageIndex: ${pageIndex},
contributeMode: ${contributeMode}
    ''';
  }
}
