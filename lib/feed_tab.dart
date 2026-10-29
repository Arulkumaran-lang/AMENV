import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FeedTab extends StatelessWidget {
  final User? currentUser;

  const FeedTab({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    final emailInitial =
        currentUser?.email?.substring(0, 1).toUpperCase() ?? 'U';

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Instagram Style Stories Tray
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: SizedBox(
              height: 95,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  // Add Story Button & User DP
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2.5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.cyanAccent,
                                    Colors.purpleAccent
                                  ],
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 28,
                                backgroundColor: const Color(0xFF131722),
                                child: Text(
                                  emailInitial,
                                  style: const TextStyle(
                                    color: Colors.cyanAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 2,
                              right: 2,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.cyanAccent,
                                child: Icon(Icons.add,
                                    size: 14, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Your Story',
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.white10, height: 1),
          const SizedBox(height: 60),

          // Clean AMENV Feed View State
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.cyanAccent.withOpacity(0.08),
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: Colors.cyanAccent.withOpacity(0.2)),
                    ),
                    child: const Icon(
                      Icons.dynamic_feed_rounded,
                      size: 50,
                      color: Colors.cyanAccent,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Your AMENV Feed is Clean',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Real media from connected users will stream directly here when published.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white38, fontSize: 13, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 80),
          const Center(
            child: Text(
              'Developed by AV-FAMILY',
              style: TextStyle(
                color: Colors.white24,
                fontSize: 11,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
