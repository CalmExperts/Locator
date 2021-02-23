// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthController on _AuthControllerBase, Store {
  final _$loggedInAtom = Atom(name: '_AuthControllerBase.loggedIn');

  @override
  bool get loggedIn {
    _$loggedInAtom.reportRead();
    return super.loggedIn;
  }

  @override
  set loggedIn(bool value) {
    _$loggedInAtom.reportWrite(value, super.loggedIn, () {
      super.loggedIn = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_AuthControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$userCreatedAtom = Atom(name: '_AuthControllerBase.userCreated');

  @override
  bool get userCreated {
    _$userCreatedAtom.reportRead();
    return super.userCreated;
  }

  @override
  set userCreated(bool value) {
    _$userCreatedAtom.reportWrite(value, super.userCreated, () {
      super.userCreated = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_AuthControllerBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$signInAsyncAction = AsyncAction('_AuthControllerBase.signIn');

  @override
  Future<AuthResultStatus> signIn() {
    return _$signInAsyncAction.run(() => super.signIn());
  }

  final _$googleSignInAsyncAction =
      AsyncAction('_AuthControllerBase.googleSignIn');

  @override
  Future<AuthResultStatus> googleSignIn() {
    return _$googleSignInAsyncAction.run(() => super.googleSignIn());
  }

  final _$_AuthControllerBaseActionController =
      ActionController(name: '_AuthControllerBase');

  @override
  bool changeLoading({bool loading}) {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.changeLoading');
    try {
      return super.changeLoading(loading: loading);
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loggedIn: ${loggedIn},
isLoading: ${isLoading},
userCreated: ${userCreated},
errorMessage: ${errorMessage}
    ''';
  }
}
