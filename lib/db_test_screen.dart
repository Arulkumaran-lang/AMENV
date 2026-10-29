import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DbTestScreen extends StatefulWidget {
  const DbTestScreen({super.key});

  @override
  State<DbTestScreen> createState() => _DbTestScreenState();
}

class _DbTestScreenState extends State<DbTestScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  
  bool _isLoading = false;
  String _statusMessage = 'READY TO TEST SUPABASE CONNECTION';
  List<Map<String, dynamic>> _fetchedProfiles = [];

  // 1. DATA INSERT TEST
  Future<void> _testInsert() async {
    final username = _usernameController.text.trim();
    final pin = _pinController.text.trim();

    if (username.isEmpty || pin.length != 4) {
      setState(() {
        _statusMessage = '⚠️ Enter Username & 4-Digit PIN first!';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _statusMessage = 'Sending data to Supabase Database...';
    });

    try {
      final supabase = Supabase.instance.client;
      final testUserId = 'test_id_${DateTime.now().millisecondsSinceEpoch}';

      await supabase.from('profiles').insert({
        'id': testUserId,
        'username': username,
        'bio': 'Testing Live Supabase Connection 🐬',
        'avatar_url': '🐬',
        'private_pin': pin,
        'space_active': true,
        'updated_at': DateTime.now().toIso8601String(),
      });

      setState(() {
        _statusMessage = '✅ SUCCESS! Profile & PIN inserted into Database!';
      });
      _testFetch(); // Auto Refresh Table
    } catch (e) {
      setState(() {
        _statusMessage = '❌ Error Inserting: $e';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // 2. DATA FETCH TEST
  Future<void> _testFetch() async {
    setState(() => _isLoading = true);
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase.from('profiles').select().order('updated_at', ascending: false);

      setState(() {
        _fetchedProfiles = List<Map<String, dynamic>>.from(response);
        _statusMessage = '✅ Database Refreshed! Total Profiles: ${_fetchedProfiles.length}';
      });
    } catch (e) {
      setState(() {
        _statusMessage = '❌ Error Fetching: $e';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _testFetch(); // Fetch existing profiles on load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Text('SUPABASE LIVE TESTER 🐬', style: TextStyle(color: Color(0xFF00FFA3), fontSize: 16)),
        backgroundColor: const Color(0xFF141414),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // STATUS BOX
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF181818),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF00FFA3).withOpacity(0.4)),
                ),
                child: Text(
                  _statusMessage,
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 20),

              // TEST INPUT FORM
              TextField(
                controller: _usernameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Test Username (e.g. dtg_vijay)',
                  labelStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFF141414),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _pinController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                style: const TextStyle(color: Colors.white, letterSpacing: 5),
                decoration: InputDecoration(
                  labelText: 'Test 4-Digit Private PIN',
                  labelStyle: const TextStyle(color: Colors.grey, letterSpacing: 0),
                  filled: true,
                  fillColor: const Color(0xFF141414),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),

              const SizedBox(height: 10),

              // BUTTONS
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00FFA3)),
                      onPressed: _isLoading ? null : _testInsert,
                      child: const Text('SEND TO DB 🚀', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                      onPressed: _isLoading ? null : _testFetch,
                      child: const Text('FETCH DB 🔄', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Text('Live Profiles in Supabase:', style: TextStyle(color: Colors.grey, fontSize: 13)),
              const SizedBox(height: 10),

              // DATA LIST
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator(color: Color(0xFF00FFA3)))
                    : _fetchedProfiles.isEmpty
                        ? const Center(child: Text('No Profiles Found in Database', style: TextStyle(color: Colors.grey)))
                        : ListView.builder(
                            itemCount: _fetchedProfiles.length,
                            itemBuilder: (context, index) {
                              final profile = _fetchedProfiles[index];
                              return Card(
                                color: const Color(0xFF141414),
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: const Color(0xFF00FFA3).withOpacity(0.2),
                                    child: Text(profile['avatar_url'] ?? '🤖'),
                                  ),
                                  title: Text(profile['username'] ?? 'Unknown', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  subtitle: Text('Bio: ${profile['bio'] ?? ''}', style: const TextStyle(color: Colors.grey, fontSize: 11)),
                                  trailing: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.pinkAccent.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text('PIN: ${profile['private_pin'] ?? 'None'}', style: const TextStyle(color: Colors.pinkAccent, fontSize: 11, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}