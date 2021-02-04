import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locator_app/map/models/tag.dart';
import 'package:locator_app/map/widgets/edit_card/bloc/card_bloc.dart';
import 'package:locator_app/map/widgets/edit_card/option_selector.dart';
import 'package:locator_app/utils/extensions.dart';

class TagsCard extends StatefulWidget {
  final Map<String, Tag> tags;

  const TagsCard({Key key, @required this.tags}) : super(key: key);

  @override
  _TagsCardState createState() => _TagsCardState();
}

class _TagsCardState extends State<TagsCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.tags == null || widget.tags.isEmpty) {
      return Center(
        child: Text('No tags'),
      );
    }
    return BlocBuilder<CardBloc, CardState>(builder: (context, state) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.tags.length,
        itemBuilder: (BuildContext context, int index) {
          final Tag tag = widget.tags.values.toList()[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
            child: OptionSelector(
              value: state.drop?.tags[tag.name],
              options: tag.options,
              leading: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  child: Text(
                    tag.name.capitalize(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              builder: (context, index) {
                return Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(tag.options[index].toString().capitalize()),
                );
              },
              onPressed: (value) {
                CardBloc.of(context).add(
                  UpdateDrop(
                      tags: Map.from(state.drop.tags ?? {})
                        ..[tag.name] = value),
                );
              },
            ),
          );
        },
      );
    });
  }
}
