import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class PastHikes extends StatefulWidget {
  const PastHikes({super.key});

  @override
  State<PastHikes> createState() => _PastHikesState();
}

class _PastHikesState extends State<PastHikes> {
  List<Map<String, dynamic>> hikeData = [];
  String userId = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      String fetchedUserId = await fetchUser();
      await fetchHike(fetchedUserId);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<String> fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    final url = Uri.parse('$BASE_URL/user');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      var userData = json.decode(response.body);
      setState(() {
        userId = userData['id'].toString();
      });
      print('User ID: $userId');
      return userId;
    } else {
      throw Exception('Failed to fetch user: ${response.statusCode}');
    }
  }

  Future<void> fetchHike(String id) async {
    final response = await http.get(
      Uri.parse('$BASE_URL/hike_booking/user_booking/$id'),
    );

    if (response.statusCode == 200) {
      setState(() {
        hikeData = List<Map<String, dynamic>>.from(json.decode(response.body)['data']);
      });
    } else {
      throw Exception('Failed to load hikes: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booked Hikes'),
      ),
      body: Container(
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
                      Image(
                        image: NetworkImage(hike['image'] ?? 'https://via.placeholder.com/150'),
                        fit: BoxFit.cover,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ref# ${booking['id'] ?? ''}",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              Text(
                                hike['title'] ?? '',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              const SizedBox(height: 1),
                              Text(
                                user['name'] ?? '',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              const SizedBox(height: 1),
                              Text(
                                booking['date_time'] ?? '',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Confirm'),
                              ),
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
        ),
      ),
    );
  }
}
