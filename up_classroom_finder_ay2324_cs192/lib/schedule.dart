import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'floorplan.dart';
import 'notes.dart';


class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key});

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    var schedState = context.watch<MyAppState>();
    schedState.loadSched();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Schedule',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xff264B30),
        leading: const Padding(
          padding: EdgeInsets.only(left: 10.0),
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
              child: ListView.builder(
                itemCount: schedState.schedules.length,
                itemBuilder: (context, index) {
                  final schedule = schedState.schedules[index];
                  return buildClassRow(schedule, () {
                    schedState.removeSchedAtIndex(index);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Back"),
                  ),
                  Expanded(child: Container()),
                  TextButton(
                    onPressed: () {
                      showAddDialog(schedState);
                    },
                    child: Text("Add"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildClassRow(Map<String, String> schedule, Function() onDelete) {
  return ListTile(
    title: Table(
      children: [
        TableRow(children: <Widget>[
          TableCell(
            child: Container(
              height: 35,
              alignment: Alignment.center,
              child: Text(schedule["time"]!, textAlign: TextAlign.center),
            ),
          ),
          TableCell(
            child: Container(
              height: 35,
              alignment: Alignment.center,
              child: Text(schedule["day"]!, textAlign: TextAlign.center),
            ),
          ),
          TableCell(
            child: Container(
              height: 35,
              alignment: Alignment.center,
              child: Text(schedule["subject"]!, textAlign: TextAlign.center),
            ),
          ),
          TableCell(
            child: Container(
              height: 35,
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) => const FloorPlanPage(),
                  );
                },
                child: Text(
                  schedule["location"]!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xff800000)),
                ),
              ),
            ),
          ),
        ]),
      ],
    ),
    trailing: IconButton(
      icon: Icon(Icons.delete),
      onPressed: onDelete,
    ),
  );
}


  void showAddDialog(MyAppState schedState) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Schedule"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Time'),
                onChanged: (value) => _newSchedule["time"] = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Day'),
                onChanged: (value) => _newSchedule["day"] = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Subject'),
                onChanged: (value) => _newSchedule["subject"] = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Location'),
                onChanged: (value) => _newSchedule["location"] = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  schedState.addSched(_newSchedule);
                });
                Navigator.of(context).pop();
              },
              child: const Text("Add"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  final Map<String, String> _newSchedule = {"time": "", "day": "", "subject": "", "location": ""};
}
