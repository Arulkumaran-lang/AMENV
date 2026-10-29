import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_screen.dart';
import 'profile_setup_screen.dart';
import 'home_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://tmdkurcqctcsrjypsxeb.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRtZGt1cmNxY3Rjc3JqeXBzeGViIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTI5MzUzNTAsImV4cCI6MjEwODUxMTM1MH0.zF2hY3EM65gfk5PCLGQCdGPYY5sXbMbIc15vyTgnuLM',
  );

  runApp(const AmenvApp());
}

class AmenvApp extends StatelessWidget {
  const AmenvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AMENV',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF090A0F),
        primaryColor: Colors.cyanAccent,
      ),
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = Supabase.instance.client.auth.currentSession;
        if (session == null) {
          return const LoginScreen();
        }

        final user = session.user;
        final profileCompleted =
            user.userMetadata?['profile_completed'] == true;

        if (!profileCompleted) {
          return const ProfileSetupScreen();
        }

        return const HomeDashboard();
      },
    );
  }
}
