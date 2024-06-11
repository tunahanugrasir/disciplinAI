import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showNotification() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'try_notification', 'deneme kanal adı',
        channelDescription: 'kanal açıklaması',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false);

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
        0,
        'BAŞLIK',
        'Tunahan, depresyona girecek vaktin mi var? Başarı için yapman gerekenler dururken, nasıl üzülmeye zaman harcıyorsun? Bu yüzden sonsuza dek kaybediyorsun!',
        platformChannelSpecifics,
        payload: 'item x');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Local Notifications'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _showNotification,
          child: const Text('Bildirim Gönder'),
        ),
      ),
    );
  }
}
