import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  _AppControllerBase() {
    verifyUser().then((value) => setUser(user.uid)).catchError((e) {
      print("Error app controller -> $e");
    });
  }

  @observable
  User user;

  @observable
  AuthStatus status = AuthStatus.loading;

  @action
  setUser(String value) {
    // user.uid = value;
    status = value == null ? AuthStatus.notLoggedIn : AuthStatus.loggedIn;
  }

  @action
  Future<User> verifyUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User firebaseUser = auth.currentUser;
    if (firebaseUser != null) {
      user = firebaseUser;
      print('USER ID -> ${user.uid}');
    }
    return user;
  }
}

enum AuthStatus { loading, loggedIn, notLoggedIn }
