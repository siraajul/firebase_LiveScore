import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_notification.dart';
import 'match_one.dart';
import 'match_two.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseNotification().initialization();
  print(await FirebaseNotification().getToken());
  FirebaseNotification().onTokenRefresh();
  await FirebaseNotification().subscribeToTopic('AsthaIT');
  runApp(const BasketBallLiveScoreApp());
}

class BasketBallLiveScoreApp extends StatelessWidget {
  const BasketBallLiveScoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowMaterialGrid: false,
      title: "Firebase Demo",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Brazil Vs Germany',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MatchOne()));
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.blue,
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Argentina Vs France',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MatchTwo()));
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.blue,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
