import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MatchOne extends StatelessWidget {
  const MatchOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brazil Vs Germany'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          margin: EdgeInsets.only(bottom: 430, top: 50),
          shadowColor: Colors.greenAccent,
          elevation: 5,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('basketball')
                  .doc('1_ban_vs_ind')
                  .snapshots(),
              builder:
                  (context, AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
                print(snapshot.data?.data());
                if (snapshot.hasData) {
                  final score = snapshot.data!;
                  return Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          score.get('match_name'),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  score.get('score_team_a').toString(),
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  ':',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  score.get('score_team_b').toString(),
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                            Text(
                              score.get('Time'),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              score.get('Total Time'),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('basketball')
                .doc('1_ban_vs_ind')
                .update({
              'match_name': "Brazil Vs Germany",
              'score_team_a': 7,
              'score_team_b': 8,
              'team_a': "Brazil",
              'team_b': "Germany"
            });
          }),
    );
  }
}
