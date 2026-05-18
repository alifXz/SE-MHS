import 'package:flutter/material.dart';

class EventData {
  final String title;
  final String location;
  final String time;
  final String date;
  final String imageUrl;
  final String type;
  final IconData categoryIcon;    
  final Color badgeColor;         

  EventData({
    required this.title,
    required this.location,
    required this.time,
    required this.date,
    required this.imageUrl,
    required this.type,
    this.categoryIcon = Icons.event,           
    this.badgeColor = const Color(0xFFD81B60), 
  });
}