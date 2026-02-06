import 'package:flutter/material.dart';

enum BookingStatus {
  pending,
  confirmed,
  completed,
  cancelled;

  String get label {
    switch (this) {
      case BookingStatus.pending:
        return 'Pendiente';
      case BookingStatus.confirmed:
        return 'Próxima'; // Changed to match design "Próxima"
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
        return const Color(0xFFF9AB00); // Yellow/Gold for "Próxima"
      case BookingStatus.completed:
        return const Color(0xFF4285F4); // Blue
      case BookingStatus.cancelled:
        return const Color(0xFFEA4335); // Red
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

  // Extra
  final String serviceName;
  final String serviceImage;

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
    required this.serviceName,
    required this.serviceImage,
  });
}

class BookingParticipant {
  final String id;
  final String name;
  final String role;
  final String image;

  const BookingParticipant({
    required this.id,
    required this.name,
    required this.role,
    required this.image,
  });
}
