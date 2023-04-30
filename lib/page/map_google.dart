import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../bloc/application_bloc.dart';
import '../network/api_service.dart';

class MapGooglePage extends StatefulWidget {
  final String title;
  final bool isMobile;
  const MapGooglePage({Key? key, required this.title, required this.isMobile}) : super(key: key);

  @override
  State<MapGooglePage> createState() => _MapGooglePageState();
}

class _MapGooglePageState extends State<MapGooglePage> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {}; // Create a Set to store the polyLines

  final LatLng _center = const LatLng(22.635741723478922, 120.27541918038403);
  final MarkerId _attractionMarkerId = const MarkerId('zoo');

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _addMarker();
    _loadDirections();
  }

  void _addMarker() {
    final marker = Marker(
      markerId: const MarkerId('zoo'),
      position: _center,
      infoWindow: const InfoWindow(
        title: '高雄市立壽山動物園',
        snippet: '80444高雄市鼓山區萬壽路350號',
      ),
    );

    setState(() {
      _markers.add(marker);
    });

    // Show the InfoWindow after a short delay
    Future.delayed(const Duration(milliseconds: 100)).then((_) {
      mapController.showMarkerInfoWindow(_attractionMarkerId);
    });
  }

  void _loadDirections() async {
    LatLng start = _center; // Starting location
    const end = LatLng(22.99201966036417, 120.20244809791338); // Ending location (replace with desired coordinates)

    final route = await getDirections(start, end);

    final polyline = Polyline(
      polylineId: const PolylineId("route"),
      points: route,
      color: Colors.blue,
      width: 5,
    );

    setState(() {
      _markers.add(Marker(markerId: const MarkerId("start"), position: start)); // Add a marker for the starting location
      _markers.add(const Marker(markerId: MarkerId("end"), position: end)); // Add a marker for the ending location
      _polyLines.add(polyline); // Add the polyline to the map
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBloc = Provider.of<ApplicationBloc>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            "地圖",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
          child: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  const SizedBox(height: 32),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: _center,
                          zoom: 11.0,
                        ),
                        markers: _markers,
                        polylines: _polyLines,
                      )
                  )
                ]
            ),
          ),
        )
    );
  }
}