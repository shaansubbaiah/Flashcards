import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';
import 'package:flutterfiretest/overview/models/deck.dart';
// import 'package:flutterfiretest/overview/models/card.dart';

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

  Future deleteAccount() async {
    String docRef, deckRef;
    await userCollection
        .where("uid", isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                docRef = doc.id;
              })
            });

    await deckCollection
        .where("uid", isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                deckRef = doc.id;

                cardCollection
                    .where("deckid", isEqualTo: deckRef)
                    .get()
                    .then((QuerySnapshot querySnapshot) => {
                          querySnapshot.docs.forEach((doc) {
                            cardCollection.doc(doc.id).delete();
                          })
                        });

                deckCollection.doc(deckRef).delete();
              })
            });

    print("deleted");
    await userCollection.doc(docRef).delete();
  }

  //deck list from snapshot
  List<Deck> _deckListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Deck(
        deckname: doc.data()['deckname'] ?? '',
        desc: doc.data()['desc'] ?? '',
        tag: doc.data()['tag'] ?? '',
      );
    }).toList();
  }

  Stream<List<Deck>> get decks {
    return deckCollection
        .where("uid", isEqualTo: uid)
        .snapshots()
        .map(_deckListFromSnapshot);
  }

  List<FlashCard> _cardListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FlashCard(
        deckId: doc.data()['deckId'] ?? '',
        front: doc.data()['front'] ?? '',
        back: doc.data()['back'] ?? '',
      );
    }).toList();
  }

  Stream<List<FlashCard>> get cards {
    return cardCollection
    .where("deckid", isEqualTo: deckid)
    .snapshots()
    .map(_cardListFromSnapshot);
  }
}
