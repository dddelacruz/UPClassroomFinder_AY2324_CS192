import 'package:flutter/material.dart';

class FloorPlanImagePageList extends StatelessWidget {
  final String buildingName;
  final String floorNumber;

  final List<String> floorplanImagePathList = [
    'assets/floorplan_AECH_2ND.jpg',
    'assets/floorplan_DMME_LGF.jpg',
    'assets/floorplan_DMMME_2F.jpg',
    'assets/floorplan_DMMME_3F.jpg',
    'assets/floorplan_DMMME_UGF.jpg',
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
      case 'DMMMELGF':
        return Center(child: Image.asset(floorplanImagePathList[1]));
      case 'DMMME2F':
        return Center(child: Image.asset(floorplanImagePathList[2]));
      case 'DMMME3F':
        return Center(child: Image.asset(floorplanImagePathList[3]));
      case 'DMMMEUGF':
        return Center(child: Image.asset(floorplanImagePathList[4]));
      case 'EEEI1ST':
        return Center(child: Image.asset(floorplanImagePathList[5]));
      case 'EEEI2ND':
        return Center(child: Image.asset(floorplanImagePathList[6]));
      case 'NIGS2ND':
        return Center(child: Image.asset(floorplanImagePathList[7]));
      case 'NIGSBASEMENT':
        return Center(child: Image.asset(floorplanImagePathList[8]));
      case 'NIGSGROUND':
        return Center(child: Image.asset(floorplanImagePathList[9]));
      // INSERT OTHER FLOORPLANS
      default:
        return Center(child: Text("No floorplan available"));
    }
  }
}
