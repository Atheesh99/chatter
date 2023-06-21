import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  RxBool isLoading = false.obs;
  final TextEditingController _search = TextEditingController();
  late Map<String, dynamic> usermap;
  void onSearch() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    isLoading = true as RxBool;
    await firestore
        .collection('users')
        .where("username", isEqualTo: _search.text)
        .get()
        .then((value) {
      update();
      usermap = value.docs[0].data();
      isLoading = false as RxBool;
    });
  }
}
