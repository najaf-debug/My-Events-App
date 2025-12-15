import 'dart:async';

class EventApi {
  final List<Map<String, dynamic>> _events = [];
  Future<List<Map<String, dynamic>>> getEvents() async {
    await Future.delayed(Duration(milliseconds: 800));
    return _events;
  }

  Future<Map<String, dynamic>> createEvent(Map<String, dynamic> event) async {
    await Future.delayed(Duration(milliseconds: 800));
    _events.add(event);
    return event;
  }

  Future<Map<String, dynamic>> updateEvent(
    String id,
    Map<String, dynamic> updatedEvent,
  ) async {
    await Future.delayed(Duration(milliseconds: 800));
    final index = _events.indexWhere((e) => e['id'] == id);
    _events[index] = updatedEvent;
    return updatedEvent;
  }

  Future<void> deleteEvent(String id) async {
    await Future.delayed(Duration(milliseconds: 800));
    _events.removeWhere((e) => e['id'] == id);
  }
}
