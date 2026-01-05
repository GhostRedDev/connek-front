// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!


import 'package:flutter_swipe_button/flutter_swipe_button.dart';

class SwipeToPayButton extends StatefulWidget {
  const SwipeToPayButton({
    super.key,
    this.width,
    this.height,
    this.onSwipe,
  });

  final double? width;
  final double? height;
  final Future Function()? onSwipe;

  @override
  State<SwipeToPayButton> createState() => _SwipeToPayButtonState();
}

class _SwipeToPayButtonState extends State<SwipeToPayButton> {
  bool _swipeCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 360,
      height: widget.height ?? 64,
      decoration: BoxDecoration(
        color: const Color(0xFFEEF3FD),
        borderRadius: BorderRadius.circular(40),
      ),
      padding: const EdgeInsets.all(6),
      child: SwipeButton.expand(
        activeThumbColor: const Color(0xFF83B4FF),
        activeTrackColor: const Color(0xFFEEF3FD),
        thumb: Container(
          width: 60,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF83B4FF),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Center(
            child: Icon(
              _swipeCompleted
                  ? Icons.keyboard_double_arrow_right
                  : Icons.arrow_forward_ios,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(40),
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [
                Color(0xFF83B4FF),
                Color(0xFF4F87C9),
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcIn,
          child: const Center(
            child: Text(
              "Proceed to payment",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
        onSwipe: () async {
          setState(() {
            _swipeCompleted = true;
          });

          // Actualiza el AppState
          FFAppState().update(() {
            FFAppState().swipeConfirmed = true;
          });

          // Llama al callback si está definido
          if (widget.onSwipe != null) {
            await widget.onSwipe!();
          }
        },
      ),
    );
  }
}
