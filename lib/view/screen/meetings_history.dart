import 'package:flutter/material.dart';

class MeetingsDetails extends StatelessWidget {
  const MeetingsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meetings Details'),
      ),
      body: const Center(
        child: Text('Meetings Details'),
      ),
    );
  }
}
