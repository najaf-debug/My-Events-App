import '../mock_api/event_api.dart';
import '../models/event.dart';

class EventRepository {
  final EventApi api = EventApi();
  Future<List<Event>> fetchEvents() async {
    final data = await api.getEvents();
    return data.map((e) => Event.fromJson(e)).toList();
  }

  Future<Event> addEvent(String title, String desc) async {
    final event = Event(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: desc,
    );
    final data = await api.createEvent(event.toJson());
    return Event.fromJson(data);
  }

  Future<void> deleteEvent(String id) async {
    await api.deleteEvent(id);
  }
}
