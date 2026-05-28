import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/services/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://wmnssxsaxxqptiqbfrnw.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndtbnNzeHNheHhxcHRpcWJmcm53Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzk3MDkxMTUsImV4cCI6MjA5NTI4NTExNX0.HLLwFwTe0zRMU-JuMXcYcQxjDFJtB2_2jBi-HsDMgq4'
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kith & Kin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      // Use an AuthGate to decide the landing page dynamically
      home: const AuthGate(),
    );
  }
}
