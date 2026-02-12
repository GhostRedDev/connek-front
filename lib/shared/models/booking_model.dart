import 'package:flutter/material.dart';

enum BookingStatus {
  pending,
  confirmed,
  in_progress,
  completed,
  cancelled;

  String get label {
    switch (this) {
      case BookingStatus.pending:
        return 'Pendiente';
      case BookingStatus.confirmed:
        return 'Confirmada';
      case BookingStatus.in_progress:
        return 'En Progreso';
      case BookingStatus.completed:
        return 'Completada';
      case BookingStatus.cancelled:
        return 'Cancelada';
    }
  }

  Color get color {
    switch (this) {
      case BookingStatus.pending:
        return Colors.orange;
      case BookingStatus.confirmed:
        return const Color(0xFFF9AB00);
      case BookingStatus.in_progress:
        return const Color(0xFF34A853); // Greenish
      case BookingStatus.completed:
        return const Color(0xFF4285F4);
      case BookingStatus.cancelled:
        return const Color(0xFFEA4335);
    }
  }
}

class BookingModel {
  final String id;
  final String title;
  final String type; // 'Cita', 'Llamada'
  final BookingStatus status;
  final DateTime date;
  final String timeRange; // e.g. "10:00 • 30 min"
  final String? location;
  final double price;

  // Participants
  final BookingParticipant client;
  final BookingParticipant agent;
  final List<BookingParticipant> team; // For team assignments

  // Extra
  final String serviceName;
  final String serviceImage;

  // Monitoring
  final double progress; // 0.0 to 1.0
  final int qualityScore; // 0 to 5, or similar
  final List<BookingLog> logs;

  // Custom Form Answers
  final Map<String, dynamic>? customFormAnswers;

  const BookingModel({
    required this.id,
    required this.title,
    required this.type,
    required this.status,
    required this.date,
    required this.timeRange,
    this.location,
    required this.price,
    required this.client,
    required this.agent,
    this.team = const [],
    required this.serviceName,
    required this.serviceImage,
    this.progress = 0.0,
    this.qualityScore = 0,
    this.logs = const [],
    this.customFormAnswers,
  });
}

class BookingLog {
  final DateTime timestamp;
  final String message;
  final String stage; // e.g. "Started", "Arrived"

  const BookingLog({
    required this.timestamp,
    required this.message,
    required this.stage,
  });
}

class BookingParticipant {
  final String id;
  final String name;
  final String role;
  final String image;
  final String? phone;

  const BookingParticipant({
    required this.id,
    required this.name,
    required this.role,
    required this.image,
    this.phone,
  });
}
