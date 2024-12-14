import 'package:flutter/material.dart';

class SoicalMediaBotton extends StatelessWidget {
  SoicalMediaBotton({
    super.key,
    required this.iconName,
    required this.onpress,
  });
  final String iconName;
  final VoidCallback onpress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        child: Center(
          child: Image.asset(
            iconName,
            width: 70.0,
            height: 70.0,
          ),
        ),
      ),
    );
  }
}
