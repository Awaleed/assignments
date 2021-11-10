import 'package:assignments/src/components/date_tile.dart';
import 'package:assignments/src/components/tasks_list_view.dart';
import 'package:assignments/src/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:assignments/src/helpers/helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../../components/task_tile.dart';
import '../../models/task_model.dart';
import '../../routes/config_routes.dart';
import '../task/task_dialog.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  static const routeName = '/calendar';

  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> with TickerProviderStateMixin {
  // late List _selectedEvents;
  CalendarFormat calendarFormat = CalendarFormat.twoWeeks;
  late DateTime _selectedDay;
  late Map<DateTime, List<TaskModel>> _events;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now().withoutTime();
    _events = _buildTasksEvents(context.read<TasksCubit>().state);
  }

  Map<DateTime, List<TaskModel>> _buildTasksEvents(List<TaskModel> _tasks) {
    final tasks = [..._tasks];
    final Map<DateTime, List<TaskModel>> events = {};

    for (final task in tasks) {
      final DateTime currentDate = task.dueDate!.withoutTime();

      events[currentDate] ??= [];
      events[currentDate]?.add(task);
    }
    return events;
  }

  List<TaskModel> getTasks(DateTime date) {
    return _events.entries
        .firstWhere(
          (element) => element.key.withoutTime() == date.withoutTime(),
          orElse: () => MapEntry(date, []),
        )
        .value;
  }

  @override
  Widget build(BuildContext context) {
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
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
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
}

extension on DateTime {
  DateTime withoutTime() => DateTime(year, month, day);

  DateTime addTime() => DateTime(year, month, day, DateTime.now().hour, DateTime.now().minute);
}
