import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback? onTapHandeler;
  const CustomButton({
    super.key,
    required this.buttonName,  this.onTapHandeler,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapHandeler,
      child: Container(
        
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: Text(buttonName)),
      ),
    );
  }
}
