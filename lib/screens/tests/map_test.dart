import 'package:flutter/material.dart';
import 'package:hikemaniak_app/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceAutocomplete extends StatefulWidget {
  @override
  _PlaceAutocompleteState createState() => _PlaceAutocompleteState();
}

class _PlaceAutocompleteState extends State<PlaceAutocomplete> {
  TextEditingController _searchController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  List<Map<String, dynamic>> _suggestions = [];

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
            final double lat = location['lat'];
            final double lng = location['lng'];
            print('Latitude: $lat, Longitude: $lng');
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
    _searchController.text = _suggestions[index]['description'];
    setState(() {
      _suggestions.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Autocomplete'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search for a place',
            ),
            onChanged: (input) {
              _fetchSuggestions(input);
            },
          ),
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
            ),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
            ),
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
        ],
      ),
    );
  }
}
