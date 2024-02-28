import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
class storage{
   firebase_storage.FirebaseStorage Storage = firebase_storage.FirebaseStorage.instance;
  Future<firebase_storage.ListResult> listFile()async{
    firebase_storage.ListResult result = await Storage.ref('test').listAll();
    result.items.forEach((firebase_storage.Reference ref) { print("founded file");});
    return result;
  }
}