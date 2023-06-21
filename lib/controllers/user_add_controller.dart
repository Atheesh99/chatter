// import 'dart:io';

// import 'package:chatter/function/update_user.dart';
// import 'package:chatter/main.dart';
// import 'package:chatter/model/chatuser.dart';
// import 'package:chatter/service/app_utils.dart';
// import 'package:chatter/service/permission.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';

// class UserAddConroller extends GetxController {
//   TextEditingController namecontroller = TextEditingController();
//   TextEditingController biocontroller = TextEditingController();
//   TextEditingController phonecontroller = TextEditingController();
//   var selectedImage = "".obs;
//   FirebaseAuth auth = FirebaseAuth.instance;
//   RxString nameError = RxString("");
//   RxBool isLoading = RxBool(false);
//   RxString pinError = RxString("");
//   AppPermission appPermission = AppPermission();

//   void getImage(ImageSource source) async {
//     switch (source) {
//       case ImageSource.camera:
//         File file = await imageFromCamera(true);
//         selectedImage.value == file.path;
//         break;
//       case ImageSource.gallery:
//         File file = await imageFromGallery(true);
//         selectedImage.value == file.path;
//         break;
//     }
//   }

//   void skipInfo() {
//     isLoading.value = true;
//     var userModel = UserModel(
//         uId: auth.currentUser!.uid,
//         name: auth.currentUser!.displayName ?? "",
//         email: auth.currentUser!.email ?? "",
//         image: "",
//         number: "",
//         status: "Hey chatter.....!",
//         typing: "false",
//         online: DateTime.now().toString());
//     createUser(userModel).then((value) => isLoading(false));
//     // Get.offAllNamed(Routes.DASHBAORD);
//   }

//   void uploadUserData() async {
//     if (namecontroller.text.isEmpty) {
//       nameError("Field is required");
//     } else if (selectedImage.value == "") {
//       printError(info: "Image is required");
//     } else if (biocontroller.text.isEmpty) {
//       nameError("Field is required");
//     } else {
//       nameError.value = "";
//       isLoading.value = true;

//       try {
//         String link = await uploadUserImage(
//           "profile/image",
//           auth.currentUser!.uid,
//           File(selectedImage.value),
//         );

//         var userModel = UserModel(
//           uId: auth.currentUser!.uid,
//           name: namecontroller.text.trim(),
//           email: "",
//           image: link,
//           number: "",
//           status: "Hey Chatter ..!",
//           typing: "false",
//           online: DateTime.now().toString(),
//         );

//         await createUser(userModel);
//         isLoading(false);
//         //Get.offAllNamed(Routes.DASHBAORD);
//       } catch (error) {
//         printError(info: "Error uploading photo: $error");
//         isLoading(false);
//       }
//     }
//   }

//   void showPicker(BuildContext context) {
//     Get.bottomSheet(
//         SafeArea(
//           child: Container(
//             color: Theme.of(context).backgroundColor,
//             child: Wrap(
//               children: [
//                 ListTile(
//                   leading: Icon(
//                     Icons.photo_library,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   title: const Text("Gallery"),
//                   onTap: () async {
//                     Navigator.pop(context);
//                     var status = await appPermission.isStoragePermissionOk();
//                     switch (status) {
//                       case PermissionStatus.denied:
//                         var isDenied =
//                             await Permission.storage.request().isDenied;
//                         if (isDenied) {
//                           getImage(ImageSource.gallery);
//                         } else {
//                           printError(info: "storage permission denied");
//                         }
//                         break;
//                       case PermissionStatus.granted:
//                         getImage(ImageSource.gallery);
//                         break;
//                       case PermissionStatus.restricted:
//                         printError(info: "Storage permission denied");
//                         break;
//                       case PermissionStatus.limited:
//                         printError(info: "Storage Permission denied");
//                         break;
//                       case PermissionStatus.permanentlyDenied:
//                         await openAppSettings();
//                         break;
//                       case PermissionStatus.provisional:
//                         // TODO: Handle this case.
//                         break;
//                       default:
//                         // Handle any other status (if necessary)
//                         break;
//                     }
//                   },
//                 ),
//                 ListTile(
//                     leading: Icon(
//                       Icons.photo_camera,
//                       color: Theme.of(context).primaryColor,
//                     ),
//                     title: const Text("Camera"),
//                     onTap: () async {
//                       Navigator.pop(context);
//                       var status = await appPermission.isCameraPermissionOk();
//                       switch (status) {
//                         case PermissionStatus.denied:
//                           var isDenied =
//                               await Permission.camera.request().isDenied;
//                           if (isDenied) {
//                             getImage(ImageSource.camera);
//                           } else {
//                             printError(info: "Camera Permission denied");
//                           }
//                           break;
//                         case PermissionStatus.granted:
//                           getImage(ImageSource.camera);
//                           break;
//                         case PermissionStatus.restricted:
//                           printError(info: "Camera Permission denied");
//                           break;
//                         case PermissionStatus.limited:
//                           printError(info: "Camera Permission denied");
//                           break;
//                         case PermissionStatus.permanentlyDenied:
//                           await openAppSettings();
//                           break;
//                         case PermissionStatus.provisional:
//                           // TODO: Handle this case.
//                           break;
//                         default:
//                           // Handle any other status (if necessary)
//                           break;
//                       }
//                     }),
//               ],
//             ),
//           ),
//         ),
//         backgroundColor: Theme.of(context).backgroundColor,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)));
//   }
// }
