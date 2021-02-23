import 'package:get_it/get_it.dart';
import 'package:locator/app/app_controller.dart';
import 'package:locator/app/controllers/auth_controller.dart';
import 'package:locator/app/controllers/map_controller.dart';

class AppInjections {
  GetIt getIt = GetIt.I;

  registerSingleton() {
    getIt.registerSingleton<AppController>(AppController());
    getIt.registerSingleton<AuthController>(AuthController());
    getIt.registerSingleton<MapController>(MapController());
  }
}
