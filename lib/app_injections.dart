import 'package:get_it/get_it.dart';
import 'package:locator/controllers/contribute_controller.dart';
import 'package:locator/controllers/options_controller.dart';

import 'map/services/category_service.dart';
import 'map/services/location_service.dart';
import 'marks/services/like_service.dart';

class AppInjections {
  GetIt getIt = GetIt.I;

  registerSingleton() {
    getIt.registerLazySingleton<OptionsController>(() => OptionsController());
    getIt.registerLazySingleton<ContributeController>(
        () => ContributeController());
    getIt.registerLazySingleton<CategoryService>(() => CategoryService());
    getIt.registerLazySingleton<MarkService>(() => MarkService());
    // getIt.registerLazySingleton<LocationService>(() => LocationService());
  }
}
