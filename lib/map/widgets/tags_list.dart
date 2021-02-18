import 'package:flutter/material.dart';
import 'package:locator/options/routes/options_page.dart';

class TagsList extends StatelessWidget {
  const TagsList();

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 85,
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      // width: 900,
      // color: Colors.red,
      child: ListView(
        // direction: Axis.horizontal,
        // crossAxisAlignment: WrapCrossAlignment.start,

        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),

        children: [

 Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child:
                //  TagChip(
                //   label: tag,
                //   color: Colors.white,
                //   backgroundColor: Colors.transparent,
                // ),
                Column(
              children: [
                FlatButton(
                  height: 45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Theme.of(context).disabledColor,
                        size: 22,
                      ),
                      Text(
                        // tag,
                        'OPTIONS',
                        style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  onPressed: () {
                    print('OPTIONS!');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OptionsPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child:
                //  TagChip(
                //   label: tag,
                //   color: Colors.white,
                //   backgroundColor: Colors.transparent,
                // ),
                Column(
              children: [
                FlatButton(
                  height: 45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Theme.of(context).disabledColor,
                        size: 22,
                      ),
                      Text(
                        // tag,
                        'UPDATE',
                        style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  onPressed: () {
                    print('UPDATE!');
                  },
                ),
                // Container(
                //   // color: Colors.blue,
                //   alignment: Alignment.center,
                //   padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                //   child: Text(
                //     // tag,
                //     'UPDATE',
                //     style: TextStyle(
                //         color: Colors.lightGreenAccent,
                //         fontSize: 12,
                //         fontWeight: FontWeight.normal),
                //   ),
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child:
                //  TagChip(
                //   label: tag,
                //   color: Colors.white,
                //   backgroundColor: Colors.transparent,
                // ),
                Column(
              children: [
                FlatButton(
                  height: 45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Theme.of(context).disabledColor,
                        size: 22,
                      ),
                      Text(
                        // tag,
                        'CONTRIBUTE',
                        style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  onPressed: () {
                    print('CONTRIBUTE!');
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child:
                //  TagChip(
                //   label: tag,
                //   color: Colors.white,
                //   backgroundColor: Colors.transparent,
                // ),

                Column(
              children: [
                FlatButton(
                  height: 45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Theme.of(context).disabledColor,
                        size: 22,
                      ),
                      Text(
                        // tag,
                        'CANT\' FIND SOMETHING',
                        style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  onPressed: () {
                    print('UPDATE!');
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child:
                //  TagChip(
                //   label: tag,
                //   color: Colors.white,
                //   backgroundColor: Colors.transparent,
                // ),
                Column(
              children: [
                FlatButton(
                  height: 45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Theme.of(context).disabledColor,
                        size: 22,
                      ),
                      Text(
                        // tag,
                        'UPDATE',
                        style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  onPressed: () {
                    print('UPDATE!');
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child:
                //  TagChip(
                //   label: tag,
                //   color: Colors.white,
                //   backgroundColor: Colors.transparent,
                // ),
                Column(
              children: [
                FlatButton(
                  height: 45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Theme.of(context).disabledColor,
                        size: 22,
                      ),
                      Text(
                        // tag,
                        'DONATE',
                        style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  onPressed: () {
                    print('DONATE!');
                  },
                ),
              ],
            ),
          ),
         
        ],

        // children: tags
        //     .map(
        //       (tag) =>

        //           ),
        //     )
        //     .toList(),
      ),
    );
  }
}

class TagCard extends StatelessWidget {
  final String tag;

  const TagCard({Key key, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: EdgeInsets.only(right: 3),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.8)),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        tag,
        style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16),
      ),
    );
  }
}
