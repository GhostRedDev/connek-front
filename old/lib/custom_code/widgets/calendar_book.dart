// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:table_calendar/table_calendar.dart';

class CalendarBook extends StatefulWidget {
  const CalendarBook({
    super.key,
    this.width,
    this.height,
    this.notAvailableDates,
    this.highPriceDates,
    this.onDateSelected,
  });

  final double? width;
  final double? height;
  final List<DateTime>? notAvailableDates;
  final List<DateTime>? highPriceDates;
  final Future<void> Function(DateTime selectedDate)? onDateSelected;

  @override
  State<CalendarBook> createState() => _CalendarBookState();
}

class _CalendarBookState extends State<CalendarBook> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: widget.width ?? 431,
      height: widget.height ?? 392,
      decoration: BoxDecoration(
        color:
            isDarkMode ? const Color(0xFF1C1C1E) : Colors.white, // Cambia según tema
        borderRadius: BorderRadius.circular(10),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) async {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            FFAppState().update(() {
              FFAppState().clientBookingSession.daySelected = DateTime(
                selectedDay.year,
                selectedDay.month,
                selectedDay.day,
              );
            });
          });
          if (widget.onDateSelected != null) {
            await widget.onDateSelected!(selectedDay);
          }
        },
        calendarStyle: CalendarStyle(
          todayDecoration: const BoxDecoration(), // ← sin fondo especial
          todayTextStyle: TextStyle(
            color: theme.primaryText, // ← igual al resto del calendario
          ),
          selectedDecoration: const BoxDecoration(
            color: Color(0xFFA9C3FF),
            shape: BoxShape.circle,
          ),
          outsideDaysVisible: false,
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon: Icon(Icons.chevron_left, color: theme.primaryText),
          rightChevronIcon: Icon(Icons.chevron_right, color: theme.primaryText),
        ),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            final notAvailableDates = widget.notAvailableDates ?? [];
            final highPriceDates = widget.highPriceDates ?? [];

            if (notAvailableDates.any((date) => isSameDay(date, day))) {
              return _buildDayCell(
                day,
                const Color(0xFF1D415C), // Azul #1D415C para Not Available
                Colors.white,
              );
            } else if (highPriceDates.any((date) => isSameDay(date, day))) {
              return _buildHighPriceDay(day, Colors.red);
            }
            return null;
          },
        ),
      ),
    );
  }

  // Widget para los días "Not Available" (Fondo azul oscuro y texto blanco)
  Widget _buildDayCell(DateTime day, Color bgColor, Color textColor) {
    return Container(
      margin: const EdgeInsets.all(4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Text(
        '${day.day}',
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Widget para los días "High Price" (Solo cambia el color del número a rojo)
  Widget _buildHighPriceDay(DateTime day, Color textColor) {
    return Container(
      margin: const EdgeInsets.all(4),
      alignment: Alignment.center,
      child: Text(
        '${day.day}',
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
