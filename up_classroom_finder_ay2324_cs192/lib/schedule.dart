import 'package:flutter/material.dart';
import 'floorplan.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Color(0xff264B30),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Icon(
            Icons.calendar_today,
            color: Color(0xff800000),
            size: 35,
          ),
        ),
        titleSpacing: 10,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10.0),
                child: ListView(
                  children: [
                    ListTile(
                      title: Text("MONDAY",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    ),
                    ListTile(
                      title: Table(
                        children: [
                          TableRow(children: <Widget>[
                            TableCell(
                                child: Container(
                                    child: Center(
                                        child: Text(
                                      "7:00-9:00",
                                      textAlign: TextAlign.center,
                                    )),
                                    height: 35)),
                            TableCell(
                                child: Container(
                                    child: Center(
                                        child: Text(
                                      "CS191",
                                      textAlign: TextAlign.center,
                                    )),
                                    height: 35)),
                            TableCell(
                                child: Container(
                                    child: Center(
                                        child: TextButton(
                                      child: Text("AECH",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xff800000))),
                                      onPressed: () {
                                        showModalBottomSheet<void>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              const FloorPlanPage(),
                                        );
                                      },
                                    )),
                                    height: 35)),
                          ]),
                          TableRow(children: <Widget>[
                            TableCell(
                                child: Container(
                                    child: Center(
                                        child: Text(
                                      "10:30-11:30",
                                      textAlign: TextAlign.center,
                                    )),
                                    height: 35)),
                            TableCell(
                                child: Container(
                                    child: Center(
                                        child: Text(
                                      "CWTS",
                                      textAlign: TextAlign.center,
                                    )),
                                    height: 35)),
                            TableCell(
                                child: Container(
                                    child: Center(
                                        child: TextButton(
                                      child: Text("Palma Hall",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xff800000))),
                                      onPressed: () {},
                                    )),
                                    height: 35)),
                          ]),
                          TableRow(children: <Widget>[
                            TableCell(
                                child: Container(
                                    child: Center(
                                        child: Text(
                                      "16:00-17:00",
                                      textAlign: TextAlign.center,
                                    )),
                                    height: 35)),
                            TableCell(
                                child: Container(
                                    child: Center(
                                        child: Text(
                                      "Nihonggo",
                                      textAlign: TextAlign.center,
                                    )),
                                    height: 35)),
                            TableCell(
                                child: Container(
                                    child: Center(
                                        child: TextButton(
                                      child: Text("Melchor Hall",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xff800000))),
                                      onPressed: () {},
                                    )),
                                    height: 35)),
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                TextButton(
                  child: Text("Back"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Container(),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("Edit"),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
