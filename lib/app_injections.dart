import 'package:get_it/get_it.dart';

import 'map/services/category_service.dart';
import 'map/services/location_service.dart';
import 'marks/services/like_service.dart';

class AppInjections {
  GetIt getIt = GetIt.I;

  registerSingleton() {
    getIt.registerLazySingleton<CategoryService>(() => CategoryService());
    getIt.registerLazySingleton<MarkService>(() => MarkService());
    // getIt.registerLazySingleton<LocationService>(() => LocationService());
  }
}
