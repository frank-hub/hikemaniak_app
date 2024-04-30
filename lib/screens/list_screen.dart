import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hikemaniak_app/constants.dart';
import 'package:hikemaniak_app/screens/hike_details.dart';
import 'package:hikemaniak_app/screens/map_screen.dart';
import 'package:hikemaniak_app/widgets/bottom_nav_selector.dart';

import '../model/hike.dart';
import '../theme.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
List<Hike> hike =[];

  @override
  void initState() {
    super.initState();
    fetchHike();
  }

  Future<void> fetchHike() async {
    final response = await http.get(Uri.parse('$BASE_URL/hike/index'));
    debugPrint('worked');

    if (response.statusCode == 200) {

      // Decode the response body into a map
      Map<String, dynamic> responseData = json.decode(response.body);

      // Extract the list of events from the map using the appropriate key
      List<dynamic> hikeData = responseData['data'];

      setState(() {
        hike = hikeData.map((data) => Hike.fromJson(data)).toList();
      });
    } else {
      throw Exception('Failed to load events');
    }
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNav(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              //color: Colors.green,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                            icon: Image.asset(
                              'assets/images/backicon.png',
                              height: 25,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        Text(
                          'Mountains',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 41,
                          width: 41,
                          child: CircleAvatar(
                            child: ClipOval(
                              child: Image(
                                image: AssetImage('assets/images/profile.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromRGBO(92, 214, 115, 1)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapScreen(),
                      ),
                    );
                  },
                  child: Container(
                    //color: Colors.lightBlue,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(
                          'assets/images/map.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 24,
                  child: Padding(
                    padding: EdgeInsets.only(left: 32),
                    child: Text('Check activities\nnearby',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        )),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                width: double.infinity,
                child: ListView.builder(
                    itemCount: hike.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:
                          (context)=> HikeDetails(hikeId:hike[index].id.toString())
                          ));
                        },
                        child: Card(
                          child: Container(
                            height: 329,
                            width: 250,
                            padding: const EdgeInsets.all(10),
                            child:Column(
                              children: [
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            hike[index].image ?? 'assets/images/test.jpg'),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10,),
                                      Text(capitalize(hike[index].title ?? 'Title'),

                                        style: TextStyle(
                                          color: lightColorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                        ),
                                      ),

                                      Stack(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(Icons.pin_drop,
                                                color: lightColorScheme.primary,
                                                size: 30,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: Text(capitalize(hike[index].location ?? 'Location'),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Icon(Icons.attach_money,
                                                color: lightColorScheme.primary,
                                                size: 20,
                                              ),
                                              Text(
                                                hike[index].amount ?? 'amount',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: lightColorScheme.primary
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      RichText(text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                                child: Container(

                                                  child: Icon(Icons.category_outlined,
                                                  color: lightColorScheme.primary,
                                                    size: 30,
                                                  ),
                                                  padding: EdgeInsets.only(right: 5),
                                                )
                                            ),
                                            TextSpan(
                                                text: capitalize(hike[index].difficulty ?? 'Levels'),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),
                                            )
                                          ]
                                      )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
  String capitalize(String s) => s.split(' ').map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '').join(' ');

}