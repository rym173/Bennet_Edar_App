import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateTimeRangePicker extends StatefulWidget {
  final Function(DateTime, DateTime) onDateTimeRangeChanged;

  const CustomDateTimeRangePicker({Key? key, required this.onDateTimeRangeChanged}) : super(key: key);

  @override
  _CustomDateTimeRangePickerState createState() => _CustomDateTimeRangePickerState();
}

class _CustomDateTimeRangePickerState extends State<CustomDateTimeRangePicker> {
  late DateTime startDateTime;
  late DateTime endDateTime;

  @override
  void initState() {
    super.initState();
    startDateTime = DateTime.now();
    endDateTime = startDateTime.add(Duration(hours: 1)); // Default: 1 hour later
  }

  Future<void> _selectDateTime(BuildContext context, bool isStart) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStart ? startDateTime : endDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          if (isStart) {
            startDateTime = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
          } else {
            endDateTime = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
          }
        });

        widget.onDateTimeRangeChanged(startDateTime, endDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DISPONIBILITE:',
          style: TextStyle(
            color: Color(0xFF6C6C6C),
            fontSize: screenHeight * 0.015,
            fontFamily: 'Yaldevi',
            fontWeight: FontWeight.w300, 
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDateTimePicker('De', startDateTime, true, screenWidth, screenHeight),
            _buildDateTimePicker('à', endDateTime, false, screenWidth, screenHeight),
          ],
        ),
      ],
    );
  }

  Widget _buildDateTimePicker(String label, DateTime dateTime, bool isStart, double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: () => _selectDateTime(context, isStart),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.005,
          horizontal: screenWidth < 600 ? screenWidth * 0.015 : screenWidth * 0.03,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(screenWidth * 0.03), // Adjust as needed
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$label',
              style: TextStyle(
                color: Color(0xFF010F07),
                fontSize: screenWidth < 600 ? screenHeight * 0.020 : screenHeight * 0.022,
                fontFamily: 'Yaldevi',
                fontWeight: FontWeight.bold,
                letterSpacing: -0.28,
              ),
            ),
            SizedBox(height: screenHeight * 0.005),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Color(0xFF6C6C6C),
                  size: screenWidth < 600 ? screenHeight * 0.030 : screenHeight * 0.034,
                ),
                SizedBox(width: screenWidth * 0.01),
                Text(
                  '${DateFormat('dd/MM/yyyy  HH:mm').format(dateTime)}',
                  style: TextStyle(
                    color: Color(0xFF6C6C6C),
                    fontSize: screenWidth < 600 ? screenHeight * 0.020 : screenHeight * 0.022,
                    fontFamily: 'Yaldevi',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.28,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
