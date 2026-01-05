import 'package:flutter/material.dart';

class ClientDashboardBooking extends StatelessWidget {
  const ClientDashboardBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings')),
      body: const Center(child: Text('Booking History')),
    );
  }
}
