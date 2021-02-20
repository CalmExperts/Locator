import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:locator/app_injections.dart';
import 'package:locator/resources/theme_changer.dart';
import 'auth/auth.dart';
import 'general/bloc_globals.dart';
import 'map/bloc/map_bloc.dart';
import 'map/services/category_service.dart';
import 'map/services/drop_service.dart';
import 'map/widgets/edit_card/animated_list_info.dart';
import 'map/widgets/edit_card/bloc/card_bloc.dart';
import 'marks/services/like_service.dart';
import 'resources/style/colors.dart' show locatorTheme;
import 'resources/style/themes.dart';
import 'utils/firestore_utils.dart';
import 'visual_widget_tests/create_card_tests.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import 'locale/locales.dart';
import 'map/route/map.dart';

import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(Locator());
}

class Locator extends StatefulWidget {
  @override
  _LocatorState createState() => _LocatorState();
}

class _LocatorState extends State<Locator> {
  AppInjections appInjections = AppInjections();

  @override
  void initState() {
    appInjections.registerSingleton();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Provider<Auth>(
      create: (context) => Auth()..getCurrentUser(),
      // child: ThemeBuilder(
      //   defaultBrightness: Brightness.dark,
      //   builder: (context, _brightness) {
      //     return MaterialApp(
      child: MaterialApp(
        theme: defaultTheme,
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
        // theme: darkModeTheme,
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
                  body: Container(
                    // padding: const EdgeInsets.all(18.0),
                    child: MapPage(),
                  ),
                ),
              ]);
            }),
          ),
        ),
      ),
    );
    //     },
    //   ),
    // );
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
