import 'dart:developer';
import 'dart:typed_data';
import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/function/image_picker.dart';
import 'package:chatter/screens/widget/sigin_login_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileScreen extends StatefulWidget {
  final snap;
  const ProfileScreen({super.key, required this.snap});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

final usernameController = TextEditingController();
final bioController = TextEditingController();
final emailController = TextEditingController();

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? image;
  final _formKey = GlobalKey<FormState>();

  FirebaseStorage _storage = FirebaseStorage.instance;
  bool isUpdating = false;
  @override
  Widget build(BuildContext context) {
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(widget.snap['uid']);
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
                                  child: widget.snap['uid'] ==
                                          FirebaseAuth.instance.currentUser!.uid
                                      ? CircleAvatar(
                                          backgroundColor:
                                              Colors.grey.withOpacity(0.9),
                                          child: const Icon(
                                            Icons.add_a_photo,
                                            color: textBlack,
                                          ),
                                        )
                                      : const SizedBox(),
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
                  // const Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     SearchIcon(icon: Icons.message_outlined, size: 25),
                  //     SearchIcon(icon: Icons.videocam_outlined, size: 25),
                  //     SearchIcon(icon: Icons.phone_outlined, size: 25),
                  //     SearchIcon(icon: Icons.more_horiz, size: 25),
                  //   ],
                  // ),
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
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                kHeight20,
                                TextFormField(
                                  controller: usernameController,
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
                                TextFormField(
                                  controller: bioController,
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
                                TextFormField(
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
                                widget.snap['uid'] ==
                                        FirebaseAuth.instance.currentUser!.uid
                                    ? InkWell(
                                        borderRadius: BorderRadius.circular(32),
                                        onTap: updateProfile,
                                        child: isUpdating
                                            ? Center(
                                                child: LoadingAnimationWidget
                                                    .discreteCircle(
                                                        color: Colors.black,
                                                        size: 30),
                                              )
                                            : const SiginAndLoginBUtton(
                                                text: 'Add',
                                                size: 20,
                                              ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
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

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      image = im;
    });
  }

  Future<void> updateProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isUpdating = true; // Show the circular progress indicator
      });
      final newUsername = usernameController.text.trim();
      final newBio = bioController.text.trim();
      //final newEmail = emailController.text.trim();
      final currentUsername = widget.snap['username'];
      final currentBio = widget.snap['bio'];
      //final currentEmail = widget.snap['email'];
      final currentImageUrl = widget.snap['photoUrl'];

      // Upload the image if an image is selected
      try {
        String? imageUrl;
        if (image != null) {
          final Reference storageRef = _storage
              .ref()
              .child('profile_images')
              .child('${widget.snap['uid']}.jpg');
          final UploadTask uploadTask = storageRef.putData(image!);
          final TaskSnapshot taskSnapshot = await uploadTask;
          imageUrl = await taskSnapshot.ref.getDownloadURL();
        }
        // String imageUrl =
        //     await StorageMethods().uploadImageToStorage('photo', image!, false);
        // Update the user's profile in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.snap['uid'])
            .update({
          'username': newUsername.isNotEmpty ? newUsername : currentUsername,
          'bio': newBio.isNotEmpty ? newBio : currentBio,
          // 'email': newEmail,
          'photoUrl': imageUrl ?? currentImageUrl,
        });
        log('Profile updated successfully');
      } catch (e) {
        log('Error updating profile: $e');
      } finally {
        setState(() {
          isUpdating = false;
        });
      }
    }
  }
}
