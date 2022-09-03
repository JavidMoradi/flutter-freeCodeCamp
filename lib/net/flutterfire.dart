import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    return true;
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('provided password is too weak!');
    } else if (e.code == 'email-already-in-use') {
      print('email already exists!');
    }

    return false;
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<bool> logOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    return true;
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<bool> addCoin(String id, String amount) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var value = double.parse(amount);

    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Coins')
        .doc(id);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference); // capture of a data from the specified document

      if (!snapshot.exists) {
        documentReference.set({"Amount": value});
        return true;
      }
      double newAmount = snapshot['Amount'] + value;
      transaction.update(documentReference, {'Amount': newAmount});
      return true;
    });

    return false;
  } catch (e) {
    return false;
  }
}
