import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../bloc/application_bloc.dart';

class MapGooglePage extends StatefulWidget {
  final String title;
  final bool isMobile;
  const MapGooglePage({Key? key, required this.title, required this.isMobile}) : super(key: key);

  @override
  State<MapGooglePage> createState() => _MapGooglePageState();
}

class _MapGooglePageState extends State<MapGooglePage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final appBloc = Provider.of<ApplicationBloc>(context);

    return Padding(
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
              )
            )
          ]
        ),
      ),
    );
  }
}