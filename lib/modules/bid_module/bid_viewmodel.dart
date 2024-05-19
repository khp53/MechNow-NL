import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_user_app/common/custom_snackbar.dart';
import 'package:hackathon_user_app/modules/viewmodel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class BidViewmodel extends Viewmodel {
  BidViewmodel() {
    // Add your initialization code here
  }

  fetchBidsSnapshot(String docId) {
    var userBox = Hive.box('user');
    var uid = userBox.get('user_id');
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    return FirebaseFirestore.instance
        .collection('requests')
        .doc(uid) // replace 'uid' with the actual user ID
        .collection(
            formattedDate) // replace this with the actual date format you're using
        .doc(docId) // replace 'docId' with the actual document ID
        .collection("bid")
        .snapshots();
  }

  getSpecificUser(String uid) {
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }

  hireMechanic(String docId, String uid, String amount, String mechName) async {
    var userBox = Hive.box('user');
    var userId = userBox.get('user_id');
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    await FirebaseFirestore.instance
        .collection('requests')
        .doc(userId) // replace 'userId' with the actual user ID
        .collection(
            formattedDate) // replace this with the actual date format you're using
        .doc(docId) // replace 'docId' with the actual document ID
        .update({
      'status': 'hired',
      'hiredMechanic': uid,
      'hiredAmount': amount
    }).then((value) => customSnackBar(
              title: "Success!",
              message: "You have hired $mechName!",
              bgColor: Colors.green,
            ));
  }
}
