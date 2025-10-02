import 'package:bus_pos/core/services/local_storage.dart';
import 'package:bus_pos/features/authentication/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  storage = await LocalStorage.getInstance();

  runApp(
    MultiProvider(
      providers: [Provider<LocalStorage>.value(value: storage),         ChangeNotifierProvider(create: (_) => AuthProvider()),
],
      child: const App(),
    ),
  );
}
