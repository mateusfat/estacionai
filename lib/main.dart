import 'package:estacionai/model/Estacionamento.dart';
import 'package:estacionai/view/Principal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Estacionamento()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Estacionaí',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const Principal(),
      ),
    );
  }
}
