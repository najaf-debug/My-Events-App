// ignore_for_file: curly_braces_in_flow_control_pictures, use_key_in_widget_constructors, library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_events_app/practice/repository/event_repository.dart';

class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final repo = EventRepository();
  Future _eventsFuture = Future.value([]);

  @override
  void initState() {
    super.initState();
    _eventsFuture = repo.fetchEvents();
  }

  // The dark background from the 'Volcanic Ember' palette
  static const Color kDarkBackground = Color(0xFF1F1A1A);
  // The bright accent color (coral/red) for highlights
  static const Color kAccentColor = Color(0xFFFF6B6B);
  // Standard white for text and icons on the dark background
  static const Color kWhite = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- 1. APPLIED DARK BACKGROUND ---
      backgroundColor: kDarkBackground,

      // --- 2. BOLD APP BAR STYLING ---
      appBar: AppBar(
        // Match the AppBar background to the Scaffold background
        backgroundColor: kDarkBackground,
        elevation: 0,
        toolbarHeight: 100, // Make it taller for the bold title look
        title: const Padding(
          padding: EdgeInsets.only(top: 20.0), // Give some top padding
          child: Text(
            "Events",
            style: TextStyle(
              fontSize: 25, // Much larger font size
              fontWeight: FontWeight.w900, // Extra bold
              color: kWhite, // White text on dark background
            ),
          ),
        ),
      ),

      // --- 3. FLOATING ACTION BUTTON WITH ACCENT COLOR ---
      floatingActionButton: FloatingActionButton(
        backgroundColor: kAccentColor, // Use the vibrant accent color
        child: const Icon(Icons.add, color: kWhite),
        onPressed: () async {
          await repo.addEvent("New Event", "Mock Event Description");
          setState(() {
            _eventsFuture = repo.fetchEvents();
          });
        },
      ),

      body: FutureBuilder(
        future: _eventsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // Ensure CircularProgressIndicator is visible on dark background
            return const Center(
              child: CircularProgressIndicator(color: kAccentColor),
            );
          }

          final events = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: events.length,
            itemBuilder: (_, i) {
              final event = events[i];
              return _EventCard(
                title: event.title,
                onDelete: () async {
                  await repo.deleteEvent(event.id);
                  setState(() {
                    _eventsFuture = repo.fetchEvents();
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}

// --- Event Card Widget (Aesthetic Improvements) ---
class _EventCard extends StatelessWidget {
  final String title;
  final VoidCallback onDelete;

  const _EventCard({required this.title, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        // Placeholder image used for now
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          // --- Gradient: More pronounced from bottom-left for a dramatic look ---
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.black.withOpacity(0.8), // Stronger opacity at the bottom
              Colors.transparent,
            ],
            stops: const [0.0, 0.7], // Focus the dark part lower down
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Align Delete Button to Top Right Corner ---
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(
                    0.4,
                  ), // Darker background for icon
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white, size: 20),
                  onPressed: onDelete,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ),
            const Spacer(),
            // --- Tag Text Style Improvement ---
            const Text(
              "Art Gallery",
              style: TextStyle(
                color: Color(0xFFCCCCCC), // Lighter gray for subtle contrast
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            // --- Title Text Style Improvement (Bold and Big) ---
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26, // Larger text
                fontWeight: FontWeight.w800, // Very bold
              ),
            ),
            const SizedBox(height: 6),
            // --- Subtitle Text Style Improvement ---
            const Text(
              "Voted 1,200 Participants",
              style: TextStyle(
                color: Color(0xFFAAAAAA), // Medium gray
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
