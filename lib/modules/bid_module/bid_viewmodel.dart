import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackathon_user_app/common/custom_snackbar.dart';
import 'package:hackathon_user_app/dependencies/dependency_injection.dart';
import 'package:hackathon_user_app/modules/bid_module/widgets/bid_confirm_page.dart';
import 'package:hackathon_user_app/modules/viewmodel.dart';
import 'package:hackathon_user_app/services/request_services/request_services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class BidViewmodel extends Viewmodel {
  BidViewmodel() {
    // Add your initialization code here
  }
  RequestServices get _requestServices => dependency();

  fetchBidsSnapshot(String docId) {
    return FirebaseFirestore.instance
        .collection(
            'requests') // replace this with the actual date format you're using
        .doc(docId) // replace 'docId' with the actual document ID
        .collection("bid")
        .snapshots();
  }

  getSpecificUser(String uid) {
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }

  hireMechanic(
    String docId,
    String uid,
    String amount,
    String mechName,
    String area,
    String phone,
  ) async {
    //var userBox = Hive.box('user');
    //var userId = userBox.get('user_id');
    //DateTime now = DateTime.now();
    //String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    await FirebaseFirestore.instance
        .collection('requests')
        .doc(docId) // replace 'docId' with the actual document ID
        .update({
      'status': 'hired',
      'hiredMechanic': uid,
      'hiredAmount': amount
    }).then((value) async {
      customSnackBar(
        title: "Success!",
        message: "You have hired $mechName!",
        bgColor: Colors.green,
      );
      Get.to(
        () => BidConfirm(
          viewmodel: this,
          hiredName: mechName,
          hiredAmount: amount,
          location: area,
          phone: phone,
        ),
      );
      await _requestServices.sendMechanicHireNoti(
          hiredMechanic: uid, userName: "");
    });
  }

  cancelBid(String docId, String uid) async {
    var userBox = Hive.box('user');
    var userId = userBox.get('user_id');
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    await FirebaseFirestore.instance
        .collection('requests')
        .doc(userId) // replace 'userId' with the actual user ID
        .collection(
            formattedDate) // replace this with the actual date format you're using
        .doc(docId)
        .update({'status': 'cancelled'}).then((value) => customSnackBar(
              title: "Success!",
              message: "Bid has been cancelled!",
              bgColor: Colors.green,
            ));
  }

  callMechanic(String phone) {
    // use url_launcher to call the mechanic
    launchUrl(Uri.parse('tel:$phone'));
  }
}
