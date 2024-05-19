import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class HikeMapPoints extends StatefulWidget {
  const HikeMapPoints({Key? key,}) : super(key: key);

  @override
  State<HikeMapPoints> createState() => _HikeMapPointsState();
}

class _HikeMapPointsState extends State<HikeMapPoints> {
  Location _locationController = Location();

  final Completer<GoogleMapController> _mapController =
  Completer<GoogleMapController>();

  List<LatLng> _allPoints = [];
  late LatLng _pStartPoint = LatLng(-0.023559,37.906193);

  @override
  void initState() {
    super.initState();
    _fetchHikeMaps();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pStartPoint == null
          ? const Center(
        child: Text("Loading - If You Have Not Enabled Location Please do..."),
      )
          : GoogleMap(
        onMapCreated: ((GoogleMapController controller) =>
            _mapController.complete(controller)),
        initialCameraPosition: CameraPosition(
          target: _pStartPoint,
          zoom: 6,
        ),
        markers: {
          if (_allPoints != null)
            for (final point in _allPoints)
              Marker(
                markerId: MarkerId(point.toString()), // Consider using a unique identifier
                icon: BitmapDescriptor.defaultMarker,
                position: point,
              ),
        },
      ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 10,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> _fetchHikeMaps() async {
    final response = await http.get(Uri.parse('$BASE_URL/hike/maps_cordinates'));
    try{
      if(response.statusCode == 200){

        Map<String,dynamic> resdata = json.decode(response.body);
        List<dynamic> map_points = resdata['data'];

        if(map_points.isNotEmpty){
          List<LatLng> allPoints = [];
          for (var point in map_points) {
            double lat = double.parse(point['start_lat']);
            double lng = double.parse(point['start_lng']);
            allPoints.add(LatLng(lat, lng));
          }

          // Update state variable with the list of points
          setState(() {
            _allPoints = allPoints; // Replace _allPoints with your list variable name
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please wait as the map loads'))
            );
          });
        }

      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error'))
        );
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something is wrong'))
      );
    }
  }

}
