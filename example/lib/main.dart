import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:time_slot/controller/day_part_controller.dart';
import 'package:time_slot/model/time_slot_Interval.dart';
import 'package:time_slot/time_slot_from_interval.dart';
import 'package:time_slot/time_slot_from_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting('ar', '').then((value) => null);
  initializeDateFormatting('en', '').then((value) => null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Time Slot Package'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectTime = DateTime.now();

  DayPartController dayPartController = DayPartController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: const Text("DayPart of Time"),
                subtitle: Text(
                  DateFormat.jm().format(
                    DateTime(2023, 1, 1, 10, 30),
                  ),
                ),
                trailing: Text(dayPartController.getDayPartName(
                  dayPart: dayPartController.getDayPartOfTime(
                    time: DateTime(2023, 1, 1, 10, 30),
                  )!,
                )),
              ),
              ListTile(
                title: const Text("DayPart of Time"),
                subtitle: Text(
                  DateFormat.jm().format(
                    DateTime(2023, 1, 1, 13, 30),
                  ),
                ),
                trailing: Text(
                  dayPartController.getDayPartName(
                    dayPart: dayPartController.getDayPartOfTime(
                      time: DateTime(2023, 1, 1, 13, 30),
                    )!,
                  ),
                ),
              ),
              ListTile(
                title: const Text("DayPart of Time"),
                subtitle: Text(
                  DateFormat.jm().format(
                    DateTime(2023, 1, 1, 18, 30),
                  ),
                ),
                trailing: Text(
                  dayPartController.getDayPartName(
                    dayPart: dayPartController.getDayPartOfTime(
                      time: DateTime(2023, 1, 1, 18, 30),
                    )!,
                  ),
                ),
              ),
              ListTile(
                title: const Text("DayPart of Time"),
                subtitle: Text(
                  DateFormat.jm().format(
                    DateTime(2023, 1, 1, 23, 30),
                  ),
                ),
                trailing: Text(
                  dayPartController.getDayPartName(
                    dayPart: dayPartController.getDayPartOfTime(
                      time: DateTime(2023, 1, 1, 23, 30),
                    )!,
                  ),
                ),
              ),
              const Divider(),
              const Text(
                  "times slot from interval (10:00 AM to 10:00 PM) every hour"),
              const Divider(),
              const Text("-------------- EN --------------"),
              TimesSlotGridViewFromInterval(
                locale: "en",
                initTime: selectTime,
                crossAxisCount: 4,
                timeSlotInterval: const TimeSlotInterval(
                  start: TimeOfDay(hour: 10, minute: 00),
                  end: TimeOfDay(hour: 22, minute: 0),
                  interval: Duration(hours: 1, minutes: 0),
                ),
                onChange: (value) {
                  setState(() {
                    selectTime = value;
                  });
                },
              ),
              const Text("-------------- AR --------------"),
              TimesSlotGridViewFromInterval(
                locale: "ar",
                initTime: selectTime,
                crossAxisCount: 4,
                timeSlotInterval: const TimeSlotInterval(
                  start: TimeOfDay(hour: 10, minute: 00),
                  end: TimeOfDay(hour: 22, minute: 0),
                  interval: Duration(hours: 1, minutes: 0),
                ),
                onChange: (value) {
                  setState(() {
                    selectTime = value;
                  });
                },
              ),
              const Divider(),
              const Text("times slot from list"),
              const Divider(),
              const Text("-------------- EN --------------"),
              TimesSlotGridViewFromList(
                locale: "en",
                initTime: selectTime,
                crossAxisCount: 4,
                listDates: [
                  DateTime(2023, 1, 1, 10, 30),
                  DateTime(2023, 1, 1, 11, 30),
                  DateTime(2023, 1, 1, 12, 30),
                  DateTime(2023, 1, 1, 13, 30),
                  DateTime(2023, 1, 1, 14, 30),
                  DateTime(2023, 1, 1, 15, 30)
                ],
                onChange: (value) {
                  setState(() {
                    selectTime = value;
                  });
                },
              ),
              const Text("-------------- AR --------------"),
              TimesSlotGridViewFromList(
                locale: "ar",
                initTime: selectTime,
                crossAxisCount: 4,
                listDates: [
                  DateTime(2023, 1, 1, 10, 30),
                  DateTime(2023, 1, 1, 11, 30),
                  DateTime(2023, 1, 1, 12, 30),
                  DateTime(2023, 1, 1, 13, 30),
                  DateTime(2023, 1, 1, 14, 30),
                  DateTime(2023, 1, 1, 15, 30)
                ],
                onChange: (value) {
                  setState(() {
                    selectTime = value;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
