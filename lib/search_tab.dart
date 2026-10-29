import 'package:flutter/material.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search AMENV Users, Tags or Media...',
              hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
              prefixIcon: const Icon(Icons.search, color: Colors.cyanAccent),
              filled: true,
              fillColor: const Color(0xFF131722),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Explore Categories',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildChip('#AV_FAMILY'),
              _buildChip('#AMENV_Tech'),
              _buildChip('#PrivateStreams'),
              _buildChip('#WatchTogether'),
            ],
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

  Widget _buildChip(String label) {
    return Chip(
      backgroundColor: const Color(0xFF131722),
      side: const BorderSide(color: Colors.white10),
      label: Text(label,
          style: const TextStyle(color: Colors.cyanAccent, fontSize: 12)),
    );
  }
}
