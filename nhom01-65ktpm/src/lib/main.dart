import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; 
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/login_screen.dart';

// Thông tin kết nối Supabase Cloud
const String supabaseUrl = 'https://vghpttrsnnkhfauxwozi.supabase.co';
const String supabaseAnonKey = 'sb_publishable_Z_UGavwpjACfY6gZCsvMEw_sBzJMlSs';

// Khởi tạo Supabase client toàn cục cho toàn bộ ứng dụng
final supabase = Supabase.instance.client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Supabase
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(const BallerDisciplineApp());
}

class BallerDisciplineApp extends StatelessWidget {
  const BallerDisciplineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baller Discipline',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B1320),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF10B981),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
