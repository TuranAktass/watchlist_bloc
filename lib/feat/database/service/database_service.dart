import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:watchlist/feat/auth/repository/model/user_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addUserData(UserModel userData) async {
    await _db.collection("Users").doc(userData.uid).set(userData.toMap());
  }

  Future<UserModel> retrieveUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    var snapshot = await _db.collection("Users").doc(uid).get();
    return UserModel.fromDocumentSnapshot(snapshot);
  }

  Future<String> retrieveUserName(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Users").doc(uid).get();
    return snapshot.data()!["displayName"];
  }
}
