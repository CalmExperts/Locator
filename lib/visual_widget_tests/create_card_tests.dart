import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:locator/map/bloc/map_bloc.dart';
import 'package:locator/map/models/category.dart';
import 'package:locator/map/models/drop.dart';
import 'package:locator/map/services/category_service.dart';
import 'package:locator/map/widgets/drop_card.dart';
import 'package:locator/map/widgets/edit_card/bloc/card_bloc.dart';
import 'package:locator/map/widgets/edit_card/create_card.dart';
import 'package:locator/map/widgets/edit_card/summary_card.dart';
import 'package:locator/resources/enums.dart';
import 'package:mockito/mockito.dart';

const double zoomLevel = 15;

class CreateCardTests extends StatefulWidget {
  final CardBloc cardBloc;
  final MapBloc mapBloc;

  const CreateCardTests({
    Key key,
    @required this.cardBloc,
    @required this.mapBloc,
  }) : super(key: key);

  @override
  _CreateCardTestsState createState() => _CreateCardTestsState();
}

class _CreateCardTestsState extends State<CreateCardTests> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: widget.cardBloc,
        ),
        BlocProvider.value(
          value: widget.mapBloc,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: <Widget>[
            FutureBuilder<LocationData>(
                future: Location().getLocation(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text('Loading'),
                    );
                  }
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          snapshot.data.latitude, snapshot.data.longitude),
                      zoom: zoomLevel,
                    ),
                  );
                }),
            Column(
              children: <Widget>[
                Spacer(flex: 1),
                Flexible(
                  flex: 2,
                  child: ListView(
                    children: <Widget>[
                      CategoryCardView(
                        onCategoryChosen: (_) {},
                      ),
                      CommentCardView(
                        openController: TextEditingController(),
                      ),
                      SummaryCardView(
                        drop: Drop(
                            category: Category.empty('Sample Category'),
                            tags: {
                              'Access': 'Inside',
                              'Wheelchair Accessible': 'True',
                              'Parking available': 'True'
                            }),
                      ),
                    ]
                        .map<Widget>(
                          (e) => DropCard(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              height: e is SummaryCardView ? 600 : 200,
                              child: e,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MockCategoryService extends Mock implements CategoryService {
  MockCategoryService() {
    when(topCategoryStream).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          [
            Category.empty('Sample 1'),
            Category.empty('Sample 2'),
          ],
        ),
      ),
    );
  }
}
