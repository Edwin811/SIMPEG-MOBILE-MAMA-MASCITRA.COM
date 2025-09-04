import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectedDateScreen extends StatefulWidget {
  const SelectedDateScreen({super.key});

  @override
  State<SelectedDateScreen> createState() => _SelectedDateScreenState();
}

class _SelectedDateScreenState extends State<SelectedDateScreen> {
  DateTime? startDate;
  DateTime? endDate;

  void _showCalendar({required bool isStart}) async {
    DateTime? picked = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        DateTime selected = DateTime.now();
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 32,
                ),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Color(0xFFD35400), width: 2),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TableCalendar(
                      focusedDay: selected,
                      firstDay: DateTime(2000),
                      lastDay: DateTime(2100),
                      selectedDayPredicate: (day) => day == selected,
                      onDaySelected: (day, _) {
                        setModalState(() => selected = day);
                      },
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Color(0xFFD35400).withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Color(0xFFD35400),
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: TextStyle(color: Colors.white),
                      ),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        leftChevronIcon: Icon(
                          Icons.chevron_left,
                          color: Color(0xFFD35400),
                        ),
                        rightChevronIcon: Icon(
                          Icons.chevron_right,
                          color: Color(0xFFD35400),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Validasi end date
                          if (!isStart &&
                              startDate != null &&
                              selected.isBefore(startDate!)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'End Date tidak boleh kurang dari Start Date',
                                ),
                                backgroundColor: Color(0xFFD35400),
                              ),
                            );
                          } else {
                            Navigator.pop(context, selected);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD35400),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Pilih Tanggal',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
          // Jika endDate sudah terisi dan kurang dari startDate, reset endDate
          if (endDate != null && endDate!.isBefore(startDate!)) {
            endDate = null;
          }
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            child: Container(
              width: screenWidth,
              height: 110,
              color: const Color(0xFFD35400),
              child: Stack(
                children: [
                  Image.asset(
                    'lib/assets/login_pattern.png',
                    fit: BoxFit.cover,
                    width: screenWidth,
                    height: 110,
                  ),
                  Positioned(
                    left: 16,
                    top: 48,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Select Date',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _DateCard(
                  title: 'Start Date',
                  subtitle:
                      startDate == null
                          ? 'Choose Date'
                          : '${startDate!.day}/${startDate!.month}/${startDate!.year}',
                  onTap: () => _showCalendar(isStart: true),
                ),
                const SizedBox(height: 16),
                _DateCard(
                  title: 'End Date',
                  subtitle:
                      endDate == null
                          ? 'Choose Date'
                          : '${endDate!.day}/${endDate!.month}/${endDate!.year}',
                  onTap: () => _showCalendar(isStart: false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DateCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _DateCard({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.13),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today,
              color: Color(0xFFD35400),
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFFD35400),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF989898),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.expand_more, color: Color(0xFFD35400), size: 28),
          ],
        ),
      ),
    );
  }
}
