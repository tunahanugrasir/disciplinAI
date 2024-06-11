import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:usage_stats/usage_stats.dart';

class UsageStatsScreen extends StatefulWidget {
  const UsageStatsScreen({super.key});

  @override
  UsageStatsScreenState createState() => UsageStatsScreenState();
}

class UsageStatsScreenState extends State<UsageStatsScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _checkUsageStats();
  }

  void _initializeNotifications() {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showNotification(String message) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'motivation_channel', // id
      'Motivasyon Bildirimleri', // name
      channelDescription: 'Kullanıcıyı motive edici bildirimler',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Motivasyon Uyarısı',
      message,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  void _checkUsageStats() async {
    bool granted = await UsageStats.checkUsagePermission() ?? false;
    if (!granted) {
      UsageStats.grantUsagePermission();
    }

    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(const Duration(minutes: 1));

    List<UsageInfo> usageStats =
        await UsageStats.queryUsageStats(startDate, endDate);

    for (var info in usageStats) {
      // totalTimeInForeground bir String? ise, null kontrolü yapın ve int'e dönüştürün
      int totalTimeInForeground =
          int.tryParse(info.totalTimeInForeground ?? '0') ?? 0;
      if (info.packageName == 'com.instagram.android' &&
          totalTimeInForeground > 60000) {
        _showNotification('Kardeşim ne yapıyorsun? Hayallerin seni bekliyor');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uygulama Kullanım Verileri'),
      ),
      body: const Center(
        child: Text('Kullanım verileri kontrol ediliyor...'),
      ),
    );
  }
}
