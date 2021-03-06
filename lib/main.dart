import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:locator_app/auth/auth.dart';
import 'package:locator_app/general/bloc_globals.dart';
import 'package:locator_app/map/bloc/map_bloc.dart';
import 'package:locator_app/map/services/category_service.dart';
import 'package:locator_app/map/services/drop_service.dart';
import 'package:locator_app/map/widgets/edit_card/animated_list_info.dart';
import 'package:locator_app/map/widgets/edit_card/bloc/card_bloc.dart';
import 'package:locator_app/marks/services/like_service.dart';
import 'package:locator_app/resources/colors.dart' show locatorTheme;
import 'package:locator_app/utils/firestore_utils.dart';
import 'package:locator_app/visual_widget_tests/create_card_tests.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import 'locale/locales.dart';
import 'map/route/map.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(Locator());
}

class Locator extends StatefulWidget {
  @override
  _LocatorState createState() => _LocatorState();
}

class _LocatorState extends State<Locator> {
  @override
  void initState() {
    GetIt.I
      ..registerLazySingleton<CategoryService>(() => CategoryService())
      ..registerLazySingleton<MarkService>(() => MarkService());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<Auth>(
      create: (context) => Auth()..silently(),
      child: MaterialApp(
        localizationsDelegates: [
          LocsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''),
          Locale('ru', ''),
        ],
        onGenerateTitle: (BuildContext context) => Locs.of(context).appName,
        debugShowCheckedModeBanner: false,
        theme: locatorTheme,
        home: MultiProvider(
          providers: [
            ProxyProvider<Auth, DropService>(
              create: (context) => DropService(user: null),
              update: (BuildContext context, value, previous) {
                if (value?.currentUser != previous?.user) {
                  return DropService(user: value.currentUser);
                } else {
                  return previous;
                }
              },
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<CardBloc>(
                create: (BuildContext context) {
                  final CardBloc cardBloc = CardBloc(
                    dropService:
                        Provider.of<DropService>(context, listen: false),
                    categoryService: GetIt.I.get<CategoryService>(),
                  );
                  GetIt.I.registerSingleton(cardBloc);
                  return cardBloc;
                },
                lazy: false,
              ),
              BlocProvider(
                create: (context) {
                  final MapBloc mapBloc =
                      MapBloc(categoryService: GetIt.I.get<CategoryService>());
                  GetIt.I.registerSingleton(mapBloc);
                  return mapBloc;
                },
                lazy: false,
              )
            ],
            child: Builder(builder: (BuildContext context) {
              return Stack(children: <Widget>[
                Scaffold(
                  drawer: Drawer(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Spacer(),
                        Flexible(
                            flex: 2,
                            child: Container(child: Text('Admin Controls'))),
                        Divider(),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              RaisedButton(
                                child: Text('Run'),
                                onPressed: () {
                                  convertDropCategoriesTagsToMaps();
                                },
                              ),
                              RaisedButton(
                                color: Colors.red[200],
                                child: Text('Delete Active Drop'),
                                onPressed: () {
                                  CardBloc.of(context).state.drop.delete();
                                  MapBloc.of(context).add(CloseCard());
                                },
                              ),
                              RaisedButton(
                                child: Text('Show visual widget proofs'),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext _) {
                                        return CreateCardTests(
                                          cardBloc: CardBloc.of(context),
                                          mapBloc: MapBloc.of(context),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MapPage(),
                  ),
                ),
              ]);
            }),
          ),
        ),
      ),
    );
  }
}

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: AnimatedListInfo()),
    );
  }
}

class MockData extends Mock {}
