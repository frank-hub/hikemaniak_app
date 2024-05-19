import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';

import '../constants.dart';

class MapPage extends StatefulWidget {
  final String start_lat;
  final String start_lng;
  final String end_lat;
  final String end_lng;
  const MapPage({Key? key, required this.start_lat, required this.start_lng, required this.end_lat, required this.end_lng}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location _locationController = Location();

  final Completer<GoogleMapController> _mapController =
  Completer<GoogleMapController>();
  late double start_latcod;
  late double start_lng;
  late double end_lat;
  late double end_lng;

  late LatLng _pStartPoint;
  late LatLng _pEndPoint;
  LatLng? _currentP;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    start_latcod = double.parse(widget.start_lat);
    start_lng = double.parse(widget.start_lng);
    end_lat = double.parse(widget.end_lat);
    end_lng = double.parse(widget.end_lng);

    _pStartPoint = LatLng(start_latcod, start_lng);
    _pEndPoint = LatLng(end_lat, end_lng);

    print(_pStartPoint);
    print(_pEndPoint);
    // getLocationUpdates().then((_) {
    //   getPolylinePoints().then((coordinates) {
    //     generatePolyLineFromPoints(coordinates);
    //   });
    // });
    getPolylinePoints().then((coordinates) {
          generatePolyLineFromPoints(coordinates);
        });
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
          zoom: 13,
        ),
        markers: {
          // Marker(
          //   markerId: MarkerId("_currentLocation"),
          //   icon: BitmapDescriptor.defaultMarker,
          //   position: _currentP!,
          // ),
          Marker(
              markerId: MarkerId("Start Point"),
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(
                title: 'We Start Here'
              ),
              position: _pStartPoint),
          Marker(
              markerId: MarkerId("End Point"),
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(
                title: 'We End Here'
              ),
              position: _pEndPoint)
        },
        polylines: Set<Polyline>.of(polylines.values),
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

  // Future<void> getLocationUpdates() async {
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;
  //
  //   _serviceEnabled = await _locationController.serviceEnabled();
  //   if (_serviceEnabled) {
  //     _serviceEnabled = await _locationController.requestService();
  //   } else {
  //     return;
  //   }
  //
  //   _permissionGranted = await _locationController.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await _locationController.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //
  //   _locationController.onLocationChanged
  //       .listen((LocationData currentLocation) {
  //     if (currentLocation.latitude != null &&
  //         currentLocation.longitude != null) {
  //       setState(() {
  //         _currentP =
  //             LatLng(currentLocation.latitude!, currentLocation.longitude!);
  //         _cameraToPosition(_currentP!);
  //       });
  //     }
  //   });
  // }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY,
      PointLatLng(_pStartPoint.latitude, _pStartPoint.longitude),
      PointLatLng(_pEndPoint.latitude, _pEndPoint.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 8);
    setState(() {
      polylines[id] = polyline;
    });
  }
}
