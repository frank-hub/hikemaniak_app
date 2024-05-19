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

  List<Map<String, dynamic>> hikeData = [];
  List<Map<String, dynamic>> confirmedHike = [];

  @override
  void initState() {
    super.initState();
    fetchHike();
    fetchBooked();
  }

  Future<void> fetchBooked() async {
    final response = await http.get(Uri.parse('$BASE_URL/hike_booking/confirmedBooking'));
      if(response.statusCode == 200){
        setState(() {
          confirmedHike = List<Map<String,dynamic>>.from(json.decode(response.body)['data']);
        });
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong'),
            backgroundColor: Colors.red,
          )
        );
      }

    try{

    }catch(e){

    }
  } 
  
  
  
  
  
  Future<void> fetchHike() async {
    final response = await http.get(Uri.parse('$BASE_URL/hike_booking/index'));
    debugPrint('worked');

    try{
      if (response.statusCode == 200) {

        setState(() {
          hikeData = List<Map<String, dynamic>>.from(json.decode(response.body)['data']);

        });
      } else {
        throw Exception('Failed to load events');
      }
    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something Went Wrong$e'))
      );
    }
  }
  Future<void> _confirmBooking(var id,int index,int btnStatus) async {
    final response = await http.get(Uri.parse('$BASE_URL/hike_booking/status/${id}'));
    
    try{
      if(response.statusCode == 200)
        {
          Map<String,dynamic> message = json.decode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message['message'] as String)
          ));

          setState(() {
            // Remove the confirmed booking from the list
            if(btnStatus == 1){
              confirmedHike.removeAt(index);
            }else{
              hikeData.removeAt(index);
            }
          });

        }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.statusCode.toString())
            ));
      }
      
      
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Please Try Again$e'))
      );
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
                        (context)=> const Notifications()
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
              (context)=> const AddHike()
              ));
            },
            child: const Icon(Icons.add),
          ),
          body: TabBarView(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: Colors.grey.withOpacity(0.3),
                child: ListView.builder(
                  itemCount: hikeData.length,
                  itemBuilder: (context, index) {
                    final booking = hikeData[index]['booking'];
                    final hike = hikeData[index]['hike'];
                    final user = hikeData[index]['user'];

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
                                      Text("Ref# ${booking['id']}" ?? '',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                      Text(hike['title'] ?? '',
                                      textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          letterSpacing: 0.2
                                        ),
                                      ),
                                      const SizedBox(height: 1,),
                                      Text(user['name'] ?? '',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                      const SizedBox(height: 1,),
                                      Text(booking['date_time'] ?? '',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                      TextButton(onPressed: (){
                                        _confirmBooking(booking['id'],index,0);
                                      },
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
                    itemCount: confirmedHike.length,
                    itemBuilder: (context, index) {
                      final booking = confirmedHike[index]['booking'];
                      final hike = confirmedHike[index]['hike'];
                      final user = confirmedHike[index]['user'];

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
                                        Text("Ref# ${booking['id']}" ?? '',
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              letterSpacing: 0.2
                                          ),
                                        ),
                                        Text(hike['title'] ?? '',
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              letterSpacing: 0.2
                                          ),
                                        ),
                                        const SizedBox(height: 1,),
                                        Text(user['name'] ?? '',
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              letterSpacing: 0.2
                                          ),
                                        ),
                                        const SizedBox(height: 1,),
                                        Text(booking['date_time'] ?? '',
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              letterSpacing: 0.2
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text('Are you sure ? , If Yes Double Tap'),
                                              )
                                            );
                                          },
                                          onDoubleTap: (){
                                            _confirmBooking(booking['id'],index,1);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                                            ),
                                            child: const Text(
                                              "Cancel",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: CircleAvatar(
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
                          const Expanded(
                            child: Text("Some Info about the admin or service provider Hello.Some Info about the admin provider.s",
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
                              margin: const EdgeInsets.all(8.0),
                              width: 120.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: const DecorationImage(
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
                          const Row(
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
                          const Row(
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
                          const Row(
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
                          const Row(
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
