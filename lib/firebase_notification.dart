import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotification {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialization() async {
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      messageHandler(message);
    }

    FirebaseMessaging.onMessage.listen(messageHandler);

    FirebaseMessaging.onMessageOpenedApp.listen(messageHandler);
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackground);
  }

  Future<void> messageHandler(RemoteMessage message) async {
    print(message.data);
    print(message.notification?.body ?? 'empty body');
    print(message.notification?.title ?? 'empty title');
  }

  Future<String?> getToken() async {
    final String? token = await firebaseMessaging.getToken();

    print(token);
    return token;
  }

  void onTokenRefresh() {
    firebaseMessaging.onTokenRefresh.listen((token) {
      print('send to api $token');
    });
  }

  Future<void> subscribeToTopic(String topicName) async {
    await firebaseMessaging.subscribeToTopic(topicName);
  }

  Future<void> unsubscribeToTopic(String topicName) async {
    await firebaseMessaging.unsubscribeFromTopic(topicName);
  }
}

Future<void> firebaseMessagingBackground(RemoteMessage message) async {
  print(message.data);
  print(message.notification?.body ?? 'empty body');
  print(message.notification?.title ?? 'empty title');
}
