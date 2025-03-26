import 'package:calculator/src/constants/font_theme.dart';
import 'package:calculator/src/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../../common_widgets/custom_appbar.dart';
import '../../../common_widgets/input_field_widget.dart';

class DateDifferenceCalScreen extends StatefulWidget {
  const DateDifferenceCalScreen({super.key});

  @override
  State<DateDifferenceCalScreen> createState() =>
      _DateDifferenceCalScreenState();
}

class _DateDifferenceCalScreenState extends State<DateDifferenceCalScreen> {
  DateTime _person1Date = DateTime.now();
  DateTime _person2Date = DateTime.now();

  final TextEditingController _person1NameController = TextEditingController();
  final TextEditingController _person2NameController = TextEditingController();

  int _years = 0;
  int _months = 0;
  int _days = 0;

  String _resultText = '';

  void _calculateAgeDifference() {
    final now = _person2Date;
    final dob = _person1Date;

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
    _updateResultText();
  }

  void _changePerson1Date(DateTime newDate) {
    setState(() {
      _person1Date = newDate;
      _calculateAgeDifference(); // Recalculate age difference when the date of birth changes
    });
  }

  void _changePerson2Date(DateTime newDate) {
    setState(() {
      _person2Date = newDate;
      _calculateAgeDifference(); // Recalculate age difference when today's date changes
    });
  }

  @override
  void initState() {
    super.initState();
    _calculateAgeDifference(); // Initial calculation of age difference
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

  void _updateResultText() {
    String person1Name = _person1NameController.text.trim();
    String person2Name = _person2NameController.text.trim();

    if (person1Name.isEmpty) person1Name = 'Person 1';
    if (person2Name.isEmpty) person2Name = 'Person 2';

    _resultText =
        '$person1Name is $_years years $_months months $_days days older than $person2Name.';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: const CustomAppbar(title: 'Date Difference'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InputFormField(
                        labelText: 'Name of Person 1',
                        hintText: 'Person 1',
                        controller: _person1NameController,
                      ),
                    ),
                    const SizedBox(width: xl),
                    GestureDetector(
                      onTap: () => _showDatePicker(
                        initialDate: _person1Date,
                        onDateSelected: _changePerson1Date,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            DateFormat('dd, MMM, yyyy').format(_person1Date),
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
                    Expanded(
                      child: InputFormField(
                        labelText: 'Name of Person 2',
                        hintText: 'Person 2',
                        controller: _person2NameController,
                      ),
                    ),
                    const SizedBox(width: xl),
                    GestureDetector(
                      onTap: () => _showDatePicker(
                        initialDate: _person2Date,
                        onDateSelected: _changePerson2Date,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            DateFormat('dd, MMM, yyyy').format(_person2Date),
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
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Color(0xFF80C4B7),
                  ),
                  child: Column(
                    children: [
                      Text('Difference', style: bodyText18W),
                      const SizedBox(height: lg),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                height: 1,
                                width: double.infinity,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: lg),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text('Years', style: bodyText12W),
                              Text('$_years', style: bodyText16W)
                            ],
                          ),
                          Column(
                            children: [
                              Text('Months', style: bodyText12W),
                              Text('$_months', style: bodyText16W)
                            ],
                          ),
                          Column(
                            children: [
                              Text('Days', style: bodyText12W),
                              Text('$_days', style: bodyText16W)
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: lg),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                height: 1,
                                width: double.infinity,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: lg),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text(
                          _resultText,
                          style: bodyText16W,
                          textAlign: TextAlign.justify,
                        ),
                      )
                    ],
                  ),
                ),
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
