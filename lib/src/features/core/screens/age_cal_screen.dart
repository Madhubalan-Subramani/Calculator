import 'package:calculator/src/constants/font_theme.dart';
import 'package:calculator/src/constants/image_string.dart';
import 'package:calculator/src/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../../common_widgets/custom_appbar.dart';

class AgeCalScreen extends StatefulWidget {
  const AgeCalScreen({super.key});

  @override
  State<AgeCalScreen> createState() => _AgeCalScreenState();
}

class _AgeCalScreenState extends State<AgeCalScreen> {
  DateTime _selectedDateOfBirth = DateTime.now();
  DateTime _selectedToday = DateTime.now();

  int _years = 0;
  int _months = 0;
  int _days = 0;
  DateTime? _nextBirthday;
  int _remainingMonths = 0;
  int _remainingDays = 0;

  int _totalYears = 0;
  int _totalMonths = 0;
  int _totalWeeks = 0;
  int _totalDays = 0;
  int _totalHours = 0;
  int _totalMinutes = 0;

  void _calculateAge() {
    final now = _selectedToday;
    final dob = _selectedDateOfBirth;

    _years = now.year - dob.year;
    _months = now.month - dob.month;
    _days = now.day - dob.day;

    if (_days < 0) {
      _months -= 1;
      _days += DateTime(now.year, now.month, 0).day;
    }

    if (_months < 0) {
      _years -= 1;
      _months += 12;
    }

    _calculateNextBirthday();
    _calculateTotalValues();
  }

  void _calculateNextBirthday() {
    final now = _selectedToday;
    DateTime nextBirthday = DateTime(
      now.year,
      _selectedDateOfBirth.month,
      _selectedDateOfBirth.day,
    );

    if (nextBirthday.isBefore(now)) {
      nextBirthday = DateTime(
        now.year + 1,
        _selectedDateOfBirth.month,
        _selectedDateOfBirth.day,
      );
    }

    _nextBirthday = nextBirthday;

    // Calculate months and days remaining until next birthday
    _remainingMonths = nextBirthday.month - now.month;
    _remainingDays = nextBirthday.day - now.day;

    if (_remainingDays < 0) {
      _remainingMonths -= 1;
      _remainingDays += DateTime(now.year, now.month + 1, 0).day;
    }

    if (_remainingMonths < 0) {
      _remainingMonths += 12;
    }
  }

  void _calculateTotalValues() {
    final now = _selectedToday;
    final dob = _selectedDateOfBirth;

    Duration ageDuration = now.difference(dob);

    _totalYears = _years;
    _totalMonths = _totalYears * 12 + _months;
    _totalWeeks = ageDuration.inDays ~/ 7;
    _totalDays = ageDuration.inDays;
    _totalHours = ageDuration.inHours;
    _totalMinutes = ageDuration.inMinutes;
  }

  void _changeDateOfBirth(DateTime newDate) {
    setState(() {
      _selectedDateOfBirth = newDate;
      _calculateAge(); // Recalculate age and next birthday whenever the date of birth changes
    });
  }

  void _changeToday(DateTime newDate) {
    setState(() {
      _selectedToday = newDate;
      _calculateAge(); // Recalculate age and next birthday whenever today's date changes
    });
  }

  @override
  void initState() {
    super.initState();
    _calculateAge(); // Initial calculation of age and next birthday
  }

  Future<void> _showDatePicker({
    required DateTime initialDate,
    required Function(DateTime) onDateSelected,
    DateTime? maximumDate,
  }) async {
    DateTime? pickedDate = await DatePickerDialogWidget(
      initialDate: initialDate,
      maximumDate: maximumDate,
    ).showDatePickerDialog(context);

    if (pickedDate != null) {
      onDateSelected(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: const CustomAppbar(title: 'Age Calculator'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date of Birth',
                      style: bodyText16W,
                    ),
                    GestureDetector(
                      onTap: () => _showDatePicker(
                        initialDate: _selectedDateOfBirth,
                        onDateSelected: _changeDateOfBirth,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            DateFormat('dd, MMM, yyyy')
                                .format(_selectedDateOfBirth),
                            style: bodyText16W,
                          ),
                          const SizedBox(width: 3),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 24,
                            color: Colors.white70,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: xl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Today',
                      style: bodyText16W,
                    ),
                    GestureDetector(
                      onTap: () => _showDatePicker(
                        initialDate: _selectedToday,
                        onDateSelected: _changeToday,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            DateFormat('dd, MMM, yyyy').format(_selectedToday),
                            style: bodyText16W,
                          ),
                          const SizedBox(width: 3),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 24,
                            color: Colors.white70,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: lg),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: xl),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Color(0xFF80C4B7),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('Age', style: bodyText24W),
                              Row(
                                children: [
                                  Text('$_years', style: bodyText50W),
                                  const SizedBox(width: 10),
                                  Text('years', style: bodyText12W),
                                ],
                              ),
                              Text('$_months months | $_days days',
                                  style: bodyText12W),
                              const SizedBox(height: sm),
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 150,
                            color: Colors.white70,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Upcoming birthday', style: bodyText14W),
                              const SizedBox(height: sm),
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFE3856B),
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Image.asset(
                                        ageIconImage,
                                        color: const Color(0xFFD5CAE4),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: sm),
                              Text(
                                DateFormat('EEEE').format(_nextBirthday!),
                                style: bodyText14W,
                              ),
                              const SizedBox(height: sm),
                              Text(
                                  '$_remainingMonths months | $_remainingDays days',
                                  style: bodyText12W),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: md),
                      Text('More info', style: bodyText18W),
                      const SizedBox(height: lg),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text('Years', style: bodyText12W),
                              Text('$_totalYears', style: bodyText20W),
                              const SizedBox(height: lg),
                              Text('Days', style: bodyText12W),
                              Text('$_totalDays', style: bodyText16W),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Months', style: bodyText12W),
                              Text('$_totalMonths', style: bodyText20W),
                              const SizedBox(height: lg),
                              Text('Hours', style: bodyText12W),
                              Text('$_totalHours', style: bodyText14W),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Weeks', style: bodyText12W),
                              Text('$_totalWeeks', style: bodyText20W),
                              const SizedBox(height: lg),
                              Text('Minutes', style: bodyText12W),
                              Text('$_totalMinutes', style: bodyText14W),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DatePickerDialogWidget extends StatelessWidget {
  final DateTime initialDate;
  final DateTime? maximumDate;

  const DatePickerDialogWidget({
    required this.initialDate,
    this.maximumDate,
    super.key,
  });

  Future<DateTime?> showDatePickerDialog(BuildContext context) async {
    DateTime? pickedDate = await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) {
        DateTime tempPickedDate = initialDate;
        return CupertinoAlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select Date', style: bodyText16B),
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: initialDate,
                  maximumDate: maximumDate,
                  onDateTimeChanged: (DateTime newDate) {
                    tempPickedDate = newDate;
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: bodyText14B),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(tempPickedDate),
              child: Text(
                'OK',
                style: bodyText14B,
              ),
            ),
          ],
        );
      },
    );

    return pickedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
