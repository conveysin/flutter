import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class FlutterLocalNotification {
static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

static void initialize(BuildContext context){
final InitializationSettings initializationSettings = InitializationSettings(
  iOS: IOSInitializationSettings(),
  android: AndroidInitializationSettings('@mipmap/ic_launcher'),

);
_flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: (String? payload) async {
  if (payload != null) {
    ///Foreground State screen change code
  }
}
);
}

static void display(RemoteMessage message) async {
 try {
   final id = DateTime.now().millisecondsSinceEpoch ~/1000;
   
   NotificationDetails notificationDetails = NotificationDetails(
   
    iOS: IOSNotificationDetails(),
        android: AndroidNotificationDetails(id.toString(),'android')
   );

   
   await _flutterLocalNotificationsPlugin.show(id,
       message.data['title'],
       message.data['body'],
       notificationDetails,
   payload: message.data['attachment_url']);
 } on Exception catch (e) {
   // TODO
 }


}



}


