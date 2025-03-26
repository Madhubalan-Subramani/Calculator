import 'package:flutter/material.dart';
import '../constants/font_theme.dart';

class CircleButton extends StatefulWidget {
  const CircleButton({
    super.key,
    this.bgColor = Colors.transparent,
    this.text,
    this.icon,
    this.textStyle,
    this.iconSize = 24.0,
    this.padding = const EdgeInsets.all(18),
    this.onTap,
  }) : assert(text != null || icon != null,
            'Either text or icon must be provided, but not both.');

  final Color bgColor;
  final String? text;
  final Widget? icon;
  final TextStyle? textStyle;
  final double iconSize;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  CircleButtonState createState() => CircleButtonState();
}

class CircleButtonState extends State<CircleButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.8;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: (details) {
          _onTapUp(details);
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        onTapCancel: () {
          setState(() {
            _scale = 1.0;
          });
        },
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 100),
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: widget.bgColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: widget.text != null
                  ? Text(
                      widget.text!,
                      style: widget.textStyle ?? bodyText20W,
                    )
                  : widget.icon != null
                      ? IconTheme(
                          data: IconThemeData(size: widget.iconSize),
                          child: widget.icon!,
                        )
                      : null,
            ),
          ),
        ),
      ),
    );
  }
}
