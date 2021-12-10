<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A date time pick form field widget.
class DateTimeFormField extends StatelessWidget {
  /// The initial date time, default value is 'DateTime.now()'.
  final DateTime initialValue;

  /// Save value function of form field.
<<<<<<< Updated upstream
  final FormFieldSetter<DateTime>? onSaved;

  /// Validate function of form field.
  final FormFieldValidator<DateTime>? validator;

  /// Whether validate every time, default value is false.
  final AutovalidateMode? autovalidateMode;
=======
  final FormFieldSetter<DateTime> onSaved;

  /// Validate function of form field.
  final FormFieldValidator<DateTime> validator;

  /// Whether validate every time, default value is false.
  final AutovalidateMode autovalidateMode;
>>>>>>> Stashed changes
  final bool enabled;

  /// The label of form field, default value is 'Date Time'.
  final String label;
<<<<<<< Updated upstream
  final InputDecoration? decoration;
=======
  final InputDecoration decoration;
>>>>>>> Stashed changes

  /// The format of displaying date time in form field, default value is 'DateFormat("EE, MMM d, yyyy h:mma")' in date and time mode,
  /// 'DateFormat("EEE, MMM d, yyyy")' in date only mode,
  /// 'DateFormat("h:mm a") in time only mode.
  final DateFormat formatter;

  /// Only show and edit date, default value is false.
  final bool onlyDate;

  /// Only show and edit time, default value is false. [onlyDate] and [onlyTime] cannot be set to true at the same time.
  final bool onlyTime;

  /// The first date time of picking, default value is 'DateTime(1970)'.
  final DateTime firstDate;

  /// The last date time of picking, default value is 'DateTime(2100)'.
  final DateTime lastDate;

  /// Create a DateTimeFormField.
  /// The [onlyDate] and [onlyTime] arguments can not be set to true at the same time.
  DateTimeFormField({
<<<<<<< Updated upstream
    required DateTime? initialValue,
    String? label,
    DateFormat? formatter,
=======
    @required DateTime initialValue,
    String label,
    DateFormat formatter,
>>>>>>> Stashed changes
    this.onSaved,
    this.validator,
    this.autovalidateMode,
    this.enabled = true,
    this.onlyDate = false,
    this.onlyTime = false,
<<<<<<< Updated upstream
    DateTime? firstDate,
    DateTime? lastDate,
=======
    DateTime firstDate,
    DateTime lastDate,
>>>>>>> Stashed changes
    this.decoration,
  })  : assert(!onlyDate || !onlyTime),
        initialValue = initialValue ?? DateTime.now(),
        label = label ?? 'Date Time',
        formatter = formatter ??
            (onlyDate
                ? DateFormat('EEE, MMM d, yyyy')
<<<<<<< Updated upstream
                : (onlyTime ? DateFormat('h:mm a') : DateFormat('EE, MMM d, yyyy h:mma'))),
=======
                : (onlyTime
                    ? DateFormat('h:mm a')
                    : DateFormat('EE, MMM d, yyyy h:mma'))),
>>>>>>> Stashed changes
        firstDate = firstDate ?? DateTime(1970),
        lastDate = lastDate ?? DateTime(2100);

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      validator: validator,
      autovalidateMode: autovalidateMode,
      initialValue: initialValue,
      onSaved: onSaved,
      enabled: enabled,
      builder: (FormFieldState<DateTime> state) {
        return InkWell(
          onTap: () async {
<<<<<<< Updated upstream
            DateTime? date;
            TimeOfDay? time = const TimeOfDay(hour: 0, minute: 0);
            if (onlyDate) {
              date = await showDatePicker(
                context: context,
                initialDate: state.value!,
=======
            DateTime date;
            TimeOfDay time = const TimeOfDay(hour: 0, minute: 0);
            if (onlyDate) {
              date = await showDatePicker(
                context: context,
                initialDate: state.value,
>>>>>>> Stashed changes
                firstDate: firstDate,
                lastDate: lastDate,
              );
              if (date != null) {
                state.didChange(date);
              }
            } else if (onlyTime) {
              time = await showTimePicker(
                context: context,
<<<<<<< Updated upstream
                initialTime: TimeOfDay.fromDateTime(state.value!),
=======
                initialTime: TimeOfDay.fromDateTime(state?.value),
>>>>>>> Stashed changes
              );
              if (time != null) {
                state.didChange(DateTime(
                  initialValue.year,
                  initialValue.month,
                  initialValue.day,
                  time.hour,
                  time.minute,
                ));
              }
            } else {
              date = await showDatePicker(
                context: context,
<<<<<<< Updated upstream
                initialDate: state.value!,
=======
                initialDate: state.value,
>>>>>>> Stashed changes
                firstDate: firstDate,
                lastDate: lastDate,
              );
              if (date != null) {
                time = await showTimePicker(
                  context: context,
<<<<<<< Updated upstream
                  initialTime: TimeOfDay.fromDateTime(state.value!),
=======
                  initialTime: TimeOfDay.fromDateTime(state.value),
>>>>>>> Stashed changes
                );
                if (time != null) {
                  state.didChange(DateTime(
                    date.year,
                    date.month,
                    date.day,
                    time.hour,
                    time.minute,
                  ));
                }
              }
            }
          },
          child: InputDecorator(
            decoration: decoration?.copyWith(errorText: state.errorText) ??
                InputDecoration(
                  labelText: label,
                  errorText: state.errorText,
                ),
            child: Text(
<<<<<<< Updated upstream
              formatter.format(state.value!),
              style: state.hasError ? TextStyle(color: Theme.of(context).errorColor) : null,
=======
              formatter.format(state.value),
              style: state.hasError
                  ? TextStyle(color: Theme.of(context).errorColor)
                  : null,
>>>>>>> Stashed changes
            ),
          ),
        );
      },
    );
  }
}
