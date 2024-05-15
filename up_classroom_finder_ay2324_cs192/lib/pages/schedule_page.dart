import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/floorplan_page.dart';
import 'package:up_classroom_finder_ay2324_cs192/pages/context.dart';


class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  SchedulePageState createState() => SchedulePageState();
}

class SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    var schedState = context.watch<MyAppState>();
    schedState.loadSched();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff264B30),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Row(
          children: [
            Icon(Icons.calendar_today, color: Color(0xff800000), size: 35,), 
            SizedBox(width: 5),
            Text('Schedule', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)),
          ],
        ),
        titleSpacing: 10
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: schedState.schedules.length,
                itemBuilder: (context, index) {
                  // Builds the list of saved schedules in context.dart
                  final schedule = schedState.schedules[index];
                  return buildClassRow(schedule, () {
                    schedState.removeSchedAtIndex(index);
                  }, schedState, index);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddDialog(schedState);
        },
        child: const Icon(Icons.add_circle_outline),
      ),
    );
  }

  // Builds the listtile/row of the added schedule 
  Widget buildClassRow(Map<String, String> schedule, Function() onDelete, MyAppState appState, int index) {
  return GestureDetector(
    onTap: () {
      showScheduleOptions(context, onDelete, appState, index);
    },
    child: ListTile(
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
                      // To be changed to classroomdetail
                      builder: (BuildContext context) => FloorPlanPage('AECH'),
                    );
                  },
                  child: Text(
                    schedule["location"]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Color(0xff800000)),
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
    ),
  );
}

// Bottomsheet shown when the listtile is pressed, showing the edit and delete options
void showScheduleOptions(BuildContext context, Function() onDelete, MyAppState appState, int index) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Schedule'),
              onTap: () {
                // Edit button is selected, redirect to editSched()
                Navigator.pop(context);
                editSched(context, appState, index);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete Schedule'),
              onTap: onDelete,
            ),
          ],
        ),
      );
    },
  );
}

// Edit dialog shown when edit button is pressed
void editSched(BuildContext context, MyAppState appState, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Schedule"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Time'),
                controller: TextEditingController(text: appState.schedules[index]["time"]),
                onChanged: (value) {
                  appState.schedules[index]["time"] = value; // Update sched in context.dart
                  appState.saveSched();                      // Save new sched, important: notifylisteners
                }
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Day'),
                controller: TextEditingController(text: appState.schedules[index]["day"]),
                onChanged: (value) {
                  appState.schedules[index]["day"] = value;  // Update sched in context.dart
                  appState.saveSched();                      // Save new sched, important: notifylisteners
                }
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Subject'),
                controller: TextEditingController(text: appState.schedules[index]["subject"]),
                onChanged: (value) {
                  appState.schedules[index]["subject"] = value;  // Update sched in context.dart
                  appState.saveSched();                          // Save new sched, important: notifylisteners
                }
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Location'),
                controller: TextEditingController(text: appState.schedules[index]["location"]),
                onChanged: (value) {
                  appState.schedules[index]["location"] = value;  // Update sched in context.dart
                  appState.saveSched();                           // Save new sched, important: notifylisteners
                }
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  // Add dialog shown when add button is pressed
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
                  schedState.addSched(_newSchedule);       // Save the new sched in schedules in context.dart
                });
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
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
