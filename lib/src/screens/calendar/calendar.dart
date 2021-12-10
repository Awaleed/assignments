<<<<<<< Updated upstream
import 'package:assignments/src/components/date_tile.dart';
import 'package:assignments/src/components/tasks_list_view.dart';
import 'package:assignments/src/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:assignments/src/helpers/helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
=======
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
>>>>>>> Stashed changes

import '../../../generated/l10n.dart';
import '../../components/task_tile.dart';
import '../../models/task_model.dart';
import '../../routes/config_routes.dart';
import '../task/task_dialog.dart';
<<<<<<< Updated upstream
import 'package:table_calendar/table_calendar.dart';
=======
import 'table_calendar.dart';
>>>>>>> Stashed changes

class CalendarScreen extends StatefulWidget {
  static const routeName = '/calendar';

<<<<<<< Updated upstream
  const CalendarScreen({Key? key}) : super(key: key);
=======
  const CalendarScreen({Key key}) : super(key: key);
>>>>>>> Stashed changes

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> with TickerProviderStateMixin {
<<<<<<< Updated upstream
  // late List _selectedEvents;
  CalendarFormat calendarFormat = CalendarFormat.twoWeeks;
  late DateTime _selectedDay;
  late Map<DateTime, List<TaskModel>> _events;
=======
  List _selectedEvents;
  CalendarController _calendarController;
  DateTime _selectedDay;
  Map<DateTime, List> _events;
>>>>>>> Stashed changes

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now().withoutTime();
<<<<<<< Updated upstream
    _events = _buildTasksEvents(context.read<TasksCubit>().state);
  }

  Map<DateTime, List<TaskModel>> _buildTasksEvents(List<TaskModel> _tasks) {
    final tasks = [..._tasks];
    final Map<DateTime, List<TaskModel>> events = {};

    for (final task in tasks) {
      final DateTime currentDate = task.dueDate!.withoutTime();

      events[currentDate] ??= [];
      events[currentDate]?.add(task);
=======
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
>>>>>>> Stashed changes
    }
    return events;
  }

<<<<<<< Updated upstream
  List<TaskModel> getTasks(DateTime date) {
    return _events.entries
        .firstWhere(
          (element) => element.key.withoutTime() == date.withoutTime(),
          orElse: () => MapEntry(date, []),
        )
        .value;
=======
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
>>>>>>> Stashed changes
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    return BlocListener<TasksCubit, List<TaskModel>>(
      listener: (context, tasks) {
        print(
            'context.read<TasksCubit>().state.length, ${context.read<TasksCubit>().state.length}');
        setState(() {
          _events = _buildTasksEvents(tasks);
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.current.calendar),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.today),
              onPressed: () {
                setState(() {
                  // _calendarController.setSelectedDay(
                  // DateTime.now().withoutTime(),
                  // runCallback: true,
                  // );
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.calendar_view_day),
              onPressed: () {
                setState(() {
                  calendarFormat = calendarFormat == CalendarFormat.twoWeeks
                      ? CalendarFormat.week
                      : CalendarFormat.twoWeeks;
                });
              },
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            _buildTableCalendar(),
            const SizedBox(height: 8.0),
            if (getTasks(_selectedDay).isNotEmpty) ...[
              DateTile(_selectedDay),
              ...getTasks(_selectedDay).map((e) => TaskTile(e))
            ] else
              Center(child: Text(S.current.empty_tasks_list)),
          ],
        ),
        floatingActionButton:
            _selectedDay.isAfter(DateTime.now().withoutTime().subtract(const Duration(seconds: 1)))
                ? FloatingActionButton.extended(
                    heroTag: 'CalendarScreen',
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
      ),
=======
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
>>>>>>> Stashed changes
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
<<<<<<< Updated upstream
      locale: Helpers.isArabic ? 'ar' : 'en',
      firstDay: DateTime(1960),
      lastDay: DateTime(2400),
      focusedDay: _selectedDay,
      selectedDayPredicate: (day) => day == _selectedDay,
      calendarFormat: calendarFormat,
      availableGestures: AvailableGestures.horizontalSwipe,
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, day, events) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: events
                .take(4)
                .map((t) => Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(horizontal: 0.3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (t as TaskModel).course!.color,
                      ),
                    ))
                .toList(),
          );
        },
      ),
      eventLoader: (day) => getTasks(day),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = focusedDay;
        });
      },
      calendarStyle: CalendarStyle(
        defaultDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).accentColor,
        ),
        todayDecoration: BoxDecoration(
          color: Theme.of(context).accentColor.withOpacity(.5),
        ),
      ),
    );
  }

  // Widget _buildEventList() {
  //   final events = _selectedEvents.map((e) => e as TaskModel);

  //   return ListView(
  //     children: events.map((task) {
  //       return TaskTile(task);
  //     }).toList(),
  //   );
  // }
=======
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
>>>>>>> Stashed changes
}

extension on DateTime {
  DateTime withoutTime() => DateTime(year, month, day);

  DateTime addTime() => DateTime(year, month, day, DateTime.now().hour, DateTime.now().minute);
}
