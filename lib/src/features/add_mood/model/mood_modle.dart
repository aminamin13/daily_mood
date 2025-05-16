import 'package:flutter/material.dart';

class MoodEntry {
  final int? id;
  final DateTime date;
  final String mood;
  final String emoji;
  final String note;
  final Color color; // ✅ use Color, not Colors

  MoodEntry({
    this.id,
    required this.date,
    required this.mood,
    required this.emoji,
    required this.note,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'mood': mood,
      'emoji': emoji,
      'note': note,
      'color': color.value, // ✅ store color as int
    };
  }

  factory MoodEntry.fromMap(Map<String, dynamic> map) {
    return MoodEntry(
      id: map['id'],
      date: DateTime.parse(map['date']),
      mood: map['mood'],
      emoji: map['emoji'],
      note: map['note'],
      color: Color(map['color']), // ✅ restore color from int
    );
  }
}
