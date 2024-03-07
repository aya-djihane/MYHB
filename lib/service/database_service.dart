import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:myhb_app/models/item.dart';

const String ITEMES_COLLECTON_REF="items";
const String FIVORATE_COLLECTON_REF="favorate";
class DatabaseService{
final _firestore=FirebaseFirestore.instance;
final _firebaseMessaging=FirebaseMessaging.instance;
late final CollectionReference  _todoref;
DatabaseService(){
 _todoref = _firestore.collection(ITEMES_COLLECTON_REF).withConverter<Item>(
  fromFirestore: (snapshots, _) => Item.fromSnapshot(snapshots),
  toFirestore: (item, _) => item.toJson(),
 );}
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

}
void addItem(Item item) async{
 _todoref.add(item);
 }
 Future<void> updateItemRecord(Item item )async{
 await _firestore.collection(ITEMES_COLLECTON_REF).doc(item.id.toString()).update(item.toJson());
 }
Future<void> CreatItemFavorateRecord(Item item )async{
 await _firestore.collection(FIVORATE_COLLECTON_REF).doc(item.id).set(item.toJson());

}
}