import 'dart:convert';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationHelper {

  // Constructor
  NotificationHelper({this.fcmOnMessage}) {
    _initFCM();
  }


  // Clients.
  static final _fcmNotify = FirebaseMessaging.instance;
  static final _localNotify = FlutterLocalNotificationsPlugin();
  // Functions.
  final Function? fcmOnMessage;

  // Vars
  bool _init = false;

  // Public Methods
  Future<void> subscribeToTopic(String topic) async {
    await _fcmNotify.subscribeToTopic("topic_$topic");
  }

  Future<void> unSubscribeToTopic(String topic) async {
    await _fcmNotify.unsubscribeFromTopic("topic_$topic");
  }

  // Private Methods
  _initFCM() async {

    if (_init) {
      return;
    } else {
      await _fcmNotify.subscribeToTopic('all');
      await _fcmNotify.setAutoInitEnabled(true);
      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
      // Init Listen for Notifications.
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {

        //
        if (fcmOnMessage != null) fcmOnMessage!(message);
        //
        showNotification(message);
      });
       FirebaseMessaging.onMessageOpenedApp.listen((event) {
         if (fcmOnMessage != null) fcmOnMessage!(event);

        showNotification(event);
       });
      // Request Permissions for IOS Only.
      await _fcmNotify.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      // Init Local Notifications Settings.
      var initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/launcher_icon');
      var initializationSettingsIOS = DarwinInitializationSettings(
        onDidReceiveLocalNotification: (_, __, ___, ____) async {},
        // there is other params needs to check !!
      );
      var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );
      await _localNotify.initialize(
        initializationSettings,
      );
      _init = true;
    }
  }



  //Helper Functions
  void showNotification(RemoteMessage payload) async {
    await _initFCM();

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'AQAChannelID',
      'AQAChannelName',
      channelDescription: 'AQAChanelDescription',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/launcher_icon',
      ticker: 'ticker',
    );
    var iOSPlatformChannelSpecifics =const  DarwinNotificationDetails(presentSound: true,);
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await _localNotify.show(
      Random().nextInt(999),
      payload.notification!.title ?? '',
      payload.notification!.body ?? '',
      platformChannelSpecifics,
      payload: json.encode(payload.data),
    );
  }

  void onNotificationOpen(String? payload) {
  }
}
