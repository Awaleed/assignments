import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../components/task_tile.dart';
import '../../models/task_model.dart';
import '../../routes/config_routes.dart';
import '../task/task_dialog.dart';
import 'table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  static const routeName = '/calendar';

  const CalendarScreen({Key key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> with TickerProviderStateMixin {
  List _selectedEvents;
  CalendarController _calendarController;
  DateTime _selectedDay;
  Map<DateTime, List> _events;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now().withoutTime();
    _events = _buildTasksEvents();

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  Map<DateTime, List> _buildTasksEvents() {
    final tasks = [];
    final Map<DateTime, List> events = {};

    DateTime previousDate;

    if (tasks != null && tasks.isNotEmpty) {
      previousDate = tasks[0].dueDate.withoutTime();
      events[previousDate] = [];
    }

    for (final task in tasks) {
      final currentDate = task.dueDate.withoutTime();

      if (currentDate.isAfter(previousDate)) {
        previousDate = currentDate;
        events[currentDate] = [];
        events[currentDate].add(task);
      } else {
        events[currentDate].add(task);
      }
    }
    return events;
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedDay = day.withoutTime();
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    // print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    // print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.calendar),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () {
              setState(() {
                _calendarController.setSelectedDay(
                  DateTime.now().withoutTime(),
                  runCallback: true,
                );
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_view_day),
            onPressed: () {
              setState(() {
                _calendarController.calendarFormat = _calendarController.calendarFormat == CalendarFormat.twoWeeks ? CalendarFormat.week : CalendarFormat.twoWeeks;
              });
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          _buildTableCalendar(),
          const SizedBox(height: 8.0),
          Expanded(
            child: _selectedEvents.isNotEmpty ? _buildEventList() : Center(child: Text(S.current.empty_tasks_list)),
          ),
        ],
      ),
      floatingActionButton: _selectedDay.isAfter(DateTime.now().withoutTime().subtract(const Duration(seconds: 1)))
          ? FloatingActionButton.extended(
              onPressed: () {
                AppRouter.sailor.navigate(
                  TaskDialog.routeName,
                  params: {'task': TaskModel(dueDate: _selectedDay.addTime())},
                );
              },
              label: Text(S.current.new_task),
              icon: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      locale: 'locale(context).languageCode',
      initialCalendarFormat: CalendarFormat.week,
      availableGestures: AvailableGestures.horizontalSwipe,
      builders: CalendarBuilders(
        markersBuilder: (BuildContext context, DateTime date, List<dynamic> l1, List<dynamic> l2) {
          return [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: l1
                  .take(4)
                  .map((t) => Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(horizontal: 0.3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (t as TaskModel).course.color,
                        ),
                      ))
                  .toList(),
            )
          ];
        },
      ),
      availableCalendarFormats: const {
        CalendarFormat.week: 'week',
        CalendarFormat.twoWeeks: 'twoWeeks',
      },
      calendarController: _calendarController,
      events: _events,
      calendarStyle: CalendarStyle(
        selectedColor: Theme.of(context).primaryColor,
        todayColor: Theme.of(context).primaryColor.withOpacity(.5),
        markersColor: Theme.of(context).accentColor,
        outsideDaysVisible: false,
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        centerHeaderTitle: true,
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventList() {
    final events = _selectedEvents.map((e) => e as TaskModel);

    return ListView(
      children: events.map((task) {
        return TaskTile(task);
      }).toList(),
    );
  }
}

extension on DateTime {
  DateTime withoutTime() => DateTime(year, month, day);

  DateTime addTime() => DateTime(year, month, day, DateTime.now().hour, DateTime.now().minute);
}
