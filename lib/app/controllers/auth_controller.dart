import 'package:locator/app/errors/auth_errors.dart';
import 'package:locator/app/models/user_model.dart';
import 'package:locator/app/repositores/auth_repository.dart';
import 'package:mobx/mobx.dart';
part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  AuthRepository _authRepository = AuthRepository();

  UserModel model = UserModel();

  @observable
  bool loggedIn = false;

  @observable
  bool isLoading = false;

  @action
  bool changeLoading({bool loading}) {
    return isLoading = loading;
  }

  @observable
  bool userCreated = false;

  @observable
  String errorMessage = "";

  @action
  Future<AuthResultStatus> signIn() async {
    final status = await _authRepository.signIn(model);
    if (status == AuthResultStatus.successful) {
      loggedIn = true;
    } else {
      errorMessage = AuthExceptionHandler.generateExceptionMessage(
        status,
      );
      loggedIn = false;
    }
    return status;
  }

  @action
  Future<AuthResultStatus> googleSignIn() async {
    isLoading = true;
    final status = await _authRepository.googleSignIn();
    if (status == AuthResultStatus.successful) {
      loggedIn = true;
      isLoading = false;
    } else {
      errorMessage = AuthExceptionHandler.generateExceptionMessage(
        status,
      );
      loggedIn = false;
      isLoading = false;
    }
    return status;
  }
}
