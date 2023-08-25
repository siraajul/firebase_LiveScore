import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ScoreApp());
}

class ScoreApp extends StatelessWidget {
  const ScoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> getDataFromFirebase() async {
    CollectionReference basketBallRef =
        firebaseFirestore.collection('basketball');
    final DocumentReference docReference = basketBallRef.doc('1_ban_vs_ind');
    final data = await docReference.get();
    print(data.data());
  }

  @override
  void initState() {
    getDataFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Score App'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 48,
            ),
            Text(
              'Match Name',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      '12',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'Team Name',
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  ],
                ),
                const Text('VS'),
                Column(
                  children: [
                    Text(
                      '12',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'Team Name',
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
