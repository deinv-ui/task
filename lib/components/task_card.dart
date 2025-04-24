import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onCheckboxTap;

  const TaskCard({
    super.key,
    required this.title,
    required this.subtitle,

    this.onCheckboxTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subtitle, style: const TextStyle(color: Colors.black87)),
              const SizedBox(height: 8),
              Chip(
                label: Text(
                  subtitle,
                  style: const TextStyle(color: Colors.pink),
                ),
                backgroundColor: const Color.fromARGB(255, 255, 205, 223),
              ),
            ],
          ),
          trailing: GestureDetector(
            onTap: onCheckboxTap,
            child: const Icon(Icons.check_box_outline_blank, size: 20),
          ),
        ),
      ),
    );
  }
}
