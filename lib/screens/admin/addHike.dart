// Set language version to 2.12
// ignore_for_file: prefer_const_constructors
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:hikemaniak_app/constants.dart';
import 'package:hikemaniak_app/theme.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
//
import '../../model/hike.dart';

class AddHike extends StatefulWidget {
  const AddHike({Key? key}) : super(key: key);

  @override
  State<AddHike> createState() => _AddHikeState();
}

class _AddHikeState extends State<AddHike> {
  bool _locationPermissionGranted = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
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
  TextEditingController start_pointController = TextEditingController(text: "Nairobi");
  TextEditingController ctzPriceController = TextEditingController();
  TextEditingController restPriceController = TextEditingController();
  TextEditingController trstPriceController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController minAgeController = TextEditingController();


  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.request();
    setState(() {
      _locationPermissionGranted = status == PermissionStatus.granted;
    });
  }

  String difficulty = 'Forest';
  String difficulty_level = '1 Easy';
  String title = '';
  String desc = '';
  String image = '';
  DateTime date_time = DateTime.now();
  String location = '';
  String start_point = '';
  String amount = '';

  bool addActivities = false;


  Future<void> _createEvent() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('$BASE_URL/hike/store');

    // Create a multipart request
    var request = http.MultipartRequest('POST', url);

    // Add text fields to the request
    request.fields['difficulty'] = difficulty;
    request.fields['title'] = title;
    request.fields['desc'] = desc;
    request.fields['date_time'] = date_time.toIso8601String();
    request.fields['location'] = location;
    request.fields['start_point'] = start_point;
    request.fields['ctnAmount'] = ctzPriceController.text;
    request.fields['rstAmount'] = restPriceController.text;
    request.fields['trstAmount'] = trstPriceController.text;
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
            content: Text("Oops Failed to save hike $response.statusCode"),
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
                          value: difficulty,
                          onChanged: (newValue) {
                            setState(() {
                              difficulty = newValue!;
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
                    // Container(
                    //   height: 200.0,
                    //   child: GoogleMap(
                    //     onMapCreated: (GoogleMapController controller) {
                    //       setState(() {
                    //         mapController = controller;
                    //       });
                    //     },
                    //     initialCameraPosition: CameraPosition(
                    //       target: _selectedLocation,
                    //       zoom: 13.0,
                    //     ),
                    //     markers: Set<Marker>.of([
                    //       Marker(
                    //         markerId: MarkerId('selectedLocation'),
                    //         position: _selectedLocation,
                    //       ),
                    //     ]),
                    //     onTap: (LatLng latLng) {
                    //       setState(() {
                    //         _selectedLocation = latLng;
                    //       });
                    //     },
                    //   ),
                    // ),
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
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () async {
                                    Prediction? prediction = await PlacesAutocomplete.show(
                                      context: context,
                                      apiKey: PLACES_API,
                                      mode: Mode.overlay, // Change to fullscreen if preferred
                                    );

                                    if (prediction != null) {
                                      setState(() {
                                        start_pointController.text = prediction.description!;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                            // Display the selected location description (optional)
                            Text(start_pointController.text),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: start_pointController,
                          onChanged: (value) {
                            setState(() {
                              start_point = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'End Point',
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
                              decoration: InputDecoration(
                                hintText: 'Equipment, Consumables, outfit etc.',

                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color:lightColorScheme.primary),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: lightColorScheme.primary),
                                ),
                              ),
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
                                  value: false,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      addActivities = value ?? false;
                                      print('Checkbox value: $addActivities');
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
                                value: false,
                                onChanged: (bool? value) {},
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
                                value: false,
                                onChanged: (value) {},
                              ),
                              Text('Bird Watching'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (value) {},
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
                                value: false,
                                onChanged: (value) {},
                              ),
                              Text('Local Cuisines'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (value) {},
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
                          controller: titleController,
                          keyboardType: TextInputType.number,
                          onChanged:(value){
                            setState(() {
                              title = value;
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
                          controller: descController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              desc = value;
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
                                      SizedBox(height: 13,),
                                      GestureDetector(
                                        onTap: _createEvent, // Call _createEvent method on tap
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
