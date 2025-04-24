import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;
  final bool isLoading;

  const CustomButton({
    super.key,
    this.text,
    this.child,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        minimumSize: const Size(double.infinity, 50),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
      child: child ??
          (text != null
              ? Text(
                  text!,
                  style: const TextStyle(fontSize: 16.0),
                )
              : const SizedBox.shrink()), // In case there's no text or child
    );
  }
}
