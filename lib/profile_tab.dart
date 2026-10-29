import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_dashboard.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  String? _errorMessage;
  String _selectedFont = 'Roboto';

  final List<String> _fontOptions = [
    'Roboto',
    'Montserrat',
    'Poppins',
    'Courier'
  ];

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        setState(() {
          _selectedImage = pickedFile;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Camera/Gallery Permission Error: $e')),
        );
      }
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF131722),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Profile Picture',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.cyanAccent),
              title: const Text('Take Photo (Camera)',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.photo_library, color: Colors.purpleAccent),
              title: const Text('Choose from Gallery',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveProfile() async {
    final username = _usernameController.text.trim();
    if (username.isEmpty) {
      setState(() => _errorMessage = 'Username is required');
      return;
    }

    if (RegExp(r'[$\s]').hasMatch(username)) {
      setState(() =>
          _errorMessage = 'Special characters like \$ or spaces not allowed');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user != null) {
        await Supabase.instance.client.auth.updateUser(
          UserAttributes(
            data: {
              'username': username,
              'bio': _bioController.text.trim(),
              'font': _selectedFont,
              'profile_completed': true,
            },
          ),
        );

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeDashboard()),
          );
        }
      }
    } catch (e) {
      setState(() => _errorMessage = 'Failed to update profile: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090A0F),
      appBar: AppBar(
        title: const Text('Complete AMENV Profile'),
        backgroundColor: const Color(0xFF0D0E15),
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _showImageSourceDialog,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 54,
                      backgroundColor: Colors.cyanAccent.withOpacity(0.15),
                      backgroundImage: _selectedImage != null
                          ? (kIsWeb
                              ? NetworkImage(_selectedImage!.path)
                              : FileImage(File(_selectedImage!.path))
                                  as ImageProvider)
                          : null,
                      child: _selectedImage == null
                          ? const Icon(Icons.person,
                              size: 54, color: Colors.cyanAccent)
                          : null,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.cyanAccent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt,
                          size: 18, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text('Tap DP to choose Camera or Gallery',
                  style: TextStyle(color: Colors.white54, fontSize: 12)),
              const SizedBox(height: 30),
              TextField(
                controller: _usernameController,
                style:
                    TextStyle(color: Colors.white, fontFamily: _selectedFont),
                decoration: InputDecoration(
                  labelText: 'Unique Username',
                  hintText: 'e.g. dtg_vijay23 (No \$ or spaces)',
                  hintStyle:
                      const TextStyle(color: Colors.white24, fontSize: 12),
                  labelStyle: const TextStyle(color: Colors.cyanAccent),
                  prefixIcon: const Icon(Icons.alternate_email,
                      color: Colors.cyanAccent),
                  filled: true,
                  fillColor: const Color(0xFF131722),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                  errorText: _errorMessage,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _bioController,
                style:
                    TextStyle(color: Colors.white, fontFamily: _selectedFont),
                decoration: InputDecoration(
                  labelText: 'Bio / Status',
                  labelStyle: const TextStyle(color: Colors.white54),
                  prefixIcon:
                      const Icon(Icons.info_outline, color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xFF131722),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Select Font Style: ',
                      style: TextStyle(color: Colors.white70)),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: _selectedFont,
                    dropdownColor: const Color(0xFF131722),
                    style: const TextStyle(
                        color: Colors.cyanAccent, fontWeight: FontWeight.bold),
                    items: _fontOptions.map((font) {
                      return DropdownMenuItem(value: font, child: Text(font));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedFont = val);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.black),
                        )
                      : const Text('Save & Enter AMENV',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
