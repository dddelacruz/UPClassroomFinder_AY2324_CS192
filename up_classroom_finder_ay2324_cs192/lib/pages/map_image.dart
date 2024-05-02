import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/floorplan_page.dart';

class MapIMG extends StatefulWidget {
  const MapIMG({super.key});

  @override
  State<MapIMG> createState() => _MapIMGState();
}

class _MapIMGState extends State<MapIMG> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(14.64860, 121.06855),
        initialZoom: 18,
        interactionOptions: InteractionOptions(
            flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example. app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(14.64866, 121.06866),
              width: 80,
              height: 80,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) => const FloorPlanPage(),
                  );
                },
                child: Icon(Icons.location_pin, size: 50),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
