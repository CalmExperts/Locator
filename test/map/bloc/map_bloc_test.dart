// import 'package:locator_app/map/bloc/map_bloc.dart';
// import 'package:bloc_test/bloc_test.dart';
// import 'package:locator_app/map/models/category.dart';

// void main() {
//   final Category testTopCategory = Category(
//     name: 'Test',
//     level: CategoryLevel.top,
//     childrenCategories: [],
//     description: '',
//     tags: {},
//     documentReference: null,
//   );
//   blocTest<MapBloc, MapEvent, MapState>(
//       'ActiveTopCategory is correctly set when SetActiveTopCategory is added',
//       build: () async => MapBloc(categoryService: null),
//       act: (mapBloc) async {
//         SetActiveTopCategory(
//           testTopCategory,
//         );
//       },
//       expect: [MapInitial().copyWith(activeTopCategory: testTopCategory)]);
// }
