import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<Widget>? icons;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.icons,
  });

  @override
  Widget build(BuildContext context) {
    // Default icons if no custom icons provided
    final List<Widget> defaultIcons = [
      const Icon(Icons.home),
      const Icon(Icons.chat_bubble_outline),
      const _AnimatedAddButton(),
      const Icon(Icons.notifications_none_outlined),
      const Icon(Icons.settings_outlined),
    ];

    final List<Widget> finalIcons = icons ?? defaultIcons;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.pink,  // Color for selected items
      unselectedItemColor: Colors.black,  // Color for unselected items
      items: List.generate(5, (index) {
        final Widget icon = index == 2
            ? finalIcons[index] // For the add button, use custom widget
            : IconTheme(
                data: IconThemeData(
                  color: currentIndex == index ? Colors.pink : Colors.black,  // Change color based on selection
                ),
                child: finalIcons[index],
              );
        return BottomNavigationBarItem(icon: icon, label: '');
      }),
    );
  }
}

class _AnimatedAddButton extends StatefulWidget {
  const _AnimatedAddButton({super.key});

  @override
  State<_AnimatedAddButton> createState() => _AnimatedAddButtonState();
}

class _AnimatedAddButtonState extends State<_AnimatedAddButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _scale = Tween(begin: 0.9, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Container(
        width: 56,
        height: 56,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.pink,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.pinkAccent,
              blurRadius: 8,
              spreadRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: IconTheme(
          data: IconThemeData(
            color: Colors.white, // Always white for the add button icon
          ),
          child: const Icon(
            Icons.add,
            size: 32,
          ),
        ),
      ),
    );
  }
}
