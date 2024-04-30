import 'package:flutter/material.dart';
import 'package:hikemaniak_app/screens/list_screen.dart';

import '../screens/hiking_screen.dart';

class SliderSelector extends StatefulWidget {
  @override
  _SliderSelectorState createState() => _SliderSelectorState();
}

class _SliderSelectorState extends State<SliderSelector> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Image.asset(
            'assets/images/ladywriting.jpg',
            fit: BoxFit.cover,
            height: 250,
            width: 380,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListScreen(),
              ),
            );
          },
          child: Container(
            width: 380,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                  begin: FractionalOffset.bottomCenter,
                  end: FractionalOffset.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.05),
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.1),
                  ]),
            ),
          ),
        ),
        Positioned(
          top: 18,
          child: Container(
            height: 22,
            width: 52,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                )),
            child: Center(
              child: Text('STATUS',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  )),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            //color: Colors.lightBlue,
            width: 320,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Difficulty level: Medium',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 50),
                    Row(
                      children: <Widget>[
                        Text(
                          '4.5',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(width: 5),
                        Image.asset(
                          'assets/images/stars.png',
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    Text(
                        'Unlock your full potential with our hiking tour.\nExplore the best hiking sights with us!!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}