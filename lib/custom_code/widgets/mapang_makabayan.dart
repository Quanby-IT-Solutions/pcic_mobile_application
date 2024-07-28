// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'package:geolocator/geolocator.dart';
import 'dart:math' show cos, sqrt, asin, pi;

class MapangMakabayan extends StatefulWidget {
  final double? width;
  final double? height;
  final String? accessToken;

  const MapangMakabayan({Key? key, this.width, this.height, this.accessToken})
      : super(key: key);

  @override
  _MapangMakabayanState createState() => _MapangMakabayanState();
}

class _MapangMakabayanState extends State<MapangMakabayan> {
  ll.LatLng? currentLocation;
  bool locationLoaded = false;
  List<ll.LatLng> route = [];
  final MapController _mapController = MapController();
  StreamSubscription<Position>? _positionSubscription;
  final double _minDistanceFilter = 0.5; // 0.5 meters for higher precision
  ll.LatLng? _lastValidLocation;
  double _currentZoom = 20.0; // Increased zoom for more detail
  bool _isTracking = false;
  List<ll.LatLng> pinDrops = [];

  @override
  void initState() {
    super.initState();
    checkPermissions().then((hasPermission) {
      if (hasPermission) {
        getCurrentLocation();
      }
    });
  }

  Future<bool> checkPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied.');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied.');
      return false;
    }

    return true;
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );

      setState(() {
        currentLocation = ll.LatLng(position.latitude, position.longitude);
        _lastValidLocation = currentLocation;
        locationLoaded = true;
      });
      _mapController.move(currentLocation!, _currentZoom);
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void startTracking() {
    setState(() {
      _isTracking = true;
      route.clear();
      pinDrops.clear();
    });
    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0, // Get all updates
      ),
    ).listen((Position position) {
      _updateLocation(position);
    });
  }

  void stopTracking() {
    setState(() {
      _isTracking = false;
    });
    _positionSubscription?.cancel();
  }

  void _updateLocation(Position position) {
    final newLocation = ll.LatLng(position.latitude, position.longitude);

    if (_lastValidLocation != null && _isTracking) {
      final distance = calculateDistance(_lastValidLocation!, newLocation);

      if (distance >= _minDistanceFilter) {
        setState(() {
          route.add(newLocation);
          _lastValidLocation = newLocation;
          currentLocation = newLocation;
          _mapController.move(newLocation, _currentZoom);
        });
      }
    } else {
      setState(() {
        _lastValidLocation = newLocation;
        currentLocation = newLocation;
        _mapController.move(newLocation, _currentZoom);
      });
    }
  }

  void dropPin() {
    if (currentLocation != null) {
      setState(() {
        pinDrops.add(currentLocation!);
      });
    }
  }

  double calculateDistance(ll.LatLng start, ll.LatLng end) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((end.latitude - start.latitude) * p) / 2 +
        c(start.latitude * p) *
            c(end.latitude * p) *
            (1 - c((end.longitude - start.longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a)) * 1000; // 2 * R; R = 6371 km
  }

  double calculateArea() {
    if (route.length < 3) return 0;
    double area = 0;
    for (int i = 0; i < route.length; i++) {
      int j = (i + 1) % route.length;
      area += (route[i].longitude * route[j].latitude -
          route[j].longitude * route[i].latitude);
    }
    area = (area.abs() / 2) *
        111319.9 *
        111319.9; // Rough conversion to square meters
    return area;
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!locationLoaded) {
      return const Center(child: CircularProgressIndicator());
    }

    double area = calculateArea();

    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width,
      height: widget.height ?? MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: currentLocation!,
              initialZoom: _currentZoom,
              maxZoom: 23.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/quanbysolutions/cluhoxol502q801oi8od2cmvz/tiles/{z}/{x}/{y}?access_token={accessToken}',
                additionalOptions: {
                  'accessToken': widget.accessToken ??
                      'your_default_mapbox_access_token_here',
                },
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: route,
                    strokeWidth: 4.0,
                    color: Colors.blue,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: currentLocation!,
                    width: 20.0,
                    height: 20.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                  ...pinDrops.map(
                    (point) => Marker(
                      point: point,
                      width: 20.0,
                      height: 20.0,
                      child: Icon(Icons.location_pin, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              color: Colors.white.withOpacity(0.7),
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Points: ${route.length}\n'
                    'Current: ${currentLocation?.latitude.toStringAsFixed(6)}, ${currentLocation?.longitude.toStringAsFixed(6)}',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Area: ${area.toStringAsFixed(2)} sq meters',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _isTracking ? stopTracking : startTracking,
                        child: Text(_isTracking ? 'Stop' : 'Start'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _isTracking ? dropPin : null,
                        child: Text('Drop Pin'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
