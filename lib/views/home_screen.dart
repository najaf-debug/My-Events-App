// lib/views/home_screen.dart
// ignore_for_file: deprecated_member_use, unused_field

import 'package:flutter/material.dart';
import 'package:my_events_app/views/event_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DateTime _selectedDate = DateTime.now();
  int _selectedCategory = 0;

  // Categories
  final List<String> _categories = [
    'All',
    'Art',
    'Music',
    'Tech',
    'Food',
    'Sports',
  ];

  // Sample events data (you'll replace with real data)
  final List<Event> _events = [
    Event(
      id: '1',
      title: 'Art Gallery Opening',
      organizer: 'Kevin Sephora',
      image:
          'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=400',
      date: DateTime(2024, 12, 21),
      time: '6:00 PM',
      participants: 1456,
      location: 'Museum of Modern Art',
      cardColor: const Color(0xFFE8F4FD),
    ),
    Event(
      id: '2',
      title: 'Tech Conference 2024',
      organizer: 'Tech Leaders Inc.',
      image:
          'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w-400',
      date: DateTime(2024, 12, 22),
      time: '9:00 AM',
      participants: 2450,
      location: 'Convention Center',
      cardColor: const Color(0xFFF5E8FD),
    ),
    Event(
      id: '3',
      title: 'Music Festival',
      organizer: 'Live Music Co.',
      image:
          'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?w=400',
      date: DateTime(2024, 12, 23),
      time: '4:00 PM',
      participants: 5000,
      location: 'Central Park',
      cardColor: const Color(0xFFFDF1E8),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Bar with Date and Search
              _buildAppBar(),
              const SizedBox(height: 30),

              // Calendar Section
              _buildCalendarSection(),
              const SizedBox(height: 30),

              // Categories
              _buildCategories(),
              const SizedBox(height: 25),

              // Events List
              Expanded(child: _buildEventsList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Date Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MONDAY, DEC 21',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Events',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),

        // Search Icon
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.search, size: 22),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date Number
          Row(
            children: [
              Text(
                '21',
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3A7FD8),
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DEC',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '2024',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Calendar with days
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(7, (index) {
                final day = DateTime.now().add(Duration(days: index));
                final isToday = index == 0;

                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: isToday ? const Color(0xFF3A7FD8) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        _getDayAbbreviation(day.weekday),
                        style: TextStyle(
                          fontSize: 12,
                          color: isToday ? Colors.white : Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        day.day.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isToday ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedCategory == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(
                right: index == _categories.length - 1 ? 0 : 12,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF3A7FD8) : Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _categories[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEventsList() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 90),
      itemCount: _events.length,
      itemBuilder: (context, index) {
        final event = _events[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EventDetailsScreen(event: event),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: event.cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Image
                Container(
                  width: 80,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(event.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event.organizer,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.people_outline, size: 7),
                            const SizedBox(width: 4),
                            Text('${event.participants} Participants'),
                            const SizedBox(width: 7),
                            Icon(Icons.access_time, size: 8),
                            const SizedBox(width: 4),
                            Text(event.time),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, size: 14),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                event.location,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Date badge
                Container(
                  width: 50,
                  height: 100,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        event.date.day.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _getMonthAbbreviation(event.date.month),
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper Methods
  String _getDayAbbreviation(int weekday) {
    const days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    return days[weekday - 1];
  }

  String _getMonthAbbreviation(int month) {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    return months[month - 1];
  }
}

class Event {
  final String id;
  final String title;
  final String organizer;
  final String image;
  final DateTime date;
  final String time;
  final int participants;
  final String location;
  final Color cardColor;

  Event({
    required this.id,
    required this.title,
    required this.organizer,
    required this.image,
    required this.date,
    required this.time,
    required this.participants,
    required this.location,
    required this.cardColor,
  });
}
