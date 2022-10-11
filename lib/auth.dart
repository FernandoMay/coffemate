import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffemate/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // Firestore cloudFirestoreClass = CloudFirestoreClass();

  bool isValidEmail(String m) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(m);
  }

  Future<String> signInUser(
      {required String email, required String password}) async {
    email.trim();
    password.trim();
    String output = "Algo salió mal :c";
    if (email != "" && password != "") {
      if (isValidEmail(email)) {
        try {
          await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password);
          output = "success";
        } on FirebaseAuthException catch (e) {
          output = e.message.toString();
        }
      } else {
        output = "Verifica tu email";
      }
    } else {
      output = "Por favor llene todos los campos";
    }
    return output;
  }

  Future<String> signUpUser(
      {required String name,
      required String email,
      required String password}) async {
    name.trim();
    email.trim();
    password.trim();
    String output = "Algo salió mal :c,f";
    if (name != "" && email != "" && password != "") {
      if (isValidEmail(email)) {
        try {
          await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password);
          Coffe coff = Coffe(
              name: name,
              coffee: Random().nextInt(12),
              azucar: Random().nextInt(3),
              stevia: Random().nextInt(3),
              email: email);
          FirebaseFirestore.instance
              .doc(email)
              .set(coff.toJson())
              .onError((e, _) => print("Error writing document: $e"));
          output = "success";
        } on FirebaseAuthException catch (e) {
          output = e.message.toString();
        }
      } else {
        output = "Verifica tu email";
      }
    } else {
      output = "Por favor llene todos los campos";
    }
    return output;
  }
}
