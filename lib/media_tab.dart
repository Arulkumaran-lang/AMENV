import 'package:flutter/material.dart';

class MediaTab extends StatelessWidget {
  const MediaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090A0F),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              // Media Player Container (Video/YouTube Space)
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        index == 0
                            ? Icons.play_circle_fill_rounded
                            : Icons.ondemand_video_rounded,
                        size: 80,
                        color: Colors.cyanAccent.withOpacity(0.6),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'AMENV Media Video #${index + 1}',
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),

              // Side Interaction Buttons (AMENV Unique Style)
              Positioned(
                right: 16,
                bottom: 100,
                child: Column(
                  children: [
                    _buildActionButton(Icons.favorite_border_rounded, '12.5k',
                        Colors.redAccent),
                    const SizedBox(height: 20),
                    _buildActionButton(Icons.chat_bubble_outline_rounded,
                        '1.2k', Colors.white),
                    const SizedBox(height: 20),
                    _buildActionButton(
                        Icons.send_rounded, 'Share', Colors.cyanAccent),
                    const SizedBox(height: 20),
                    _buildActionButton(Icons.bookmark_border_rounded, 'Save',
                        Colors.amberAccent),
                  ],
                ),
              ),

              // Bottom Caption & User Info
              Positioned(
                left: 16,
                bottom: 30,
                right: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.cyanAccent,
                          child:
                              Icon(Icons.person, color: Colors.black, size: 20),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'user_creative_${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.cyanAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Colors.cyanAccent, width: 0.8),
                          ),
                          child: const Text(
                            'Follow',
                            style: TextStyle(
                                color: Colors.cyanAccent, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Unique Media Experience on AMENV! 🔥 #Encrypted #Media',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF141622).withOpacity(0.8),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 26),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 11),
        ),
      ],
    );
  }
}
