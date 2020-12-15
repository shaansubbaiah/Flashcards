import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

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
    return await cardCollection.add({
      "deckid": deckId,
      "front": front,
      "back": back,
      "score": 0.5,
    });
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
    return;
  }

  Future deleteDeck(String deckid) async {
    String deckRef;
    await deckCollection.get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) {
            if (doc.id == deckid) {
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
            }
          })
        });
    return;
  }

  //deck list from snapshot
  // List<Deck> _deckListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return Deck(
  //       deckname: doc.data()['deckname'] ?? '',
  //       desc: doc.data()['desc'] ?? '',
  //       tag: doc.data()['tag'] ?? '',
  //       deckid: doc.id ?? '',
  //     );
  //   }).toList();
  // }

  // Stream<List<Deck>> get decks {
  //   return deckCollection
  //       .where("uid", isEqualTo: uid)
  //       .snapshots()
  //       .map(_deckListFromSnapshot);
  // }

  Future<List> getCardDetails(String deckid) async {
    List<Map<String, dynamic>> allCards = [];
    await cardCollection
        .where("deckid", isEqualTo: deckid)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                Map<String, dynamic> card = {
                  "front": doc.data()['front'],
                  "back": doc.data()['back'],
                  "score": doc.data()['score'],
                  "cardId": doc.id,
                };
                allCards.add(card);
              })
            });

    // print(allCards);
    return allCards;
  }

  Future<List> getDecks() async {
    List<Map<String, dynamic>> allDecks = [];
    await deckCollection
        .where("uid", isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                Map<String, String> deck = {
                  "deckname": doc.data()['deckname'],
                  "desc": doc.data()['desc'],
                  "tag": doc.data()['tag'],
                  "deckid": doc.id
                };
                allDecks.add(deck);
              })
            });
    return allDecks;
  }

  Future<Map<String, dynamic>> getDeckDetails(String deckid) async {
    Map<String, dynamic> deckDetails;
    await deckCollection.get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) async {
            if (doc.id == deckid) {
              deckDetails = {
                "deckname": doc.data()['deckname'],
                "desc": doc.data()['desc'],
                "tag": doc.data()['tag'],
                "deckid": doc.id
              };
            }
          }),
        });
    return deckDetails;
  }

  Future<String> editDeck(
      String deckname, String desc, String tag, String docid) async {
    await deckCollection
        .doc(docid)
        .update({"uid": uid, "deckname": deckname, "desc": desc, "tag": tag})
        .then((value) {})
        .catchError((onError) {
          print(onError);
          return "error";
        });
    return "Successful";
  }

  Future<String> editCard(
      String front, String back, String docid, String deckid) async {
    await cardCollection
        .doc(docid)
        .update({"front": front, "back": back, "deckid": deckid})
        .then((value) {})
        .catchError((onError) {
          print(onError);
          return "error";
        });
    return "Successful";
  }

  Future<String> deleteOneCard(String cardId) async {
    await cardCollection
        .doc(cardId)
        .delete()
        .then((value) {})
        .catchError((onError) {
      print(onError);
      return "error";
    });
    return "Successful";
  }

  Future<List> getTotalCount() async {
    String deckRef;
    List count = [0, 0];

    await deckCollection
        .where("uid", isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                deckRef = doc.id;
                count[0] += 1;

                await cardCollection
                    .where("deckid", isEqualTo: deckRef)
                    .get()
                    .then((QuerySnapshot querySnapshot) => {
                          querySnapshot.docs.forEach((doc) {
                            count[1] += 1;
                          })
                        });
              })
            });

    return count;
  }
}
