import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// TODO: import this package and create calendar: https://github.com/ZedTheLed/calendar_views

class Calendar extends StatefulWidget {
  Calendar({Key key}) : super(key : key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> with TickerProviderStateMixin{
  CalendarController _calendarController;
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 30)): [
        'Recipe01',
        'Recipe02',
        'Recipe03'
      ],
      _selectedDay.subtract(Duration(days: 27)): ['Recipe01'],
      _selectedDay.subtract(Duration(days: 20)): [
        'Recipe01',
        'Recipe02',
        'Recipe03',
        'Recipe04'
      ],
      _selectedDay.subtract(Duration(days: 16)): ['Recipe01', 'Recipe02'],
      _selectedDay.subtract(Duration(days: 10)): [
        'Recipe01',
        'Recipe02',
        'Recipe03'
      ],
      _selectedDay.subtract(Duration(days: 4)): [
        'Recipe01',
        'Recipe02',
        'Recipe03'
      ],
      _selectedDay.subtract(Duration(days: 2)): ['Recipe01', 'Recipe02'],
      _selectedDay: ['Recipe01', 'Recipe02', 'Recipe03', 'Recipe04'],
      _selectedDay.add(Duration(days: 1)): [
        'Recipe01',
        'Recipe02',
        'Recipe03',
        'Recipe04'
      ],
      _selectedDay.add(Duration(days: 3)): Set.from(
        ['Recipe01', 'Recipe02', 'Recipe03'],).toList(),
      _selectedDay.add(Duration(days: 7)): ['Recipe01', 'Recipe02', 'Recipe03'],
      _selectedDay.add(Duration(days: 11)): ['Recipe01', 'Recipe02'],
      _selectedDay.add(Duration(days: 17)): [
        'Recipe01',
        'Recipe02',
        'Recipe03',
        'Recipe04'
      ],
      _selectedDay.add(Duration(days: 22)): ['Recipe01', 'Recipe02'],
      _selectedDay.add(Duration(days: 26)): [
        'Recipe01',
        'Recipe02',
        'Recipe03'
      ],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // Switch out 2 lines below to play with TableCalendar's settings
          //-----------------------
          _buildTableCalendar(),
          // _buildTableCalendarWithBuilders(),
          const SizedBox(height: 8.0),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
    calendarController: _calendarController,
    events: _events,
    calendarStyle: CalendarStyle(
      selectedColor: Colors.green,
      todayColor: Colors.green[200],
    ),
      onDaySelected: _onDaySelected,
    onVisibleDaysChanged: _onVisibleDaysChanged,
    onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date) ? Colors.brown[300] : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.8),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          title: Text(event.toString()),
          onTap: () => print('$event tapped!'),
        ),
      ))
          .toList(),
    );
  }
}