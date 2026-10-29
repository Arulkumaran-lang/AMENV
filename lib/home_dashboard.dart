import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  int _selectedIndex = 0;
  final User? currentUser = Supabase.instance.client.auth.currentUser;

  Future<void> _signOut() async {
    await Supabase.instance.client.auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090A0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0E15),
        elevation: 1,
        titleSpacing: 16,
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 38,
              width: 38,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.cyanAccent.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.shield_rounded,
                      color: Colors.cyanAccent, size: 24),
                );
              },
            ),
            const SizedBox(width: 12),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.cyanAccent, Colors.purpleAccent],
              ).createShader(bounds),
              child: const Text(
                'AMENV Feed',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded,
                color: Colors.white, size: 26),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: const Color(0xFF12151E),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => Container(
                  padding: const EdgeInsets.all(24),
                  height: 220,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Notifications',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          'No new notifications right now.',
                          style: TextStyle(color: Colors.white54, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.power_settings_new_rounded,
                color: Colors.redAccent, size: 24),
            onPressed: _signOut,
            tooltip: 'Logout',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildCleanFeedView(),
          _buildMediaView(),
          _buildEncryptedChatView(),
          _buildSearchView(),
          _buildUserProfileView(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0D0E15),
          border: Border(top: BorderSide(color: Colors.white10, width: 0.5)),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF0D0E15),
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.cyanAccent,
          unselectedItemColor: Colors.white38,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_max_rounded, size: 26), label: 'Feed'),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_library_outlined, size: 26),
                label: 'Media'),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline_rounded, size: 24),
                label: 'Messages'),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded, size: 26), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded, size: 26),
                label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildCleanFeedView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF131722),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white12),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.cyanAccent.withOpacity(0.2),
                  child: Text(
                    currentUser?.email?.substring(0, 1).toUpperCase() ?? 'U',
                    style: const TextStyle(
                        color: Colors.cyanAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Logged in as',
                          style:
                              TextStyle(color: Colors.white38, fontSize: 12)),
                      Text(
                        currentUser?.email ?? 'User',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.dashboard_customize_outlined,
                    size: 56, color: Colors.white12),
                SizedBox(height: 16),
                Text(
                  'Your Feed is Clean',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    'No fake users or dummy content. Photos and videos published by connected users will appear right here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white38, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
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

  Widget _buildMediaView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.play_circle_outline, size: 56, color: Colors.cyanAccent),
          SizedBox(height: 16),
          Text('AMENV Media Hub',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Encrypted media streaming platform.',
              style: TextStyle(color: Colors.white54, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildEncryptedChatView() {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline_rounded,
                size: 52, color: Colors.cyanAccent),
            SizedBox(height: 16),
            Text('End-to-End Encrypted Space',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Your confidential interactions are completely protected.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white38, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search AMENV users, media...',
              hintStyle: const TextStyle(color: Colors.white38),
              prefixIcon: const Icon(Icons.search, color: Colors.cyanAccent),
              filled: true,
              fillColor: const Color(0xFF131722),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('Search platform contents securely',
                  style: TextStyle(color: Colors.white38)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUserProfileView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 42,
            backgroundColor: Colors.cyanAccent.withOpacity(0.2),
            child: Text(
              currentUser?.email?.substring(0, 1).toUpperCase() ?? 'U',
              style: const TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            currentUser?.email ?? 'User',
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.cyanAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('AMENV Verified Profile',
                style: TextStyle(color: Colors.cyanAccent, fontSize: 12)),
          ),
          const SizedBox(height: 32),
          ListTile(
            tileColor: const Color(0xFF131722),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: const Icon(Icons.security, color: Colors.cyanAccent),
            title: const Text('Privacy & Security',
                style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.chevron_right, color: Colors.white38),
            onTap: () {},
          ),
          const SizedBox(height: 12),
          ListTile(
            tileColor: const Color(0xFF131722),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('Sign Out',
                style: TextStyle(color: Colors.redAccent)),
            onTap: _signOut,
          ),
        ],
      ),
    );
  }
}
