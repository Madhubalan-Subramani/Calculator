import 'package:calculator/src/common_widgets/custom_appbar.dart';
import 'package:calculator/src/constants/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/image_string.dart';
import '../../../constants/sizes.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppbar(
          title: "Choose yours",
          showBackButton: true,
          showMenu: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryLayout(
                      imageName: basicCalIconImage,
                      categoryName: 'Basic',
                      onTap: () {
                        Get.toNamed('/basicCal');
                      },
                      visible: true,
                    ),
                    CategoryLayout(
                      imageName: ageIconImage,
                      categoryName: 'Age',
                      onTap: () {
                        Get.toNamed('/ageCal');
                      },
                      visible: true,
                    ),
                    CategoryLayout(
                      imageName: dateIconImage,
                      categoryName: 'Date',
                      onTap: () {
                        Get.toNamed('/differenceCal');
                      },
                      visible: true,
                    ),
                  ],
                ),
                const SizedBox(height: lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryLayout(
                      imageName: areaIconImage,
                      categoryName: 'Area',
                      onTap: () {},
                    ),
                    CategoryLayout(
                      imageName: bmiIconImage,
                      categoryName: 'BMI',
                      onTap: () {},
                    ),
                    CategoryLayout(
                      imageName: currencyIconImage,
                      categoryName: 'Currency',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryLayout(
                      imageName: dataIconImage,
                      categoryName: 'Data',
                      onTap: () {},
                    ),
                    CategoryLayout(
                      imageName: discountIconImage,
                      categoryName: 'Discount',
                      onTap: () {},
                    ),
                    CategoryLayout(
                      imageName: gstIconImage,
                      categoryName: 'GST',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryLayout(
                      imageName: investmentIconImage,
                      categoryName: 'Investment',
                      onTap: () {},
                    ),
                    CategoryLayout(
                      imageName: lengthIconImage,
                      categoryName: 'Length',
                      onTap: () {},
                    ),
                    CategoryLayout(
                      imageName: loanIconImage,
                      categoryName: 'Loan',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryLayout(
                      imageName: massIconImage,
                      categoryName: 'Mass',
                      onTap: () {},
                    ),
                    CategoryLayout(
                      imageName: numericSystemIconImage,
                      categoryName: 'Numeral',
                      onTap: () {},
                    ),
                    CategoryLayout(
                      imageName: scientificCalIconImage,
                      categoryName: 'Scientific',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryLayout(
                      imageName: speedIconImage,
                      categoryName: 'Speed',
                      onTap: () {},
                    ),
                    CategoryLayout(
                      imageName: temperatureIconImage,
                      categoryName: 'Temperature',
                      onTap: () {},
                    ),
                    CategoryLayout(
                      imageName: timeIconImage,
                      categoryName: 'Time',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryLayout(
                      imageName: volumeIconImage,
                      categoryName: 'Volume',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryLayout extends StatefulWidget {
  final String imageName;
  final String categoryName;
  final VoidCallback onTap;
  final bool visible;

  const CategoryLayout({
    required this.imageName,
    required this.categoryName,
    required this.onTap,
    this.visible = false,
    super.key,
  });

  @override
  CategoryLayoutState createState() => CategoryLayoutState();
}

class CategoryLayoutState extends State<CategoryLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() async {
    if (!widget.visible) {
      _showPopupMessage();
    } else {
      await _animationController.forward().then((_) {
        _animationController.reverse();
        widget.onTap();
      });
    }
  }

  void _showPopupMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Notice',
            style: bodyText18B,
          ),
          content: Text(
            'Working under process',
            style: bodyText12B,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: bodyText12B,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Opacity(
          opacity: widget.visible ? 1.0 : 0.1,
          child: Container(
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset(
                      widget.imageName,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    widget.categoryName,
                    style: bodyText12B,
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
