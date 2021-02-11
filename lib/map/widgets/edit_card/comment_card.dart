part of create_card;

class CommentCardView extends StatelessWidget {
  final TextEditingController openController;

  const CommentCardView({
    Key key,
    @required this.openController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'ADD A COMMENT', //'When is this ${dropCategory.name} available for use?',
            style: Theme.of(context).textTheme.headline6,
          ),
          Container(
            child: TextField(
              controller: openController,
              cursorColor: Theme.of(context).primaryColor,
              maxLength: 140,
              maxLines: null,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  hintText:
                      'E.g., ice-skating rinks are only open in winter, etc'),
              onEditingComplete: () {
                print('editing complete!');
              },
            ),
          ),
        ],
      ),
    );
  }
}
