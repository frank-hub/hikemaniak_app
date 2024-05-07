import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hikemaniak_app/model/hikeBooking.dart';
import 'package:hikemaniak_app/screens/admin/addHike.dart';
import 'package:hikemaniak_app/screens/notifications.dart';
import 'package:hikemaniak_app/theme.dart';
import 'package:http/http.dart' as http;
import 'package:icons_plus/icons_plus.dart';

import '../../constants.dart';
class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {

  List<HikeBook> hike =[];

  @override
  void initState() {
    super.initState();
    fetchHike();
  }

  Future<void> fetchHike() async {
    final response = await http.get(Uri.parse('$BASE_URL/hike_booking/index'));
    debugPrint('worked');

    if (response.statusCode == 200) {

      // Decode the response body into a map
      Map<String, dynamic> responseData = json.decode(response.body);

      // Extract the list of events from the map using the appropriate key
      List<dynamic> hikeData = responseData['data'];

      setState(() {
        hike = hikeData.map((data) => HikeBook.fromJson(data)).toList();
      });
    } else {
      throw Exception('Failed to load events');
    }
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child:Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text('Booked'),
                ),
                Tab(
                  child: Text('Status'),
                ),
                Tab(
                  child: Text('Profile'),
                )
              ],
            ),
            title: const Text('Admin Portal',
            style: TextStyle(
              fontSize: 14
            ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder:
                        (context)=> Notifications()
                    ));
                  }, // Call _createEvent method on tap
                  child: Icon(Icons.notifications_active,
                    size: 25,
                    color: lightColorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:
              (context)=> AddHike()
              ));
            },
            child: Icon(Icons.add),
          ),
          body: TabBarView(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: Colors.grey.withOpacity(0.3),
                child: ListView.builder(
                  itemCount: hike.length,
                  itemBuilder: (context, index) {
                    // int bookingId = hike[index].booking.id;

                    return Container(
                      height: 150,
                      width: double.infinity,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Image(image: AssetImage('assets/images/details.jpg')),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(hike[index].car_pooling ?? '',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                      const Text("Mt Kenya Day Dash – Sirimon",
                                      textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 12,
                                          letterSpacing: 0.2
                                        ),
                                      ),
                                      const SizedBox(height: 1,),
                                      const Text("Cyrus Doe",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                      const SizedBox(height: 1,),
                                      const Text("17-Mar-2024 19:00",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                      TextButton(onPressed: (){},
                                          child: const Text('Confirm'))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: lightColorScheme.primary.withOpacity(0.2),
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 150,
                        width: double.infinity,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Image(image: AssetImage('assets/images/details.jpg')),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text("Ref# 2001",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 12,
                                              letterSpacing: 0.2
                                          ),
                                        ),
                                        const Text("Mt Kenya Day Dash – Sirimon",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 12,
                                              letterSpacing: 0.2
                                          ),
                                        ),
                                        const SizedBox(height: 1,),
                                        const Text("Cyrus Doe",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 12,
                                              letterSpacing: 0.2
                                          ),
                                        ),
                                        const SizedBox(height: 1,),
                                        const Text("17-Mar-2024 19:00",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 12,
                                              letterSpacing: 0.2
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                                          ),
                                          child: const Text(
                                            "Completed",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )

                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: const CircleAvatar(
                          backgroundImage:AssetImage('assets/user-profile.png',
                          ),
                          radius: 70,
                        ),
                      ),
                      const Text("Name:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Cyrus Doe",
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),
                          ),
                          Icon(Clarity.note_edit_line,
                            size: 25,
                            color: lightColorScheme.primary,
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),
                      const Text("Bio",
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: const Text("Some Info about the admin or service provider Hello.Some Info about the admin provider.s",
                              style: TextStyle(fontWeight: FontWeight.w500),),
                          ),
                          Icon(Clarity.note_edit_line,
                            size: 25,
                            color: lightColorScheme.primary,
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),
                      const Text("Photos",
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),
                      ),
                      Container(
                        width: double.infinity,
                        height: 125,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(8.0),
                              width: 120.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/hike.jpeg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Text("Trails",
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Bootstrap.dot),
                              Text("Mt Kenya 3 day Batian Climb",
                                style: TextStyle(
                                    fontSize: 13,
                                    letterSpacing: 0.1
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Bootstrap.dot),
                              Text("4 Days Mt Kenya Naromoru -Sirimon",
                                style: TextStyle(
                                    fontSize: 13,
                                    letterSpacing: 0.1
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Bootstrap.dot),
                              Text("Mt Kenya Point Peter",
                                style: TextStyle(
                                    fontSize: 13,
                                    letterSpacing: 0.1
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Bootstrap.dot),
                              Text("4 Days Mt Kenya Lakes Tour – Chogoria – Naromoru",
                                style: TextStyle(
                                    fontSize: 13,
                                    letterSpacing: 0.1
                                ),
                              )
                            ],
                          ),
                          Icon(Clarity.note_edit_line,
                            size: 25,
                            color: lightColorScheme.primary,
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Card(
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 190,
                                width: 180,
                                child: const ListTile(
                                  title: Text('People Guided',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Text("118",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 190,
                                width: 200,
                                child: const ListTile(
                                  title: Text('Hikes Completed',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Text("3000",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
