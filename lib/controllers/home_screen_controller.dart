import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
class HomeScreenController extends GetxController  with WidgetsBindingObserver{

  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
  int counter = 0;
  String text = '';

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }











  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state){
      case AppLifecycleState.resumed:
        if (kDebugMode) {
          print("App-Life-Cycle: resumed");
        }
        break;
      case AppLifecycleState.inactive:
        if (kDebugMode) {
          print("App-Life-Cycle: inactive");
        }

        break;
      case AppLifecycleState.paused:
        if (kDebugMode) {
          print("App-Life-Cycle: paused");
          //    Workmanager().registerOneOffTask("task-identifier", "simpleTask");
        }
        break;
      case AppLifecycleState.detached:
        if (kDebugMode) {
          print("App-Life-Cycle: detached");
        }
        break;
    }
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}