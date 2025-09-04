import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class PilihTanggalScreen extends StatefulWidget {
  const PilihTanggalScreen({super.key});

  @override
  State<PilihTanggalScreen> createState() => _PilihTanggalScreenState();
}

class _PilihTanggalScreenState extends State<PilihTanggalScreen> {
  DateTime? _tanggalMulai;
  DateTime? _tanggalBerakhir;
  bool _showCalendar = false;
  String _calendarType = ''; // 'start' or 'end'

  void _showDatePicker({required bool isStartDate}) {
    setState(() {
      _showCalendar = true;
      _calendarType = isStartDate ? 'start' : 'end';
    });
  }

  void _selectDate(DateTime selectedDate) {
    if (_calendarType == 'start') {
      setState(() {
        _tanggalMulai = selectedDate;
        if (_tanggalBerakhir != null &&
            _tanggalBerakhir!.isBefore(selectedDate)) {
          _tanggalBerakhir = null;
        }
        _showCalendar = false;
      });
    } else {
      if (_tanggalMulai != null && selectedDate.isBefore(_tanggalMulai!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Tanggal berakhir tidak boleh kurang dari tanggal mulai',
            ),
            backgroundColor: Color(0xFFD35400),
          ),
        );
      } else {
        setState(() {
          _tanggalBerakhir = selectedDate;
          _showCalendar = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: Column(
        children: [
          // Header
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
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: const Color(0xFFD35400));
                    },
                  ),
                  Positioned(
                    left: 16,
                    top: 45,
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                if (_tanggalMulai != null &&
                                    _tanggalBerakhir != null) {
                                  Navigator.pop(context, {
                                    'startDate': _tanggalMulai,
                                    'endDate': _tanggalBerakhir,
                                  });
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Pilih Tanggal',
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

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Tanggal Mulai
                  GestureDetector(
                    onTap: () => _showDatePicker(isStartDate: true),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Color(0xFFD35400),
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tanggal Mulai',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFD35400),
                                  ),
                                ),
                                Text(
                                  _tanggalMulai == null
                                      ? 'Pilih Tanggal'
                                      : '${_tanggalMulai!.day}/${_tanggalMulai!.month}/${_tanggalMulai!.year}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF989898),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFFD35400),
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Tanggal Berakhir
                  GestureDetector(
                    onTap: () => _showDatePicker(isStartDate: false),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Color(0xFFD35400),
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tanggal Berakhir',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFD35400),
                                  ),
                                ),
                                Text(
                                  _tanggalBerakhir == null
                                      ? 'Pilih Tanggal'
                                      : '${_tanggalBerakhir!.day}/${_tanggalBerakhir!.month}/${_tanggalBerakhir!.year}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF989898),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFFD35400),
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Calendar
                  if (_showCalendar)
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Color(0xFFD35400), width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'October 2020',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TableCalendar(
                            focusedDay: DateTime.now(),
                            firstDay: DateTime(2000),
                            lastDay: DateTime(2100),
                            selectedDayPredicate: (day) {
                              if (_calendarType == 'start') {
                                return _tanggalMulai != null &&
                                    isSameDay(_tanggalMulai!, day);
                              } else {
                                return _tanggalBerakhir != null &&
                                    isSameDay(_tanggalBerakhir!, day);
                              }
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              _selectDate(selectedDay);
                            },
                            calendarStyle: CalendarStyle(
                              outsideDaysVisible: false,
                              weekendTextStyle: TextStyle(color: Colors.black),
                              holidayTextStyle: TextStyle(color: Colors.black),
                              defaultTextStyle: TextStyle(color: Colors.black),
                              todayDecoration: BoxDecoration(
                                color: Color(0xFFD35400).withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                              selectedDecoration: BoxDecoration(
                                color: Color(0xFFD35400),
                                shape: BoxShape.circle,
                              ),
                              selectedTextStyle: TextStyle(color: Colors.white),
                              todayTextStyle: TextStyle(color: Colors.white),
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
                              titleTextStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              weekendStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _showCalendar = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD35400),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Choose Date',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
