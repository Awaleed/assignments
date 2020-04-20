import 'package:assignments/core/utils.dart';
import 'package:assignments/features/tasks/domain/entities/task_entity.dart';
import 'package:assignments/features/tasks/presentation/helpers.dart';
import 'package:assignments/features/tasks/presentation/widgets/task_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'table_calendar.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({Key key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
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
    final tasks = Helpers.store.tasks;
    Map<DateTime, List> events = {};

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

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    // print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    // print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    final loc = localeBase(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${loc.calendar.calendar}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.today),
            onPressed: () {
              setState(() {
                _calendarController.setSelectedDay(
                  DateTime.now().withoutTime(),
                  runCallback: true,
                  animate: true,
                );
              });
            },
          ),
          IconButton(
            icon: Icon(
                // _calendarController?.calendarFormat == CalendarFormat.twoWeeks
                // ? Icons.calendar_view_day
                //     : Icons.view_agenda,
                Icons.calendar_view_day),
            onPressed: () {
              setState(() {
                _calendarController.setCalendarFormat(
                  _calendarController.calendarFormat == CalendarFormat.twoWeeks
                      ? CalendarFormat.week
                      : CalendarFormat.twoWeeks,
                );
              });
            },
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTableCalendar(),
          const SizedBox(height: 8.0),
          Expanded(
            child: _selectedEvents.isNotEmpty
                ? _buildEventList()
                : Center(child: Text('${loc.calendar.empty_tasks_list}')),
          ),
        ],
      ),
      floatingActionButton: _selectedDay.isAfter(
              DateTime.now().withoutTime().subtract(Duration(seconds: 1)))
          ? FloatingActionButton.extended(
              onPressed: () async {
                await Helpers.onShowTaskDialog(
                  dueDate: _selectedDay,
                  fixedDate: true,
                );
                setState(() {
                  _events = _buildTasksEvents();
                  _selectedEvents = _events[_selectedDay] ?? [];
                });
              },
              label: Text('${loc.tasks.new_task}'),
              icon: Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      locale: locale(context).languageCode,
      initialCalendarFormat: CalendarFormat.week,
      formatAnimation: FormatAnimation.slide,
      availableGestures: AvailableGestures.horizontalSwipe,
      builders: CalendarBuilders(
        markersBuilder: (BuildContext context, DateTime date, List<dynamic> l1,
            List<dynamic> l2) {
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
                          color: (t as Task).course.color,
                        ),
                      ))
                  .toList(),
            )
          ];
        },
      ),
      availableCalendarFormats: {
        CalendarFormat.week: 'week',
        CalendarFormat.twoWeeks: 'twoWeeks',
      },
      calendarController: _calendarController,
      events: _events,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      calendarStyle: CalendarStyle(
        selectedColor: Theme.of(context).primaryColor,
        todayColor: Theme.of(context).primaryColor.withOpacity(.5),
        markersColor: Theme.of(context).accentColor,
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        centerHeaderTitle: true,
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventList() {
    final events = _selectedEvents.map((e) => e as Task);

    return ListView(
      children: events.map((task) {
        return TaskTile(
          task,
          onTap: () => Helpers.onShowTaskDetails(parent: null, task: task),
        );
      }).toList(),
    );
  }
}

extension on DateTime {
  DateTime withoutTime() {
    return DateTime(this.year, this.month, this.day);
  }
}
