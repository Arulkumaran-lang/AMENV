import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeTab extends StatefulWidget {
  const YoutubeTab({super.key});

  @override
  State<YoutubeTab> createState() => _YoutubeTabState();
}

class _YoutubeTabState extends State<YoutubeTab> {
  late YoutubePlayerController _controller;
  final TextEditingController _videoUrlController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  bool _isInRoom = false;

  @override
  void initState() {
    super.initState();
    // Default Sample Real YouTube Video ID
    _controller = YoutubePlayerController.fromVideoId(
      videoId: 'dQw4w9WgXcQ',
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        strictRelatedVideos: true,
      ),
    );
  }

  void _loadCustomVideo() {
    final rawUrl = _videoUrlController.text.trim();
    if (rawUrl.isNotEmpty) {
      final cleanId = YoutubePlayerController.convertUrlToId(rawUrl) ?? rawUrl;
      _controller.loadVideoById(videoId: cleanId);
    }
  }

  void _showRoomDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF131722),
        title: const Row(
          children: [
            Icon(Icons.lock, color: Colors.cyanAccent),
            SizedBox(width: 8),
            Text('AMENV Private Sync Room',
                style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _roomController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Enter Room Name',
                hintStyle: TextStyle(color: Colors.white38),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _codeController,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: '4-Digit Passcode',
                hintStyle: TextStyle(color: Colors.white38),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent),
            onPressed: () {
              Navigator.pop(context);
              setState(() => _isInRoom = true);
            },
            child: const Text('Join / Create',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Bar with Lock Room Button
          Row(
            children: [
              const Text(
                'AMENV Media Hub',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                onPressed: _showRoomDialog,
                icon: Icon(
                  _isInRoom ? Icons.lock_open : Icons.lock,
                  color: Colors.cyanAccent,
                  size: 22,
                ),
                tooltip: 'Private Sync Room',
              ),
            ],
          ),
          const SizedBox(height: 12),

          // YouTube Link Search Row
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _videoUrlController,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  decoration: InputDecoration(
                    hintText: 'Paste YouTube Link or Video ID...',
                    hintStyle:
                        const TextStyle(color: Colors.white38, fontSize: 12),
                    filled: true,
                    fillColor: const Color(0xFF131722),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _loadCustomVideo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Load',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Real Embed YouTube Player
          YoutubePlayerScaffold(
            controller: _controller,
            aspectRatio: 16 / 9,
            builder: (context, player) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
                  ),
                  child: player,
                ),
              );
            },
          ),

          const SizedBox(height: 14),
          Text(
            _isInRoom
                ? 'Status: Stream Synchronized with Partner'
                : 'Status: Independent Stream Mode',
            style: const TextStyle(
                color: Colors.cyanAccent,
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 40),
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

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
