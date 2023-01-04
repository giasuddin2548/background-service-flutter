import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_background_service_ios/flutter_background_service_ios.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'notification_service.dart';

class BackgroundService{
  static String notificationChannelId = 'my_foreground';
  static int notificationId = 888;
  static int _counter = 0;

  static Future<void> initializeService() async {
    print('initializeService called');
    final service = FlutterBackgroundService();


    await service.configure(

        iosConfiguration: IosConfiguration(
          autoStart: true,
          onForeground: onStart,
          onBackground: onIosBackground,
        ),
        androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          autoStart: true,
          isForegroundMode: true,
          notificationChannelId: notificationChannelId,
          foregroundServiceNotificationId: notificationId,
        ),
    );
    service.startService();
  }

  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    print('onIosBackground called');
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    return true;
  }


  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });

      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }

    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    // bring to foreground
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService()) {
        //  NotificationService.showNotification(flutterLocalNotificationsPlugin, 1, 'title', 'body', 'payload');
        }
      }else if (service is IOSServiceInstance){
      //  NotificationService.showNotification(flutterLocalNotificationsPlugin, 1, 'title', 'body', 'payload');
      }

      /// you can see this log in logcat
      print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');


      service.invoke(
        'update',
        {
          "current_date": DateTime.now().toIso8601String(),
          "device": 'device',
        },
      );
    });
  }
}