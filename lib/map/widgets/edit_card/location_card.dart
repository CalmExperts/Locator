part of create_card;

class LocationCardView extends StatelessWidget {
  final TextEditingController locationController;
  final Category dropCategory;

  const LocationCardView({
    Key key,
    @required this.locationController,
    @required this.dropCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Where is this ${dropCategory.name} exactly?',
//          style: Theme.of(context).textTheme.subtitle,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        Container(
          child: TextField(
            controller: locationController,
            cursorColor: Theme.of(context).primaryColor,
            maxLength: 140,
            maxLines: null,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'E.g. on the second floor, in the lobby, etc.',
            ),
          ),
        ),
//
      ],
    );
  }
}
