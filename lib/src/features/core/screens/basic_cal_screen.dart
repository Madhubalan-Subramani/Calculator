import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../common_widgets/custom_appbar.dart';
import '../../../common_widgets/custom_button.dart';
import '../../../constants/font_theme.dart';
import '../../../constants/sizes.dart';

class BasicCalScreen extends StatefulWidget {
  const BasicCalScreen({super.key});

  @override
  State<BasicCalScreen> createState() => _BasicCalScreenState();
}

class _BasicCalScreenState extends State<BasicCalScreen> {
  double firstVal = 0;
  double secondVal = 0;
  String history = '';
  String textToDisplay = '0';
  String res = '';
  String operation = '';

  void btnOnClick(String btnVal) {
    if (btnVal == 'AC') {
      setState(() {
        firstVal = 0;
        secondVal = 0;
        history = '';
        textToDisplay = '0';
        res = '';
        operation = '';
      });
    } else if (btnVal == 'C') {
      setState(() {
        if (textToDisplay.isNotEmpty) {
          textToDisplay = textToDisplay.substring(0, textToDisplay.length - 1);
          if (textToDisplay.isEmpty) {
            textToDisplay = '0';
          }
        }
      });
    } else if (btnVal == '+' ||
        btnVal == '-' ||
        btnVal == 'x' ||
        btnVal == '/' ||
        btnVal == '%') {
      firstVal = double.tryParse(textToDisplay) ?? 0;
      operation = btnVal;
      setState(() {
        history = '= ${_formatNumber(firstVal)} $operation ';
        textToDisplay = '';
      });
    } else if (btnVal == '=') {
      secondVal = double.tryParse(textToDisplay) ?? 0;
      if (operation == '+') {
        res = (firstVal + secondVal).toString();
      } else if (operation == '-') {
        res = (firstVal - secondVal).toString();
      } else if (operation == 'x') {
        res = (firstVal * secondVal).toString();
      } else if (operation == '/') {
        res = (firstVal / secondVal).toString();
      } else if (operation == '%') {
        res = (firstVal * (secondVal / 100)).toString();
      }
      setState(() {
        textToDisplay = _formatNumber(double.parse(res));
        history =
            '= ${_formatNumber(firstVal)} $operation ${_formatNumber(secondVal)}';
      });
    } else {
      setState(() {
        if (textToDisplay == '0' && btnVal != '.') {
          textToDisplay = btnVal;
        } else {
          textToDisplay += btnVal;
        }
      });
    }
  }

  String _formatNumber(double number) {
    if (number % 1 == 0) {
      return number.toStringAsFixed(0);
    } else {
      return number.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Show exit confirmation dialog only if this is the BasicCalScreen
          final shouldExit = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'Exit App',
                style: bodyText18B,
              ),
              content: Text(
                'Do you really want to exit?',
                style: bodyText16B,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'No',
                    style: bodyText14B,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    'Yes',
                    style: bodyText14B,
                  ),
                ),
              ],
            ),
          );
          return shouldExit ?? false;
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: const CustomAppbar(
              title: 'Calculator',
              showBackButton: false,
            ),
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 20),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        history,
                        style: bodyText24G,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      textToDisplay,
                      style: bodyText50W,
                    ),
                  ),
                ),
                const SizedBox(height: md),
                Row(
                  children: [
                    CircleButton(
                      onTap: () {
                        btnOnClick('AC');
                      },
                      bgColor: const Color(0xFF80C4B7),
                      text: 'AC',
                      textStyle: bodyText16W,
                    ),
                    CircleButton(
                      onTap: () {
                        btnOnClick('C');
                      },
                      bgColor: const Color(0xFF80C4B7),
                      icon: const FaIcon(
                        FontAwesomeIcons.deleteLeft,
                        color: Colors.white,
                      ),
                      iconSize: 20,
                    ),
                    CircleButton(
                      onTap: () {
                        btnOnClick('%');
                      },
                      bgColor: const Color(0xFF80C4B7),
                      icon: const FaIcon(
                        FontAwesomeIcons.percent,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    CircleButton(
                      onTap: () {
                        btnOnClick('/');
                      },
                      bgColor: const Color(0xFF80C4B7),
                      icon: const FaIcon(
                        FontAwesomeIcons.divide,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: md),
                Row(
                  children: [
                    CircleButton(
                      onTap: () {
                        btnOnClick('7');
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.seven,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    CircleButton(
                      onTap: () {
                        btnOnClick('8');
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.eight,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    CircleButton(
                      onTap: () {
                        btnOnClick('9');
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.nine,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    CircleButton(
                      onTap: () {
                        btnOnClick('x');
                      },
                      bgColor: const Color(0xFF80C4B7),
                      icon: const FaIcon(
                        FontAwesomeIcons.xmark,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: md),
                Row(
                  children: [
                    CircleButton(
                      onTap: () {
                        btnOnClick('4');
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.four,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    CircleButton(
                      onTap: () {
                        btnOnClick('5');
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.five,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    CircleButton(
                      onTap: () {
                        btnOnClick('6');
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.six,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    CircleButton(
                      onTap: () {
                        btnOnClick('-');
                      },
                      bgColor: const Color(0xFF80C4B7),
                      icon: const FaIcon(
                        FontAwesomeIcons.minus,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: md),
                Row(
                  children: [
                    CircleButton(
                      onTap: () {
                        btnOnClick('1');
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.one,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    CircleButton(
                      onTap: () {
                        btnOnClick('2');
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.two,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    CircleButton(
                      onTap: () {
                        btnOnClick('3');
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.three,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    CircleButton(
                      onTap: () {
                        btnOnClick('+');
                      },
                      bgColor: const Color(0xFF80C4B7),
                      icon: const FaIcon(
                        FontAwesomeIcons.plus,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: md),
                Row(
                  children: [
                    CircleButton(
                      onTap: () {},
                      icon: const FaIcon(
                        FontAwesomeIcons.calculator,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    CircleButton(
                      onTap: () {
                        btnOnClick('0');
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.zero,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    CircleButton(
                      onTap: () {
                        btnOnClick('.');
                      },
                      text: '.',
                    ),
                    CircleButton(
                      onTap: () {
                        btnOnClick('=');
                      },
                      bgColor: const Color(0xFFE3856B),
                      icon: const FaIcon(
                        FontAwesomeIcons.equals,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: lg),
              ],
            ),
          ),
        ));
  }
}
