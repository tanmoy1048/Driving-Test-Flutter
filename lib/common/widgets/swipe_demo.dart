import 'package:flutter/material.dart';

Widget firstTimeSwipeDemo({
  required BuildContext context,
  required void Function() onTap,
  required Animation<double> animation,
  required String hint,
}) {
  return Positioned.fill(
    left: 0,
    right: 0,
    top: 15,
    bottom: 0,
    child: GestureDetector(
      onTap: onTap,
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity == null) {
          return;
        } else if (details.primaryVelocity! > 0) {
          onTap();
        } else if (details.primaryVelocity! < 0) {
          onTap();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(animation.value * 100 - 50, 0.0),
                    child: Image.asset(
                      "assets/images/swipe.png",
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),
            Text(
              hint,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                    color: Colors.yellow,
                  ),
            ),
          ],
        ),
      ),
    ),
  );
}
