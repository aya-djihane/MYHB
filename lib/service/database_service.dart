import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:myhb_app/chekoutEntry.dart';
import 'package:myhb_app/controller/dashboard_controller.dart';
import 'package:myhb_app/models/cart_item.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/models/notification.dart';
import 'package:myhb_app/models/review.dart';
import 'package:myhb_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String ITEMES_COLLECTON_REF="items";
const String FIVORATE_COLLECTON_REF="favorate";
const String REVIEW_COLLECTON_REF="reviewes";
const String USER_COLLECTON_REF="users";
const String Orders_COLLECTON_REF="orders";
const String Notification_COLLECTON_REF="Notifications";
final DashboardController dashboardController = Get.put(DashboardController());

Future<void> handleBackgroundMessage(RemoteMessage message)async{
}

Future<void> initNotifications() async {
 await FirebaseMessaging.instance.requestPermission();


 final fCMToken = await FirebaseMessaging.instance.getToken();
 print("FCM Token: $fCMToken");
 final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

 const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'test_channel', // ID
  'Test Channel', // Title, // Description
  importance: Importance.high,
 );
 final InitializationSettings initializationSettings =
 const InitializationSettings(android: AndroidInitializationSettings('resource://drawable/ic_luncher'));
 await flutterLocalNotificationsPlugin.initialize(
  initializationSettings,
 );
 await flutterLocalNotificationsPlugin
     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
     ?.createNotificationChannel(channel);

 FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  final notification = message.notification;
  if (notification != null) {
   _showLocalNotification(
    flutterLocalNotificationsPlugin,
    notification.title ?? 'Notification',
    notification.body ?? 'Body',
    message.data,
   );
  }
 });
 FirebaseMessaging.onBackgroundMessage((message) async {
 });
 FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  print('A new onMessageOpenedApp event was published!');
 });
}

void _showLocalNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    String title,
    String body,
    Map<String, dynamic> payload,
    ) async {
 const AndroidNotificationDetails androidPlatformChannelSpecifics =
 AndroidNotificationDetails(
  'your channel id', // channel ID
  'your channel name', // channel name, // channel description
  importance: Importance.max,
  priority: Priority.high,
 );

 const NotificationDetails platformChannelSpecifics =
 NotificationDetails(android: androidPlatformChannelSpecifics);

 await flutterLocalNotificationsPlugin.show(
  0, // notification ID
  title, // title
  body, // body
  platformChannelSpecifics,
  payload: payload.toString(),
 );
}

class DatabaseService{
final _firestore=FirebaseFirestore.instance;
final _firebaseMessaging=FirebaseMessaging.instance;
late final CollectionReference  _todoref;
late final CollectionReference  _orderref;
late final CollectionReference  _usertodo;
late final CollectionReference  _notification;
late final CollectionReference  _reviewref;
late final CollectionReference  _userref;

final _androidChannel = const AndroidNotificationChannel(
    "test",
 "test",
 description: "test",
 importance: Importance.defaultImportance
    );

final _localNotification = FlutterLocalNotificationsPlugin();
final CollectionReference checkoutCollection = FirebaseFirestore.instance.collection('checkout');

DatabaseService(){

 _todoref = _firestore.collection(ITEMES_COLLECTON_REF).withConverter<Item>(
  fromFirestore: (snapshots, _) => Item.fromSnapshot(snapshots),
  toFirestore: (item, _) => item.toJson(),
 );
 _reviewref = _firestore.collection(REVIEW_COLLECTON_REF).withConverter<Review>(
  fromFirestore: (snapshots, _) => Review.fromSnapshot(snapshots),
  toFirestore: (Review, _) => Review.toJson(),
 );
_usertodo = _firestore.collection(USER_COLLECTON_REF).withConverter<Users>(
fromFirestore: (snapshots, _) => Users.fromSnapshot(snapshots),
toFirestore: (user, _) => user.toJson(),
);
_orderref = _firestore.collection(Orders_COLLECTON_REF).withConverter<CartItem>(
fromFirestore: (snapshots, _) => CartItem.fromSnapshot(snapshots),
toFirestore: (CartItem, _) => CartItem.toJson(),
);
 _notification = _firestore.collection(Notification_COLLECTON_REF).withConverter<Notification>(
  fromFirestore: (snapshots, _) => Notification.fromSnapshot(snapshots),
  toFirestore: (notification, _) => notification.toJson(),
 );
}
Stream<List<Item>> getItems() {
 return _todoref.snapshots().map((querySnapshot) {
  return querySnapshot.docs.map((doc) {
   return doc.data() as Item;
  }).toList();
 });
}
Stream<List<CartItem>> getOrderItems() {
 return _orderref.snapshots().map((querySnapshot) {
  return querySnapshot.docs.map((doc) {
   print(doc.id);

   return doc.data() as CartItem;

  }).toList();
 });
}

Future<List<CheckoutEntry>> getCheckoutList() async {
 SharedPreferences prefs = await SharedPreferences.getInstance();
 String? userInfoJson = prefs.getString('userInfo');
 Map<String, dynamic> userInfoMap = jsonDecode(userInfoJson!);
 String email = userInfoMap['email'];

 QuerySnapshot querySnapshot = await checkoutCollection.where('useremail', isEqualTo: email).get();

 List<CheckoutEntry> checkoutList = querySnapshot.docs.map((doc) => CheckoutEntry.fromSnapshot(doc)).toList();
 checkoutList.forEach((element) {print(element.item.item.id);});

 return checkoutList;
}
Future<void> initNotifications( )async{
 final DashboardController dashboardController = Get.put(DashboardController());
 await _firebaseMessaging.requestPermission();
 final fCMToken = await _firebaseMessaging.getToken();
 print("notif : ${fCMToken}");
 FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
 FirebaseMessaging.onMessage.listen((event) {
  final notification = event.notification;
  if (notification == null) return;
  final imageUrl = event.notification!.android!.imageUrl;
  dashboardController.notifier.value=true;
  print(dashboardController.notifier.value);
  print("**************************");
  FirebaseFirestore.instance.collection('Notifications').add({
   'title': notification.title ?? '',
   'subtitle': notification.body ?? '',
   'image': imageUrl ?? '',
   'isRead': 0,
  });  _localNotification.show(notification.hashCode, notification.title, notification.body, NotificationDetails(
   android:  AndroidNotificationDetails(
   _androidChannel.id,
    _androidChannel.name,
    priority: Priority.high,
    importance: Importance.high,
    channelDescription: _androidChannel.description,
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
Future<void> updateItemCounter(String itemId, int newCounter) async {
 try {
  final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
      .collection(Orders_COLLECTON_REF)
      .where('item.id', isEqualTo: itemId)
      .get();
  for (final QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
  in querySnapshot.docs) {
   final String docId = documentSnapshot.id;
   await _firestore
       .collection(Orders_COLLECTON_REF)
       .doc(docId)
       .update({'counter': newCounter});
  }
  print('Item counter updated successfully.');
 } catch (e) {
  print('Error updating item counter: $e');
  // Handle the error as needed
 }
}
Future<void> deleteItemsById(String itemId) async {
 try {
  final QuerySnapshot<Map<String, dynamic>> querySnapshot =
  await FirebaseFirestore.instance
      .collection(Orders_COLLECTON_REF)
      .where('item.id', isEqualTo: itemId)
      .get();

  for (final QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
  in querySnapshot.docs) {
   await documentSnapshot.reference.delete();
  }

  print('Documents with item ID $itemId deleted successfully.');
 } catch (e) {
  print('Error deleting documents: $e');
  // Handle the error as needed
 }
}



void addUser(Users item) async{
 _usertodo.add(item);
}
Future<void> CreatItemFavorateRecord(Item item )async{
 await _firestore.collection(FIVORATE_COLLECTON_REF).doc(item.id).set(item.toJson());
}
Stream<List<Review>> getReviews() {
 return _reviewref.snapshots().map((querySnapshot) {
  return querySnapshot.docs.map((doc) {
   return doc.data() as Review;
  }).toList();
 });
}
Stream<List<Users>> getUsers() {
 return _usertodo.snapshots().map((querySnapshot) {
  return querySnapshot.docs.map((doc) {
   return doc.data() as Users;
  }).toList();
 });
}
Stream<List<Notification>> getNotification() {
 return _notification.snapshots().map((querySnapshot) {
  return querySnapshot.docs.map((doc) {
   return doc.data() as Notification;
  }).toList();
 });
}
Future<Users?> fetchUsersAndCheckEmail() async {
 Completer<Users?> completer = Completer<Users?>();
 try {
  Stream<List<Users>> usersStream = getUsers();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userInfoJson = prefs.getString('userInfo');
  Map<String, dynamic> userInfoMap = jsonDecode(userInfoJson!);
  String email = userInfoMap['email'];
  usersStream.listen((List<Users> users) {
   try {
    Users userWithEmail = users.firstWhere(
         (user) => user.email == email,
    );
    completer.complete(userWithEmail);
   } catch (e) {
    print('User with email$email  not found.');
    completer.complete(null);
   }
  });
 } catch (e) {
  print('Error fetching users: $e');
  completer.completeError(e);
 }

 return completer.future;
}
Future<void> CreatItemReviwRecord(Review item) async {
 print(" the Review ADDED");
 await _firestore.collection(REVIEW_COLLECTON_REF).add(item.toJson());
}

Future<void> CreatUserRecord(Users item )async{
 await _firestore.collection(USER_COLLECTON_REF).doc(item.id).set(item.toJson());
}



}