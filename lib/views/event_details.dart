// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'home_screen.dart'; // for Event model

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: _glassIcon(
          context: context,
          icon: Icons.arrow_back,
          onTap: () => Navigator.pop(context),
        ),
        actions: [
          _glassIcon(
            context: context,
            icon: Icons.bookmark_border,
            onTap: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          /// HERO IMAGE
          SizedBox(
            height: 360,
            width: double.infinity,
            child: Hero(
              tag: event.id,
              child: Image.network(event.image, fit: BoxFit.cover),
            ),
          ),

          /// CONTENT
          DraggableScrollableSheet(
            initialChildSize: 0.63,
            minChildSize: 0.63,
            maxChildSize: 0.9,
            builder: (_, controller) {
              return Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: ListView(
                  controller: controller,
                  children: [
                    _buildTitle(),
                    const SizedBox(height: 16),
                    _buildInfoRow(),
                    const SizedBox(height: 24),
                    _buildSectionTitle("About Event"),
                    const SizedBox(height: 8),
                    _buildDescription(),
                    const SizedBox(height: 24),
                    _buildSectionTitle("Location"),
                    const SizedBox(height: 8),
                    _buildLocationCard(),
                    const SizedBox(height: 100),
                  ],
                ),
              );
            },
          ),

          /// JOIN BUTTON
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: _buildJoinButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          "by ${event.organizer}",
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildInfoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _infoChip(Icons.calendar_today, "${event.date.day} DEC"),
        _infoChip(Icons.access_time, event.time),
        _infoChip(Icons.people, "${event.participants}+"),
      ],
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [Icon(icon, size: 16), const SizedBox(width: 6), Text(label)],
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      "Join us for an unforgettable experience where creativity, technology, "
      "and innovation come together. Meet like-minded people, learn from experts, "
      "and immerse yourself in an inspiring atmosphere.",
      style: TextStyle(color: Colors.grey[700], height: 1.6),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined),
          const SizedBox(width: 10),
          Expanded(child: Text(event.location)),
        ],
      ),
    );
  }

  // FIXED: Added BuildContext parameter
  Widget _buildJoinButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add registration logic here
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registered for event successfully!"),
            backgroundColor: Colors.green,
          ),
        );
      },
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF3A7FD8), Color(0xFF6FA9FF)],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            "Join Event",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // FIXED: Added BuildContext parameter
  Widget _glassIcon({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 40,
            height: 40,
            color: Colors.white.withOpacity(0.3),
            child: Icon(icon, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
