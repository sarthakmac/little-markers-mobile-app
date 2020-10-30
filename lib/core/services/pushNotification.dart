import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  print('backgroundMessage received ${message.containsKey('data')}');
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }
}

Future<dynamic> myOnLaunchMessageHandler(Map<String, dynamic> message) {
  print('launchMessage received ${message.containsKey('data')}');
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }
}

Future<dynamic> myOnResumeMessageHandler(Map<String, dynamic> message) {
  print('launchMessage received ${message.containsKey('data')}');
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }
}

Future<dynamic> myOnMessageMessageHandler(Map<String, dynamic> message) {
  print('onMessage received ${message.containsKey('data')}');
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    print('oooooooooooooooooooo${message['data']}');
    LocalNotification().showLocalNotification(data);
//    try{

//    }catch(e){
//
//      print('error=$e');
//
//    }



  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    LocalNotification().showLocalNotification(notification);

  }
}


class LocalNotification{
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  void configLocalNotification() {
    var initializationSettingsAndroid = new AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  Future showLocalNotification(Map<String, dynamic> message) async {

    String title = message['data']['title'] ?? message["notification"]["title"];
    String body = message['data']['body'] ?? message["notification"]["body"];


    InitializationSettings initSettings = new InitializationSettings(
        AndroidInitializationSettings(
          'mipmap/ic_launcher',
        ),
        IOSInitializationSettings());
    flutterLocalNotificationsPlugin.initialize(initSettings,onSelectNotification:(pathAndDocumentId)async{
      String page = message['data']['page'] ?? message["notification"]["page"];
//      Navigator.pushNamed(context, page);

      //TODO do something
    });
    AndroidNotificationDetails android = new AndroidNotificationDetails(
      'Notifications',
      "default",
      "Notifications from Thondan",
      importance: Importance.Max,
      playSound: true,
      priority: Priority.High,
    );
    NotificationDetails notificationDetails =  new NotificationDetails(android,IOSNotificationDetails());
    await flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails,payload:"payload");

  }
}

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
  PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure(
        onMessage: LocalNotification().showLocalNotification,
        onLaunch: myOnLaunchMessageHandler,
        onResume: myOnResumeMessageHandler,
      );

      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      print("#######################$token");
      Future.delayed(Duration(seconds: 2),(){
        print(token);

      });
      _firebaseMessaging.subscribeToTopic("event");

      _initialized = true;
    }
  }

  Future subcripeUserId(String userid){
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!####!!!!!!!!!!$userid");
    _firebaseMessaging.subscribeToTopic(userid);

  }


  Future getToken()async{
    String token = await _firebaseMessaging.getToken();
    print("#######################$token");
    return token;
  }
}
