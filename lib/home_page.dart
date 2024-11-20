import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController mapController;

  final LatLng _initialPosition =
      const LatLng(37.7749, -122.4194); // San Francisco

  final Map<MarkerId, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _addMarker(_initialPosition, "Initial Marker");
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _addMarker(LatLng position, String markerId) {
    final marker = Marker(
      markerId: MarkerId(markerId),
      position: position,
      infoWindow: InfoWindow(
        title: markerId,
        snippet:
            "Latitude: ${position.latitude}, Longitude: ${position.longitude}",
      ),
    );
    setState(() {
      _markers[MarkerId(markerId)] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Maps on iOS"),
        backgroundColor: Colors.blueGrey,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 12.0,
        ),
        markers: _markers.values.toSet(),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          const double offset = 0.01;
          final LatLng randomPosition = LatLng(
            _initialPosition.latitude + offset,
            _initialPosition.longitude - offset,
          );
          _addMarker(randomPosition, "Marker ${_markers.length + 1}");
        },
        child: const Icon(Icons.add_location),
      ),
    );
  }
}
