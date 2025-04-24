class Task {
  final int id;
  final String name;
  final int year;
  final String color;
  final String pantoneValue;
  final String title;
  final String subtitle;

  Task({
    required this.id,
    required this.name,
    required this.year,
    required this.color,
    required this.pantoneValue,
    required this.title,
    required this.subtitle
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      year: json['year'],
      color: json['color'],
      pantoneValue: json['pantone_value'],
      title: json['title'],
      subtitle: json['subtitle'],
    );
  }
}
