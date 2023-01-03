import 'dart:io';
import 'package:background_service_flutter/service/background_service.dart';
import 'package:background_service_flutter/service/notification_service.dart';
import 'package:background_service_flutter/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final navKey =  GlobalKey<NavigatorState>();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init(flutterLocalNotificationsPlugin);
  await BackgroundService.initializeService();



  // Workmanager().initialize(
  //     callbackDispatcher, // The top level function, aka callbackDispatcher
  //     isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  // );
  if(Platform.isIOS){
    // print('Checker:__ ${StackTrace.current} Method Called');
    await NotificationService.requestIOSPermissions(flutterLocalNotificationsPlugin);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Background',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const HomeScreen(),
    );
  }
}
