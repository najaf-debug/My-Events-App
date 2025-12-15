class Event {
  final String id;
  String title;
  String description;
  Event({required this.id, required this.title, required this.description});
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "description": description};
  }
}
