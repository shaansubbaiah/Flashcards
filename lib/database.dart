import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  static String uid;
  static String deckid;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference deckCollection =
      FirebaseFirestore.instance.collection('decks');

  final CollectionReference cardCollection =
      FirebaseFirestore.instance.collection('cards');

  DatabaseService() {
    final User user = FirebaseAuth.instance.currentUser;
    uid = user.uid;
    print(uid);
  }

  // DatabaseService(this.uid);

  Future addUserData(String uid) async {
    DatabaseService.uid = uid;
    return await userCollection.add({"uid": uid});
  }

  Future getUid(String uid) async {
    DatabaseService.uid = uid;
    print(DatabaseService.uid);
  }

  Future addCard(String deckId, String front, String back) async {
    return await cardCollection
        .add({"deckid": deckId, "front": front, "back": back});
  }

  Future addDeck(String deckname, String desc, String tag) async {
    final docRef = await deckCollection
        .add({"uid": uid, "deckname": deckname, "desc": desc, "tag": tag});

    deckid = docRef.id;
    return deckid;
  }
}
