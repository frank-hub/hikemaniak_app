import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hikemaniak_app/constants.dart';
import 'package:hikemaniak_app/screens/book_hike.dart';
import 'package:hikemaniak_app/screens/map_trail.dart';
import 'package:hikemaniak_app/theme.dart';
import 'package:http/http.dart' as http;
import '../model/hike.dart';

class HikeDetails extends StatefulWidget {
  final String hikeId;
  const HikeDetails({super.key, required this.hikeId});

  @override
  State<HikeDetails> createState() => _HikeDetailsState();
}

class _HikeDetailsState extends State<HikeDetails> {
  late Hike hike = Hike();

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
              Center(
                child: Text(hike.title ?? 'null',
                  style: TextStyle(
                    color: lightColorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Icon(Icons.calendar_month,
                                color: lightColorScheme.primary,
                                size: 18,
                              )
                          ),
                          TextSpan(
                            text:hike.date_time ?? '',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          )
                        ]
                    ),
                  ),
                  const SizedBox(width: 15,),
                  RichText(
                    text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Icon(Icons.group,
                                color: lightColorScheme.primary,
                                size: 18,
                              )
                          ),
                          const TextSpan(
                            text: "Group: 5",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          )
                        ]
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Icon(Icons.calendar_month,
                                color: lightColorScheme.primary,
                                size: 18,
                              )
                          ),
                          const TextSpan(
                            text: "To: 17-Mar-2024 19:00",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          )
                        ]
                    ),
                  ),
                  const SizedBox(width: 15,),
                  RichText(
                    text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Icon(Icons.pin_drop,
                                color: lightColorScheme.primary,
                                size: 18,
                              )
                          ),
                          TextSpan(
                            text: hike.location ?? '',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          )
                        ]
                    ),
                  ),
                ],
              ),
        
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Icon(Icons.run_circle_rounded,
                                color: lightColorScheme.primary,
                                size: 18,
                              )
                          ),
                          const TextSpan(
                            text: "Category:",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: hike.difficulty,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          )
                        ]
                    ),
                  ),
                  const SizedBox(width: 115,),
                  RichText(
                    text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Icon(Icons.group,
                                color: lightColorScheme.primary,
                                size: 18,
                              )
                          ),
                          const TextSpan(
                            text: "Group: 5",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          )
                        ]
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15,),
              const Text("Tour details",
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
              const SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Start Point:",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold
                      )
                    ),
                    TextSpan(
                      text: hike.start_point ?? '',
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                      )
                    ),
                  ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder:
                        (context)=> MapPage(),
                    ));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: lightColorScheme.primary,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(
                      child: Text("VIEW TRAIL",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                      ),
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
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: lightColorScheme.primary,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(
                      child: Text("BOOK NOW",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
