import 'dart:typed_data';
import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/function/image_picker.dart';
import 'package:chatter/screens/widget/search.dart';
import 'package:chatter/screens/widget/sigin_login_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? image;
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
    return StreamBuilder<DocumentSnapshot>(
      stream: userRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.discreteCircle(
                color: Colors.black, size: 50),
          );
        }
        final user = snapshot.data!.data() as Map<String, dynamic>;
        return Scaffold(
          backgroundColor: backgroundBlack,
          body: SafeArea(
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: const EdgeInsets.only(top: 35, left: 30),
                            child: GestureDetector(
                              onTap: () => Get.back(),
                              child: const Icon(
                                Icons.arrow_back_ios,
                                size: 25,
                                color: textWhite,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.expand,
                            children: [
                              /////////////////////////////image feacturing
                              image != null
                                  ? CircleAvatar(
                                      backgroundImage: MemoryImage(image!),
                                    )
                                  : CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(user['photoUrl']),
                                      radius: 60,
                                    ),

                              Positioned(
                                bottom: -10,
                                right: -25,
                                child: GestureDetector(
                                  onTap: selectImage,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.9),
                                    child: const Icon(
                                      Icons.add_a_photo,
                                      color: textBlack,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        kHeight20,
                        Text(
                          user["username"] ?? "",
                          style: const TextStyle(
                              color: textWhite,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  kHeight30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      SearchIcon(icon: Icons.message_outlined, size: 25),
                      SearchIcon(icon: Icons.videocam_outlined, size: 25),
                      SearchIcon(icon: Icons.phone_outlined, size: 25),
                      SearchIcon(icon: Icons.more_horiz, size: 25),
                    ],
                  ),
                  kHeight20,
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: textWhite,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                          top: 20,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              kHeight20,
                              // profileTextField(
                              //     'Display Name',
                              //     'Amal kvs',
                              //     TextInputType.text,
                              //     controller.namecontroller,
                              //     ),
                              // kHeight10,
                              // profileTextField('Bio', 'Type you Bio',
                              //     TextInputType.name, controller.biocontroller),
                              // // kHeight10,
                              // // profileTextField('Email Address', 'Amalkvs@gmail.com',
                              // //     TextInputType.emailAddress),
                              // kHeight10,
                              // profileTextField(
                              //     'Phone',
                              //     '12356546554',
                              //     TextInputType.number,
                              //     controller.phonecontroller),
                              // kHeight20,

                              TextField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                cursorColor: Theme.of(context).primaryColor,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  errorMaxLines: 1,
                                  contentPadding: const EdgeInsets.only(
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  border: InputBorder.none,
                                  labelText: "UserName",
                                  hintText: user["username"] ?? "",
                                ),
                              ),
                              kHeight20,
                              TextField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                cursorColor: Theme.of(context).primaryColor,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    errorMaxLines: 1,
                                    contentPadding: const EdgeInsets.only(
                                      top: 5,
                                      bottom: 5,
                                    ),
                                    border: InputBorder.none,
                                    labelText: "Bio",
                                    hintText: user["bio"] ?? ""),
                              ),
                              kHeight20,
                              TextField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                cursorColor: Theme.of(context).primaryColor,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    errorMaxLines: 1,
                                    contentPadding: const EdgeInsets.only(
                                      top: 5,
                                      bottom: 5,
                                    ),
                                    border: InputBorder.none,
                                    labelText: "Email",
                                    hintText: user["email"] ?? ""),
                              ),
                              kHeight20,

                              InkWell(
                                borderRadius: BorderRadius.circular(32),
                                onTap: () {},
                                child: const SiginAndLoginBUtton(
                                  text: 'Add',
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // TextField profileTextField(String title1, String title2, String? errorText,
  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      image = im;
    });
  }
}
