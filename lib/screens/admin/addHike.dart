// Set language version to 2.12
// ignore_for_file: prefer_const_constructors
// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:hikemaniak_app/constants.dart';
import 'package:hikemaniak_app/controller/hike_service.dart';
import 'package:hikemaniak_app/screens/admin/updateHike.dart';
import 'package:hikemaniak_app/theme.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_webservice/places.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../model/hike.dart';
//

class AddHike extends StatefulWidget {
  const AddHike({Key? key}) : super(key: key);

  @override
  State<AddHike> createState() => _AddHikeState();
}

class _AddHikeState extends State<AddHike> {
  bool _locationPermissionGranted = false;
  bool _isLoading = false;
  hikeService hikesService =  hikeService();
  List<Hike> hike = [];

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    fetchHikes();
  }

  Future<void> fetchHikes() async{
    final response = await http.get(Uri.parse('$BASE_URL/hike/index'));

    try{
      if(response.statusCode == 200){
        Map<String,dynamic> resData = json.decode(response.body);
        List<dynamic> hikes = resData['data'];
        setState(() {
          hike = hikes.map((data) => Hike.fromJson(data)).toList();
        });
      }
    }catch(e){
      print(e);
    }
  }

  File? _imageFile;

  Future<void> _getImage() async {

    final status = await Permission.storage.request();

    if (status.isGranted) {
      print('I have been given access !!!');
      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path as String);
        } else {
          print('No image selected.');
        }
      });
    } else {
      print('I have been given no access !!!');
      final newStatus = await Permission.storage.request();
      print('I have been given access !!!');
      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path as String);
        } else {
          print('No image selected.');
        }
      });
    }
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController date_timeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController start_pointController = TextEditingController();
  TextEditingController end_pointController = TextEditingController();
  TextEditingController ctzPriceController = TextEditingController();
  TextEditingController restPriceController = TextEditingController();
  TextEditingController trstPriceController = TextEditingController();
  TextEditingController whatCarryController = TextEditingController();
  TextEditingController addActivitiesController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController minAgeController = TextEditingController();
  List<Map<String, dynamic>> _suggestions = [];
  List<Map<String, dynamic>> _EndSuggestions= [];
  late double latStart;
  late double lngStart;
  late double latEnd;
  late double lngEnd;

  void _fetchSuggestions(String input) async {
    final response = await http.get(
      Uri.parse('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$GOOGLE_MAPS_API_KEY'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _suggestions = List<Map<String, dynamic>>.from(data['predictions'].map((prediction) => {
          'description': prediction['description'],
          'placeId': prediction['place_id'],
        }));
      });
    } else {
      throw Exception('Failed to fetch suggestions');
    }
  }

  void _getPlaceDetails(String placeId) async {
    final response = await http.get(
      Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$GOOGLE_MAPS_API_KEY'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final result = data['result'];
      if (result != null) {
        final geometry = result['geometry'];
        if (geometry != null) {
          final location = geometry['location'];
          if (location != null) {
            latStart = location['lat'];
            lngStart = location['lng'];
            print('Latitude: $latStart, Longitude: $lngStart');
          } else {
            print('Location data is null');
          }
        } else {
          print('Geometry data is null');
        }
      } else {
        print('Result data is null');
      }
    } else {
      throw Exception('Failed to fetch place details');
    }
  }

  void _selectSuggestion(int index) {
    _getPlaceDetails(_suggestions[index]['placeId']);
    start_pointController.text = _suggestions[index]['description'];
    setState(() {
      _suggestions.clear();
    });
  }


  void _fetchEndSuggestions(String input) async {
    final response = await http.get(
      Uri.parse('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$GOOGLE_MAPS_API_KEY'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _EndSuggestions = List<Map<String, dynamic>>.from(data['predictions'].map((prediction) => {
          'description': prediction['description'],
          'placeId': prediction['place_id'],
        }));
      });
    } else {
      throw Exception('Failed to fetch suggestions');
    }
  }

  void _getEndPlaceDetails(String placeId) async {
    final response = await http.get(
      Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$GOOGLE_MAPS_API_KEY'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final result = data['result'];
      if (result != null) {
        final geometry = result['geometry'];
        if (geometry != null) {
          final location = geometry['location'];
          if (location != null) {
            latEnd = location['lat'];
            lngEnd = location['lng'];
            print('Latitude: $latEnd, Longitude: $lngEnd');
          } else {
            print('Location data is null');
          }
        } else {
          print('Geometry data is null');
        }
      } else {
        print('Result data is null');
      }
    } else {
      throw Exception('Failed to fetch place details');
    }
  }
  void _selectEndSuggestion(int index) {
    _getEndPlaceDetails(_EndSuggestions[index]['placeId']);
    end_pointController.text = _EndSuggestions[index]['description'];
    setState(() {
      _EndSuggestions.clear();
    });
  }


  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.request();
    setState(() {
      _locationPermissionGranted = status == PermissionStatus.granted;
    });
  }

  String category = 'Forest';
  String difficulty_level = '1 Easy';
  String title = '';
  String desc = '';
  String image = '';
  DateTime date_time = DateTime.now();
  String location = '';
  late String start_point = '';
  String end_point = '';
  String amount = '';

  bool Village_Experience = false;
  bool Culture_Show = false;
  bool Bird_Watching = false;
  bool Swimming = false;
  bool Local_Cuisines = false;
  bool Other =false;


  Future<void> _createEvent() async {

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('$BASE_URL/hike/store');

    // Create a multipart request
    var request = http.MultipartRequest('POST', url);

    // Add text fields to the request

    request.fields['category'] = category;
    request.fields['title'] = title;
    request.fields['desc'] = desc;
    request.fields['date_time'] = date_time.toIso8601String();
    request.fields['location'] = location;
    request.fields['start_point'] = start_pointController.text;
    request.fields['end_point'] = end_pointController.text;

    request.fields['start_lat'] = latStart.toString();
    request.fields['start_lng'] = lngStart.toString();
    request.fields['end_lat'] = latEnd.toString();
    request.fields['end_lng'] = lngEnd.toString();

    request.fields['ctnAmount'] = ctzPriceController.text;
    request.fields['resAmount'] = restPriceController.text;
    request.fields['trstAmount'] = trstPriceController.text;
    request.fields['whatCarry'] = whatCarryController.text;
    request.fields['addActivities'] = 'Add Later';
    request.fields['difficulty'] = difficulty_level;
    request.fields['maxSize'] = maxController.text;
    request.fields['minAge'] = minAgeController.text;
    // Add other fields as needed

    // Add image file to the request
    final _imageFile = this._imageFile;
    if (_imageFile != null) {
      print("Image uploaded file found");
      try {
        var imageStream = http.ByteStream(_imageFile.openRead());
        var length = await _imageFile.length();
        var multipartFile = http.MultipartFile('image', imageStream, length,
            filename: _imageFile.path.split('/').last);
        request.files.add(multipartFile);
        print(multipartFile.filename);
      } catch (e) {
        print("Error uploading image: $e");
        // Handle image upload error (e.g., show a snackbar to the user)
      }
    }

    // Send the request
    try {

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      // Process the response
      if (response.statusCode == 200) {
        // Request successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hike Successfully Saved'),
            backgroundColor: Colors.green,
          ),
        );

        // Handle the response data (if applicable)
        // Uncomment if you want to parse the response JSON
        // final data = jsonDecode(response.body);
        // final createdHike = Hike.fromJson(data);
        // // Handle the created hike object

        // Clear text fields
        start_pointController.clear();
        titleController.clear();
        descController.clear();
        ctzPriceController.clear();
        restPriceController.clear();
        trstPriceController.clear();

      } else {
        // Request failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Oops Failed to save hike"+responseBody.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print("Error creating hike: $e");
      // Handle other errors during request or response processing
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Hike Creation',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: false,
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text('New Trail'),
              ),
              Tab(
                child: Text('Edit Trails'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: category,
                          onChanged: (newValue) {
                            setState(() {
                              category = newValue!;
                            });
                          },
                          items: ['Forest', 'Water', 'Rock', 'Alpine','Moorland','Camping']
                              .map((serviceProvider) {
                            return DropdownMenuItem<String>(
                              value: serviceProvider,
                              child: Text(serviceProvider,
                                style: TextStyle(
                                    color: Color(0xff545454),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          }).toList(),
                          hint: Text('Hike Difficulty'),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: titleController,
                          onChanged:(value){
                            setState(() {
                              title = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Hike Title',
                            labelStyle: TextStyle(
                                color: Color(0xff545454),
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:lightColorScheme.primary),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightColorScheme.primary),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: descController,
                          onChanged: (value) {
                            setState(() {
                              desc = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Hike Description',
                            labelStyle: TextStyle(
                                color: Color(0xff545454),
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:lightColorScheme.primary),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightColorScheme.primary),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Card(
                      child: Container(
                        child: Column(
                          children: [
                            _imageFile == null
                                ? Placeholder() // Placeholder for image if no image is selected
                                : Image.file(
                              _imageFile!,
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                            ElevatedButton(
                              onPressed: _getImage,
                              child: Text('Upload Image'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text('Date and Time',
                            style:TextStyle(
                                color: Color(0xff545454),
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(date_time.toString()),
                          onTap: () async {
                            DateTime? pickedDateTime = await showDatePicker(
                              context: context,
                              initialDate: date_time,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDateTime != null) {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(date_time),
                              );
                              if (pickedTime != null) {
                                setState(() {
                                  date_time = DateTime(
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
                    SizedBox(height: 16.0),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: locationController,
                          onChanged: (value) {
                            setState(() {
                              location = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Hike Location',
                            labelStyle: TextStyle(
                                color: Color(0xff545454),
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:lightColorScheme.primary),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightColorScheme.primary),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child:Column(
                          children: [
                            TextField(
                              controller: start_pointController,
                              onChanged: (input){
                                _fetchSuggestions(input);
                              },
                              decoration: InputDecoration(
                                labelText: "Start Location",
                                labelStyle: TextStyle(
                                    color: Color(0xff545454),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color:lightColorScheme.primary),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: lightColorScheme.primary),
                                ),
                                suffixIcon: Icon(OctIcons.search),
                              ),
                            ),
                            // Display the selected location description (optional)
                            if (_suggestions.isNotEmpty)
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: _suggestions.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(_suggestions[index]['description']),
                                    onTap: () => _selectSuggestion(index),
                                  );
                                },
                              ),                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child:Column(
                          children: [
                            TextField(
                              controller: end_pointController,
                              onChanged: (input){
                                _fetchEndSuggestions(input);
                              },
                              decoration: InputDecoration(
                                labelText: "End Location",
                                labelStyle: TextStyle(
                                    color: Color(0xff545454),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color:lightColorScheme.primary),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: lightColorScheme.primary),
                                ),
                                suffixIcon: Icon(OctIcons.search),
                              ),
                            ),
                            // Display the selected location description (optional)
                            if (_EndSuggestions.isNotEmpty)
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: _EndSuggestions.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(_EndSuggestions[index]['description']),
                                    onTap: () => _selectEndSuggestion(index),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: ctzPriceController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              ctzPriceController.text = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Citizen Price (Ksh)',
                            labelStyle: TextStyle(
                                color: Color(0xff545454),
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:lightColorScheme.primary),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightColorScheme.primary),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: restPriceController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              restPriceController.text = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Resident Price (Ksh)',
                            labelStyle: TextStyle(
                                color: Color(0xff545454),
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:lightColorScheme.primary),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightColorScheme.primary),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: trstPriceController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              trstPriceController.text = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Tourist Price (USD)',
                            labelStyle: TextStyle(
                                color: Color(0xff545454),
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:lightColorScheme.primary),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightColorScheme.primary),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                    Card(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'What To Carry',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xff545454),
                              ),
                            ),
                            TextFormField(
                              controller: whatCarryController,
                              decoration: InputDecoration(
                                hintText: 'Equipment, Consumables, outfit etc.',

                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color:lightColorScheme.primary),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: lightColorScheme.primary),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  whatCarryController.text = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Additional activities',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: Colors.orange, // Color of the unchecked checkbox
                                ),
                                child: Checkbox(
                                  value: Village_Experience,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      Village_Experience = value!;
                                      print('Checkbox value: $Village_Experience');
                                    });
                                  },
                                  checkColor: Colors.orange,
                                  activeColor: Colors.transparent,
                                ),
                              ),
                              Text('Village Experience'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Checkbox(
                                value: Culture_Show,
                                onChanged: (bool? value) {
                                  setState(() {
                                    Culture_Show = value!;
                                  });
                                },
                                checkColor: Colors.orange, // Color of the check icon
                                activeColor: Colors.transparent, // Color of the check box when checked
                              ),
                              Text('Culture Show'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Checkbox(
                                value: Bird_Watching,
                                onChanged: (value) {
                                  setState(() {
                                    Bird_Watching = value!;
                                  });
                                },
                              ),
                              Text('Bird Watching'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Checkbox(
                                value: Swimming,
                                onChanged: (value) {
                                  setState(() {
                                    Swimming = value!;
                                  });
                                },
                              ),
                              Text('Swimming'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Checkbox(
                                value: Local_Cuisines,
                                onChanged: (value) {
                                  setState(() {
                                    Local_Cuisines = value!;
                                  });
                                },
                              ),
                              Text('Local Cuisines'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Checkbox(
                                value: Other,
                                onChanged: (value) {
                                  setState(() {
                                    Other = value!;
                                  });
                                },
                              ),
                              Text('Other'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: difficulty_level,
                          onChanged: (newValue) {
                            setState(() {
                              difficulty_level = newValue!;
                            });
                          },
                          items: ['1 Easy', '2 Moderate', '3 Hard', '4 Very Hard']
                              .map((serviceProvider) {
                            return DropdownMenuItem<String>(
                              value: serviceProvider,
                              child: Text(serviceProvider,
                                style: TextStyle(
                                    color: Color(0xff545454),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          }).toList(),
                          hint: Text('Difficulty Levels'),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: maxController,
                          keyboardType: TextInputType.number,
                          onChanged:(value){
                            setState(() {
                              maxController.text = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Maximum Group Size',
                            labelStyle: TextStyle(
                                color: Color(0xff545454),
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:lightColorScheme.primary),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightColorScheme.primary),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: minAgeController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              minAgeController.text = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Minimum Age',
                            labelStyle: TextStyle(
                                color: Color(0xff545454),
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:lightColorScheme.primary),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightColorScheme.primary),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),

                    GestureDetector(
                      onTap: _createEvent, // Call _createEvent method on tap
                      child: Container(
                        height: 50,
                        width: 150,
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        decoration: BoxDecoration(
                            color: lightColorScheme.primary,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.save,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              'Save',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  itemCount: hike.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 150,
                      width: double.infinity,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image(image: NetworkImage(hike[index].image ?? '')),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Ref#${hike[index].id}",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                      Text(hike[index].title ?? '',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                      const SizedBox(height: 1,),
                                      Text(hike[index].category ?? '',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                      const SizedBox(height: 1,),
                                      Text(hike[index].date_time ?? '',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                      SizedBox(height: 13,),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder:
                                          (context)=>UpdateHike(hikeId: hike[index].id.toString(),)
                                          ));
                                        }, // Call _createEvent method on tap
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                          decoration: BoxDecoration(
                                              color: lightColorScheme.primary,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.edit,
                                                size: 18,
                                                color: Colors.white,
                                              ),
                                            ],
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
          ],
        ),
      ),
    );
  }
}
