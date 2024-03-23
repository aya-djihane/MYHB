import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/models/user.dart';

const String ITEMES_COLLECTON_REF="items";
const String FIVORATE_COLLECTON_REF="favorate";
const String USER_COLLECTON_REF="users";
Future<void> handleBackgroundMessage(RemoteMessage message)async{
}
class DatabaseService{
final _firestore=FirebaseFirestore.instance;
final _firebaseMessaging=FirebaseMessaging.instance;
late final CollectionReference  _todoref;
late final CollectionReference  _usertodo;
final _androidChannel = const AndroidNotificationChannel(
    "test",
 "test",
 description: "test",
 importance: Importance.defaultImportance
    );
final _localNotification = FlutterLocalNotificationsPlugin();
DatabaseService(){
 _todoref = _firestore.collection(ITEMES_COLLECTON_REF).withConverter<Item>(
  fromFirestore: (snapshots, _) => Item.fromSnapshot(snapshots),
  toFirestore: (item, _) => item.toJson(),
 );
_usertodo = _firestore.collection(USER_COLLECTON_REF).withConverter<Users>(
fromFirestore: (snapshots, _) => Users.fromSnapshot(snapshots),
toFirestore: (user, _) => user.toJson(),
);
}
Stream<List<Item>> getItems() {
 return _todoref.snapshots().map((querySnapshot) {
  return querySnapshot.docs.map((doc) {
   return doc.data() as Item;
  }).toList();
 });
}
Future<void> initNotifications( )async{
 await _firebaseMessaging.requestPermission();
 final fCMToken = await _firebaseMessaging.getToken();
 print("notif ${fCMToken}");
 FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
 FirebaseMessaging.onMessage.listen((event) {
  final notification = event.notification;
  if(notification==null) return;
  _localNotification.show(notification.hashCode, notification.title, notification.body, NotificationDetails(
   android:  AndroidNotificationDetails(
   _androidChannel.id,
    _androidChannel.name,
    channelDescription: _androidChannel.description,
                 icon: 'resource://drawable/launcher_icon'
    ,
   ),
  ),
   payload: jsonEncode(event.toMap())
  );
 });
 initLocalNotification();
}
Future initLocalNotification()async{
 const android =AndroidInitializationSettings('@drawable/group');
 const setting = InitializationSettings(android: android);
 await _localNotification.initialize(setting,
  onDidReceiveNotificationResponse: (payload){
  final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
  print(message);
  }
 );
 final platform=_localNotification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
await platform?.createNotificationChannel(_androidChannel);
}


void addItem(Item item) async{
 _todoref.add(item);
 }
Future<void> updateItemRecord(Item item )async{
 await _firestore.collection(ITEMES_COLLECTON_REF).doc(item.id.toString()).update(item.toJson());
 }
void addUser(Users item) async{
 _usertodo.add(item);
}
Future<void> CreatItemFavorateRecord(Item item )async{
 await _firestore.collection(FIVORATE_COLLECTON_REF).doc(item.id).set(item.toJson());
}
Future<void> CreatUserRecord(Users item )async{
 await _firestore.collection(USER_COLLECTON_REF).doc(item.id).set(item.toJson());
}

}