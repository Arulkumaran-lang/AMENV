import 'package:flutter/material.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090A0F),
      body: Column(
        children: [
          // AV-Search Bar for Friends
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search or start encrypted chat...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                prefixIcon:
                    const Icon(Icons.search_rounded, color: Colors.cyanAccent),
                filled: true,
                fillColor: const Color(0xFF141622),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Active Friends Row
          SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildActiveUser('Apsheba 🐬', Colors.pinkAccent),
                _buildActiveUser('Madhan', Colors.blueAccent),
                _buildActiveUser('Pondymachi', Colors.amberAccent),
              ],
            ),
          ),
          const Divider(color: Colors.white10),

          // Direct Encrypted Chat List
          Expanded(
            child: ListView(
              children: [
                _buildChatItem('Apsheba 🐬', 'Hey! Checked the new space? ✨',
                    '10:42 AM', 2),
                _buildChatItem(
                    'Madhan', 'Voice message (0:13)', 'Yesterday', 0),
                _buildChatItem('Pondymachi', 'Sent a video link', 'Mon', 0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveUser(String name, Color borderAccent) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: borderAccent, width: 2),
                ),
                child: const CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
              const CircleAvatar(
                radius: 6,
                backgroundColor: Colors.greenAccent,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(name,
              style: const TextStyle(color: Colors.white70, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildChatItem(String name, String lastMsg, String time, int unread) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 24,
        backgroundColor: Colors.white12,
        child: Icon(Icons.person, color: Colors.white),
      ),
      title: Text(name,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold)),
      subtitle: Text(lastMsg,
          style: const TextStyle(color: Colors.white54, fontSize: 12)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(time,
              style: const TextStyle(color: Colors.white38, fontSize: 11)),
          if (unread > 0) ...[
            const SizedBox(height: 4),
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.cyanAccent,
              child: Text(
                '$unread',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
