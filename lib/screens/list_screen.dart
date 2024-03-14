import 'package:flutter/material.dart';
import 'package:hikemaniak_app/screens/hike_details.dart';
import 'package:hikemaniak_app/screens/map_screen.dart';
import 'package:hikemaniak_app/widgets/bottom_nav_selector.dart';

import '../theme.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
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
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:
                          (context)=> HikeDetails()
                          ));
                        },
                        child: Card(
                          child: Container(
                            height: 335,
                            width: 250,
                            padding: const EdgeInsets.all(10),
                            child:Column(
                              children: [
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/test.jpg'),
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
                                      Text('4 Days Mt Kenya Naromoru -Sirimon',
                                        style: TextStyle(
                                            color: lightColorScheme.primary,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      const Text('August 15, 2024',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),

                                      Stack(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(Icons.pin_drop,
                                                color: lightColorScheme.primary,),
                                              Expanded(
                                                child: Text('Naromoru',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text("From"),
                                              SizedBox(width: 5,),
                                              Text(
                                                '44500',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: lightColorScheme.primary
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
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
}