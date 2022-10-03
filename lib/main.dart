import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'app/app_bloc_observer.dart';
import 'data/data_helper.dart';
import 'utility/service/flutter_local_notification.dart';



//Receive message when App is in Background
Future<void> _messageHandler(RemoteMessage message) async {
  if(message.data!=null) {
    print(message.data);
    FlutterLocalNotification.display(message);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runZonedGuarded(
        () => runApp(App(appBloc: DataHelperImpl.instance.appBloc)),
        (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

