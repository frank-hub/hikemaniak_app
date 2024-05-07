import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hikemaniak_app/constants.dart';
import 'package:hikemaniak_app/screens/book_hike.dart';
import 'package:hikemaniak_app/screens/map_trail.dart';
import 'package:hikemaniak_app/theme.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../model/hike.dart';

class HikeDetails extends StatefulWidget {
  final String hikeId;
  const HikeDetails({super.key, required this.hikeId});

  @override
  State<HikeDetails> createState() => _HikeDetailsState();
}

class _HikeDetailsState extends State<HikeDetails> {
  late Hike hike = Hike();
  String formattedDate = '';
  @override
  void initState() {
    super.initState();
    fetchHikeDetails();
  }

  Future<void> fetchHikeDetails() async {
    final url = Uri.parse('$BASE_URL/hike/show/${widget.hikeId}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Decode the response body
      Map<String, dynamic> responseData = json.decode(response.body);

      // Extract the event details from the "data" object
      Map<String, dynamic> hikeData = responseData['data'];

      setState(() {
        // Pass the extracted event data to Event.fromJson
        hike = Hike.fromJson(hikeData);
      });
      DateTime dateTime = DateTime.parse(hike.date_time.toString());
      formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    } else {
      throw Exception('Failed to load event details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hike Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(hike.image ?? 'null',
                fit: BoxFit.cover,
                height: 300,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 2,
                width: double.infinity,
                color: lightColorScheme.primary,
              ),
              const SizedBox(height: 10,),
              Text(capitalize(hike.title ?? 'null'),
                style: TextStyle(
                  color: lightColorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right
                                    : 5.0),
                                child: Icon(Icons.category_outlined,
                                  color: lightColorScheme.primary,
                                  size: 25,
                                ),
                              )
                          ),
                          const TextSpan(
                            text:'Category: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          TextSpan(
                            text:hike.difficulty ?? '',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          )
                        ]
                    ),
                  ),
                  const SizedBox(width: 50,),
                  RichText(
                    text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Icon(Icons.group,
                                  color: lightColorScheme.primary,
                                  size: 25,
                                ),
                              )
                          ),
                          const TextSpan(
                            text: "Group: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          TextSpan(
                            text: hike.maxSize ?? '',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                            ),
                          )
                        ]
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Icon(Icons.pin_drop,
                                  color: lightColorScheme.primary,
                                  size: 25,
                                ),
                              )
                          ),
                          TextSpan(
                            text: capitalize('Location: '),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          TextSpan(
                            text: capitalize(hike.location ?? ''),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          )
                        ]
                    ),
                  ),
                  const SizedBox(width: 10,),
                  RichText(
                    text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Icon(Icons.calendar_month,
                                color: lightColorScheme.primary,
                                size: 25,
                              )
                          ),
                          const TextSpan(
                            text: "Min Age: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          TextSpan(
                            text: hike.minAge ?? '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          )
                        ]
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Icon(Icons.today_sharp,
                                  color: lightColorScheme.primary,
                                  size: 25,
                                ),
                              )
                          ),
                          const TextSpan(
                            text: "Date: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          TextSpan(
                            text: formattedDate ?? '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          )
                        ]
                    ),
                  ),
                  const SizedBox(width: 10,),
                  RichText(
                    text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Icon(Icons.run_circle_outlined,
                                color: lightColorScheme.primary,
                                size: 25,
                              )
                          ),
                          const TextSpan(
                            text: "Difficulty: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          TextSpan(
                            text: hike.difficulty ?? '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          )
                        ]
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              const Text("Hike details",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold
              ),
              ),
              const SizedBox(height: 10,),
              Text(
                hike.desc ?? 'Hike Description'
              ),
              const SizedBox(height: 20,),
              const Text("What To Carry",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                height: 200,

                child:Text(
                  hike.whatCarry ?? ''
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=> MapPage(
                              start_lat: hike.start_lat.toString(),
                              start_lng:hike.start_lng.toString(),
                              end_lat: hike.end_lat.toString(),
                              end_lng: hike.end_lng.toString(),
                            ),
                        ));
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        decoration: BoxDecoration(
                            color: lightColorScheme.primary,
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.pin_drop_outlined,
                            size: 25,
                              color: Colors.white,
                            ),
                            Text("View Trail",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                fontWeight: FontWeight.w900
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=> BookHike(hikeId: hike.id.toString(),)
                        ));
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        decoration: BoxDecoration(
                            color: lightColorScheme.primary,
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.edit_calendar_outlined,
                            size: 25,
                              color: Colors.white,
                            ),
                            Text("Book Now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                fontWeight: FontWeight.w900
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  String capitalize(String s) => s.split(' ').map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '').join(' ');

}
