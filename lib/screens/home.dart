import 'package:flutter/material.dart';
import 'package:hikemaniak_app/widgets/bottom_nav_selector.dart';
import 'package:hikemaniak_app/widgets/discover_selector.dart';
import 'package:hikemaniak_app/widgets/explore_selector.dart';
import 'package:hikemaniak_app/widgets/grid_selector.dart';
import 'package:hikemaniak_app/widgets/slider_selector.dart';
import 'package:hikemaniak_app/widgets/upcoming_selector.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNav(),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                DiscoverSelector(),
                SliderSelector(),
                ExploreSelector(),
                GridSelector(),
                UpcomingSelector(),
              ],
            )
          ],
        ),
      ),
    );
  }
}