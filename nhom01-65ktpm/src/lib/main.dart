import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/login_screen.dart';
import 'package:flutter_dotenv/.env';
// Thông tin kết nối Supabase Cloud (lấy từ .env)
const String supabaseUrl = dotenv.env['SUPABASE_URL']!;
const String supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY']!;

// Khởi tạo Supabase client toàn cục
final supabase = Supabase.instance.client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo kết nối Supabase
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
