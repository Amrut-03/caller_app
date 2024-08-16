import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SlidingText extends StatefulWidget {
  final String name;
  final String time;
  const SlidingText({super.key, required this.name, required this.time});

  @override
  // ignore: library_private_types_in_public_api
  _SlidingTextState createState() => _SlidingTextState();
}

class _SlidingTextState extends State<SlidingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  bool _shouldAnimate = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animation = Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: Offset(-0.8, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linearToEaseOut,
    ));

    Future.delayed(const Duration(seconds: 3), () {
      _animation;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        _checkTextOverflow();
      });
    });
  }

  void _checkTextOverflow() {
    final textSize = _measureTextSize(widget.name);
    setState(() {
      _shouldAnimate = textSize > 200;
    });

    if (_shouldAnimate) {
      _animationController.forward();
      _animationController.repeat(reverse: false);
    }
  }

  double _measureTextSize(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: const Color(0xFFFFD700),
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size.width;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 195,
          // height: 30,
          child: ClipRect(
            child: _shouldAnimate
                ? SlideTransition(
                    position: _animation,
                    child: FractionallySizedBox(
                      widthFactor: 1.5, // Allow more width for animation
                      child: Text(
                        widget.name,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFFD700),
                        ),
                      ),
                    ),
                  )
                : Text(
                    widget.name,
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFFD700),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          widget.time,
          style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(
                0xFFFFFFFF,
              )),
        ),
      ],
    );
  }
}
