import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'models/article.dart';
import 'bloc/article_bloc.dart';
import 'services/api_service.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleAdapter());
  final favoritesBox = await Hive.openBox<int>('favorites');
  runApp(MyApp(favoritesBox: favoritesBox));
}

class MyApp extends StatelessWidget {
  final Box<int> favoritesBox;

  const MyApp({super.key, required this.favoritesBox});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bharat NXT Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16),
        ),
        cardTheme: const CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
      home: BlocProvider(
        create: (context) => ArticleBloc(ApiService(), favoritesBox),
        child: const MainScreen(),
      ),
    );
  }
}