import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myhb_app/models/item.dart';

const String ITEMES_COLLECTON_REF="items";
class DatabaseService{
final _firestore=FirebaseFirestore.instance;
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

void addItem(Item item) async{
 _todoref.add(item);
 }
}