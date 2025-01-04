import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateHeader extends StatelessWidget {
  final String selectedDate;
  final ValueChanged<String> onDateChange;

  const DateHeader({
    required this.selectedDate,
    required this.onDateChange,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString(); // Get current locale
    final currentDate = DateFormat.yMd(locale).parse(selectedDate);
    final pastelBlue = Color(0xFFAEDFF7);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          // Month and Year
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                DateFormat.MMMM(locale).format(currentDate),
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(width: 8),
              Text(
                DateFormat.y(locale).format(currentDate),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Day of Week Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final day = currentDate.subtract(Duration(days: currentDate.weekday - 1 - index));
              final isSelected = DateFormat.yMd(locale).format(day) == selectedDate;
              return GestureDetector(
                onTap: () => onDateChange(DateFormat.yMd(locale).format(day)),
                child: Column(
                  children: [
                    Text(
                      DateFormat.E(locale).format(day),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      decoration: BoxDecoration(
                        color: isSelected ? pastelBlue : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        DateFormat.d().format(day),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
