import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HospitalLocator extends StatefulWidget {
  @override
  _HospitalLocatorState createState() => _HospitalLocatorState();
}

class _HospitalLocatorState extends State<HospitalLocator> {
  GoogleMapController? _controller;
  LatLng? _currentPosition;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _controller!.animateCamera(CameraUpdate.zoomTo(14));
  }

  void _onCameraIdle() async {
    final bounds = await _controller!.getVisibleRegion();
    final center = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );
    setState(() {
      _currentPosition = center;
    });
  }

  _getNearbyHospitals() async {
    if (_currentPosition == null) return;

    final apiKey = 'AIzaSyB8kQOsky9x63umSWKObCJuD5bvqgTg9UU';
    final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
        '?location=${_currentPosition!.latitude},${_currentPosition!.longitude}'
        '&radius=1000&type=hospital&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];

      setState(() {
        _markers.clear();
        for (var result in results) {
          final lat = result['geometry']['location']['lat'];
          final lng = result['geometry']['location']['lng'];
          final name = result['name'];
          print(name);
          _markers.add(
            Marker(
              markerId: MarkerId(result['place_id']),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(
                title: name,
              ),
            ),
          );
        }
      });
    } else {
      throw Exception('Failed to load nearby hospitals');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital Locator'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(28.459497, 77.026634), // Default to Gurgaon
              zoom: 14,
            ),
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            onCameraIdle: _onCameraIdle,
            markers: _markers,
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: _getNearbyHospitals,
              child: Icon(Icons.local_hospital_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
