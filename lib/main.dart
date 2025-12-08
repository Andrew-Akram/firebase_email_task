import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> foregroundNotificationHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (message.notification != null) {
      String? title = message.notification?.title;
      String? body = message.notification?.body;


      String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());


      DatabaseReference ref = FirebaseDatabase.instance.ref("message");


      await ref.child(formattedDate).set(body ?? 'No content');


      showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => AlertDialog(
          title: Text(title ?? 'No Title'),
          content: Text(body ?? 'No Body'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  } catch (e) {
    print('Error saving message: $e');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  String? token = await FirebaseMessaging.instance.getToken();
  print('FCM Token: $token');


  FirebaseMessaging.onMessage.listen(foregroundNotificationHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: Scaffold(
        appBar: AppBar(title: const Text('Firebase Connecteddd ✅')),
        body: const Center(
          child: Text('test email build'),
        ),
      ),
    );
  }
}
