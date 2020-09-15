import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {
  const Pixel({
    @required this.color,
    key,
    this.value = '',
  }) : super(key: key);

  final Color color;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
}
