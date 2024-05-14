import 'package:flutter/material.dart';

class BuildingImageList extends StatelessWidget {
  final String location;

  BuildingImageList({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    switch (location) {
      case "AECH":
        return Image.asset('assets/building_AECH.jpg');
      case "DMMME":
        return Image.asset('assets/building_DMMME.jpg');
      case "NIGS":
        return Image.asset('assets/building_NIGS.jpg');
      default:
        return const Center(child: Text("No Image available"));
    }
  }
}
