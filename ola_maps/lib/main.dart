import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


void main() {
  runApp(MapScreen());
}


class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  LatLng _initialPosition =
      LatLng(20.5937, 78.9629); // Default location (India)

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ola Maps Integration'),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _initialPosition,
            zoom: 10,
          ),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    fetchOlaMapData('desired_location').then((data) {
      // Process and use the fetched data to update the map
      // For example, you could add markers or update camera position
    });
  }
}


Future<Map<String, dynamic>> fetchOlaMapData(String location) async {
  final response = await http.get(
    Uri.parse(
        'https://api.krutrim.com/maps?location=$location&key=ti3WuD21vCHiyz3wXIMhJYFnXKgdWsxVbWR3Yd4k'),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load map data');
  }
}
