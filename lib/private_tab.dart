import 'package:flutter/material.dart';

class PrivateTab extends StatelessWidget {
  const PrivateTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.lock_outline, color: Colors.cyanAccent, size: 24),
              SizedBox(width: 10),
              Text(
                'End-to-End Encrypted Space',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Your confidential interactions, chats, and vault media are completely protected.',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(height: 30),
          ListTile(
            tileColor: const Color(0xFF131722),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: const Icon(Icons.security, color: Colors.cyanAccent),
            title: const Text('Encrypted Vault Status',
                style: TextStyle(color: Colors.white)),
            subtitle: const Text('Active & Protected by AMENV Encryption',
                style: TextStyle(color: Colors.cyanAccent, fontSize: 11)),
            trailing: const Icon(Icons.check_circle,
                color: Colors.cyanAccent, size: 20),
          ),
          const SizedBox(height: 14),
          ListTile(
            tileColor: const Color(0xFF131722),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: const Icon(Icons.chat_bubble_outline,
                color: Colors.purpleAccent),
            title: const Text('Private Peer Messaging',
                style: TextStyle(color: Colors.white)),
            subtitle: const Text('Zero-Trace Direct Connection',
                style: TextStyle(color: Colors.white38, fontSize: 11)),
            trailing: const Icon(Icons.chevron_right, color: Colors.white38),
          ),
          const SizedBox(height: 60),
          const Center(
            child: Text(
              'Developed by AV-FAMILY',
              style: TextStyle(
                  color: Colors.white24, fontSize: 11, letterSpacing: 2),
            ),
          ),
        ],
      ),
    );
  }
}
