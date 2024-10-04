import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DateTimeSelectionPage extends StatefulWidget {
  final String selectedProfessional;

  DateTimeSelectionPage({required this.selectedProfessional});

  @override
  _DateTimeSelectionPageState createState() => _DateTimeSelectionPageState();
}

class _DateTimeSelectionPageState extends State<DateTimeSelectionPage> {
  Map<DateTime, List<String>> availableTimes = {
    DateTime.now(): ["10:00", "11:00", "14:00"],
    DateTime.now().add(Duration(days: 1)): ["10:00", "12:00"],
    DateTime.now().add(Duration(days: 2)): ["11:00", "13:00", "15:00"],
    DateTime.now().add(Duration(days: 3)): ["09:00", "10:00"],
    DateTime.now().add(Duration(days: 4)): ["11:00", "12:00", "15:00"],
    DateTime.now().add(Duration(days: 5)): ["13:00", "16:00"],
  };

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecionar Data e Hora"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(Duration(days: 30)),
            focusedDay: selectedDate,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                selectedDate = selectedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Horários disponíveis para ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView(
              children: availableTimes[selectedDate] != null
                  ? availableTimes[selectedDate]!.map((time) {
                      return ListTile(
                        title: Text(time),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SummaryPage(
                                selectedProfessional: widget.selectedProfessional,
                                selectedDate: selectedDate,
                                selectedTime: time,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList()
                  : [ListTile(title: Text("Nenhum horário disponível"))],
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryPage extends StatelessWidget {
  final String selectedProfessional;
  final DateTime selectedDate;
  final String selectedTime;

  SummaryPage({
    required this.selectedProfessional,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resumo do Agendamento"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Profissional: $selectedProfessional"),
            Text("Data: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
            Text("Horário: $selectedTime"),
          ],
        ),
      ),
    );
  }
}