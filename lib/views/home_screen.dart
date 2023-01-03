import 'package:background_service_flutter/controllers/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
              height: 200,
              child: StreamBuilder(
                  stream: FlutterBackgroundService().on('update'),
                  builder: (c, data)=>Text('')),
            ),

            TextButton(onPressed: ()async{
              final service = FlutterBackgroundService();
              var isRunning = await service.isRunning();
              if (isRunning) {
                //service.invoke("stopService");
              } else {
                service.startService();
              }

            }, child: Text('Start')),
            TextButton(onPressed: ()async{
              final service = FlutterBackgroundService();
              var isRunning = await service.isRunning();
              if (isRunning) {
                service.invoke("stopService");
              }
            }, child: Text('Stop')),
            TextButton(onPressed: (){
              FlutterBackgroundService().invoke("setAsBackground");
            }, child: Text('Background')),
            TextButton(onPressed: (){
              FlutterBackgroundService().invoke("setAsForeground");
            }, child: Text('Foreground')),
          ],
        ),
      ),
    );
  }
}
