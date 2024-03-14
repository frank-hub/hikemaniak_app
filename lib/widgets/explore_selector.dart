import 'package:flutter/material.dart';
import 'package:hikemaniak_app/theme.dart';

class ExploreSelector extends StatefulWidget {
  @override
  _ExploreSelectorState createState() => _ExploreSelectorState();
}

class _ExploreSelectorState extends State<ExploreSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 33, vertical: 24),
      width: double.infinity,
      //color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Explore',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: lightColorScheme.primary,
              fontFamily: 'Montserrat',
            ),
          ),
          Text('All trails',
              style: TextStyle(
                  fontSize: 14, color: Colors.black.withOpacity(0.35))),
        ],
      ),
    );
  }
}