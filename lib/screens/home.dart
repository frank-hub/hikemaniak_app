import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hikemaniak_app/constants.dart';
import 'package:hikemaniak_app/widgets/bottom_nav_selector.dart';
import 'package:hikemaniak_app/widgets/discover_selector.dart';
import 'package:hikemaniak_app/widgets/explore_selector.dart';
import 'package:hikemaniak_app/widgets/grid_selector.dart';
import 'package:hikemaniak_app/widgets/slider_selector.dart';
import 'package:hikemaniak_app/widgets/upcoming_selector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/hike.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  String userName = '';
  List<Hike> hike = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Fetch user details from your API using the authentication token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('$BASE_URL/user');
    final response = await http.get(
        url,
      headers: {'Authorization': 'Bearer $token'}
    );

    if (response.statusCode == 200) {
      var userData = json.decode(response.body);
      setState(() {
        userName = userData['name'];
      });

    } else {
      userName = 'Please Login';
    }
  }


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
                DiscoverSelector(userName: this.userName,),
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