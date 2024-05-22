import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hikemaniak_app/screens/hike_details.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../constants.dart';
import '../model/hike.dart';
import '../theme.dart';

class UpcomingSelector extends StatefulWidget {
  const UpcomingSelector({super.key});

  @override
  State<UpcomingSelector> createState() => _UpcomingSelectorState();
}

class _UpcomingSelectorState extends State<UpcomingSelector> {
  List<Hike> hike = [];
  String formattedDate = '';

  @override
  void initState() {
    super.initState();
    fetchHikes();
  }

  Future<void> fetchHikes() async {
    final res = await http.get(Uri.parse('$BASE_URL/hike/index'));
    if (res.statusCode == 200) {
      // lets decode the res body to map
      Map<String, dynamic> resData = jsonDecode(res.body);

      // extract the list from map
      List<dynamic> hikes = resData['data'];
      setState(() {
        hike = hikes.map((data) => Hike.fromJson(data)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 10),
          width: double.infinity,
          //color: Colors.green,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Our Upcoming Adventures',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: lightColorScheme.primary,
                  fontFamily: 'Montserrat',
                ),
              ),
              Text('Amazing Experiences',
                  style: TextStyle(
                      fontSize: 14, color: Colors.black.withOpacity(0.35))),
            ],
          ),
        ),
        Container(
          height: 350,
          width: 700,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hike.length,
            itemBuilder: (context, index) {
              // Format the date
              DateTime dateTime = DateTime.parse(hike[index].date_time ?? '');
              formattedDate = DateFormat('MMMM, dd, yyyy').format(dateTime);

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HikeDetails(
                        hikeId: hike[index].id.toString(),
                      ),
                    ),
                  );
                },
                child: Card(
                  child: Container(
                    height: 335,
                    width: 250,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image:  DecorationImage(
                              image: NetworkImage(hike[index].image ??'assets/images/test.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10,),
                              Text(
                                hike[index].title ?? '',
                                style: TextStyle(
                                  color: lightColorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                                ),
                              ),
                              Text(
                                formattedDate, // Display formatted date here
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Stack(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.pin_drop,
                                        color: lightColorScheme.primary,
                                      ),
                                      Expanded(
                                        child: Text(
                                          hike[index].location ?? '',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("From"),
                                      SizedBox(width: 5,),
                                      Text(
                                        hike[index].ctnAmount ?? '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: lightColorScheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
