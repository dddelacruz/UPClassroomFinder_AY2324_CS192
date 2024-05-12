import 'package:flutter/material.dart';

class FloorPlanImagePageList extends StatelessWidget {
  final String buildingName;
  final String floorNumber;

  final List<String> floorplanImagePathList = [
    'assets/floorplan_AECH_2ND.jpg',
    'assets/floorplan_DMMME_1ST.jpg',
    'assets/floorplan_EEEI_1ST.jpg',
    'assets/floorplan_EEEI_2ND.jpg',
    'assets/floorplan_NIGS_2ND.jpg',
    'assets/floorplan_NIGS_BASEMENT.jpg',
    'assets/floorplan_NIGS_GROUND.jpg',
  ];

  FloorPlanImagePageList(
      {super.key, required this.buildingName, required this.floorNumber});

  @override
  Widget build(BuildContext context) {
    switch (buildingName + floorNumber) {
      case 'AECH2ND':
        return Center(child: Image.asset(floorplanImagePathList[0]));
      case 'DMMME1ST':
        return Center(child: Image.asset(floorplanImagePathList[1]));
      case 'EEEI1ST':
        return Center(child: Image.asset(floorplanImagePathList[2]));
      case 'EEEI2ND':
        return Center(child: Image.asset(floorplanImagePathList[3]));
      case 'NIGS2ND':
        return Center(child: Image.asset(floorplanImagePathList[4]));
      case 'NIGSBASEMENT':
        return Center(child: Image.asset(floorplanImagePathList[5]));
      case 'NIGSGROUND':
        return Center(child: Image.asset(floorplanImagePathList[6]));
      // INSERT OTHER FLOORPLANS
      default:
        return const Center(child: Text("No floorplan available"));
    }
  }
}
