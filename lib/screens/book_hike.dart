import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../theme.dart';

class BookHike extends StatefulWidget {
  final String hikeId;
  const BookHike({super.key,required this.hikeId});

  @override
  State<BookHike> createState() => _BookHikeState();
}

class _BookHikeState extends State<BookHike> {
  late String hike;

  bool _isLoading = false;
  final _dateFormat = DateFormat('yyyy-MM-dd');
  DateTime _selectedDate = DateTime.now();
  String nationality = 'Tourist';
  String no_adults = '';
  String no_kids = '';
  String add_info = '';
  var car_pooling;
  String userId = '';


  TextEditingController no_adultsController = TextEditingController();
  TextEditingController no_kidsController = TextEditingController();
  TextEditingController add_infoController = TextEditingController();




  Future<void> _bookNow() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('$BASE_URL/hike_booking/store');
    // Create a multipart request
    var request = http.MultipartRequest('POST', url);

    // Add text fields to the request
    request.fields['nationality'] = nationality;
    request.fields['hikeId'] = widget.hikeId;
    request.fields['userId'] = userId;
    request.fields['car_pooling'] = car_pooling;
    request.fields['date_time'] = _selectedDate.toIso8601String();
    request.fields['no_adults'] = no_adults;
    request.fields['no_kids'] = no_kids;
    request.fields['add_info'] = add_info;


    // Send the request
    var response = await request.send();

    // Process the response
    if (response.statusCode == 200) {
      // Request successful
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hike Successfully Saved'),
          backgroundColor: Colors.green,
        ),
      );
      // Handle the response data
      // Clear text fields

      no_adultsController.clear();
      no_kidsController.clear();
      add_infoController.clear();

    } else {
      // Request failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to Book hike'+response.statusCode.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });

  }

  @override
  void initState() {
    super.initState();
    hike = widget.hikeId;
    fetchUserData();
  }

  Future<void> fetchUserData() async {
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
        userId = userData['id'].toString();
      });
    } else {
      userId = 'Please Login';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Hike'),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
            child: Container(
                    padding: const EdgeInsets.all(20),
                    height: 740,
                    decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
                    ),
                    child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Nationality',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: nationality,
                onChanged: (newValue) {
                  setState(() {
                    nationality = newValue!;
                  });
                },
                items: ['Tourist','Resident','Citizen']
                    .map((serviceProvider) {
                  return DropdownMenuItem<String>(
                    value: serviceProvider,
                    child: Text(serviceProvider),
                  );
                }).toList(),
                hint: Text('Hike Difficulty'),
              ),
              SizedBox(height: 20,),
              const Text(
                'Date & Time (When you want to do the hike)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Card(
                child: Container(

                  padding: EdgeInsets.all(5),
                  child: ListTile(
                    subtitle: Text(_selectedDate.toString()),
                    onTap: () async {
                      DateTime? pickedDateTime = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDateTime != null) {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(_selectedDate!),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            _selectedDate = DateTime(
                              pickedDateTime.year,
                              pickedDateTime.month,
                              pickedDateTime.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                          });
                        }
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Number Of Adults',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: no_adultsController,
                onChanged: (value){
                  setState(() {
                    no_adults = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Select number of adults'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              const Text(
                'Number of Kids',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: no_kidsController,
                onChanged: (value){
                  setState(() {
                    no_kids = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Number of kids'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              Text("Open for carpooling?",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Radio(
                    value: 'Yes',
                    groupValue: car_pooling,
                    onChanged: (value) {
                      setState(() {
                        car_pooling = value!;
                      });
                    },
                  ),
                  Text("Yes"),
                  Radio(
                    value: 'No',
                    groupValue: car_pooling,
                    onChanged: (value) {
                      setState(() {
                        car_pooling = value!;
                      });
                    },
                  ),
                  Text("No"),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Additional Information',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: add_infoController,
                onChanged: (value){
                  setState(() {
                    add_info = value;
                  });
                },
                maxLines: null, // Allows multiple lines for additional information
                decoration: InputDecoration(
                  hintText: 'Enter additional information',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _bookNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightColorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "BOOK NOW",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
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
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}


