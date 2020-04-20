import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class LocaleBase {
  Map<String, dynamic> _data;
  String _path;
  Future<void> load(String path) async {
    _path = path;
    final strJson = await rootBundle.loadString(path);
    _data = jsonDecode(strJson);
    initAll();
  }
  
  Map<String, String> getData(String group) {
    return Map<String, String>.from(_data[group]);
  }

  String getPath() => _path;

  Localecalendar _calendar;
  Localecalendar get calendar => _calendar;
  Localecourses _courses;
  Localecourses get courses => _courses;
  Localesettings _settings;
  Localesettings get settings => _settings;
  Localetasks _tasks;
  Localetasks get tasks => _tasks;

  void initAll() {
    _calendar = Localecalendar(Map<String, String>.from(_data['calendar']));
    _courses = Localecourses(Map<String, String>.from(_data['courses']));
    _settings = Localesettings(Map<String, String>.from(_data['settings']));
    _tasks = Localetasks(Map<String, String>.from(_data['tasks']));
  }
}

class Localecalendar {
  final Map<String, String> _data;
  Localecalendar(this._data);

  String get calendar => _data["calendar"];
  String get empty_tasks_list => _data["empty_tasks_list"];
}
class Localecourses {
  final Map<String, String> _data;
  Localecourses(this._data);

  String get course_title => _data["course_title"];
  String get course_color => _data["course_color"];
  String get new_course => _data["new_course"];
  String get editing => _data["editing"];
  String get empty_title_error_message => _data["empty_title_error_message"];
  String get short_title_error_message => _data["short_title_error_message"];
  String get courses => _data["courses"];
  String get empty_courses_list => _data["empty_courses_list"];
  String get save => _data["save"];
}
class Localesettings {
  final Map<String, String> _data;
  Localesettings(this._data);

  String get settings => _data["settings"];
  String get use_dark_mode => _data["use_dark_mode"];
  String get auto => _data["auto"];
}
class Localetasks {
  final Map<String, String> _data;
  Localetasks(this._data);

  String get upcoming => _data["upcoming"];
  String get overdue => _data["overdue"];
  String get tasks => _data["tasks"];
  String get homework => _data["homework"];
  String get project => _data["project"];
  String get quiz => _data["quiz"];
  String get test => _data["test"];
  String get notes => _data["notes"];
  String get progress => _data["progress"];
  String get at => _data["at"];
  String get task_name => _data["task_name"];
  String get empty_name_error_message => _data["empty_name_error_message"];
  String get short_name_error_message => _data["short_name_error_message"];
  String get empty_courses_error => _data["empty_courses_error"];
  String get due_date => _data["due_date"];
  String get overdue_error_message => _data["overdue_error_message"];
  String get reminder => _data["reminder"];
  String get reminder_date_error_message => _data["reminder_date_error_message"];
  String get new_subtask => _data["new_subtask"];
  String get new_task => _data["new_task"];
  String get editing => _data["editing"];
  String get empty_tasks_list => _data["empty_tasks_list"];
  String get subtasks => _data["subtasks"];
  String get save => _data["save"];
}
