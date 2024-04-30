import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hikemaniak_app/model/hikeBooking.dart';
import 'package:hikemaniak_app/screens/admin/addHike.dart';
import 'package:hikemaniak_app/theme.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
class HomeGuide extends StatefulWidget {
  const HomeGuide({super.key});

  @override
  State<HomeGuide> createState() => _HomeGuideState();
}

class _HomeGuideState extends State<HomeGuide> {

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
            title: const Text('Guide Portal',
            style: TextStyle(
              fontSize: 14
            ),
            )
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
                color: Colors.lightBlueAccent,
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
                  color: lightColorScheme.primary,
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: const CircleAvatar(
                        backgroundImage:AssetImage('assets/user-profile.png',
                        ),
                        radius: 100,
                      ),
                    ),
                    const Text("Name:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                    const Text("Cyrus Doe",
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(height: 10,),
                    const Text("Bio",
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                    ),
                    const Text("Some Info about the admin or service provider Hello.Some Info about the admin provider.s",
                      style: TextStyle(fontWeight: FontWeight.w300),),
                    const SizedBox(height: 10,),
                    Card(
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 190,
                              width: 170,
                              child: const ListTile(
                                title: Text('Booked',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                subtitle: Text("30",
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
                                title: Text('Completed',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
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
                    const SizedBox(height: 10,),
                    const Text("Notifications",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54
                      ),
                    ),
                    Container(
                      height: 215,
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 75,
                            width: double.infinity,
                            child: Card(
                              child: Container(
                                height: 75,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("I'm Lost "),
                                        Text("Lat:30.9 , Lang:0.89"),
                                        Text("15:30 PM"),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: (){

                                      },
                                      child: Icon(Icons.call,
                                        color: lightColorScheme.primary,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
