import 'package:discipline/data/user_data.dart';
import 'package:discipline/presentation/screens/user_information_screen.dart';
import 'package:discipline/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => UserData())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UserInformationScreen(),
    );
  }
}
