import 'dart:typed_data';

import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/controllers/form_validation.dart';
import 'package:chatter/function/authendication/signup.dart';
import 'package:chatter/function/image_picker.dart';
import 'package:chatter/screens/main_screen/main_screen.dart';
import 'package:chatter/screens/widget/already_password.dart';
import 'package:chatter/screens/widget/custom_form_field.dart';
import 'package:chatter/screens/widget/image_login_text.dart';
import 'package:chatter/screens/widget/sigin_login_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController nameControler = TextEditingController();

  TextEditingController emailControler = TextEditingController();

  TextEditingController bioControler = TextEditingController();

  TextEditingController passwordControler = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  Uint8List? image;
  final controller = Get.put(FormValidationLginAndSignup());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundwhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 22, right: 22, top: 20),
          child: Column(
            children: [
              const ImageLoginText(
                  height: 0.30,
                  imagepath: 'assets/signup_img.jpg',
                  text: 'Register',
                  title: 'Please register to login'),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          ////////////////////////////////////image feacturing
                          image != null
                              ? CircleAvatar(
                                  backgroundImage: MemoryImage(image!),
                                )
                              : const CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/avatr_person.png"),
                                  radius: 60,
                                ),

                          Positioned(
                            bottom: -10,
                            right: -25,
                            child: GestureDetector(
                              onTap: selectImage,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.withOpacity(0.9),
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
                    CustomformField(
                        onSave: (value) {
                          controller.username = value!;
                        },
                        validator: (value) {
                          return controller.validateUsername(value!);
                        },
                        hide: false,
                        text: 'User Name',
                        keyboardType: TextInputType.name,
                        prefixIcon: Icons.person_outline_outlined,
                        controller: nameControler),
                    kHeight20,
                    CustomformField(
                        onSave: (value) {
                          controller.email = value!.trim();
                        },
                        validator: (value) {
                          return controller.validateEmail(value!);
                        },
                        hide: false,
                        text: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email_outlined,
                        controller: emailControler),
                    kHeight20,
                    CustomformField(
                      onSave: (value) {
                        controller.username = value!;
                      },
                      // validator: (value) {
                      //   return controller.validateUsername(value!);
                      // },
                      hide: false,
                      text: 'Bio',
                      keyboardType: TextInputType.name,
                      prefixIcon: Icons.smart_toy_outlined,
                      controller: bioControler,
                    ),
                    kHeight20,
                    Obx(
                      () => CustomformField(
                        onSave: (value) {
                          controller.password = value!;
                        },
                        validator: (value) {
                          return controller.validatePassword(value!);
                        },
                        ontap: () {
                          controller.isPasswordVisibility.value =
                              !controller.isPasswordVisibility.value;
                        },
                        hide: controller.isPasswordVisibility.value,
                        text: 'Password',
                        suffixIcon1: Icons.visibility_off_rounded,
                        suffixIcon2: Icons.visibility_outlined,
                        prefixIcon: Icons.lock_outlined,
                        controller: passwordControler,
                      ),
                    ),
                    kHeight30,
                    _isLoading
                        ? Center(
                            child: LoadingAnimationWidget.discreteCircle(
                                color: Colors.black, size: 50),
                          )
                        : GestureDetector(
                            onTap: signUpUser,
                            child: const SiginAndLoginBUtton(
                              text: 'Create an account',
                              size: 18,
                            ),
                          ),
                    kHeight30,
                    const AlreadyAccountLogin(
                        text: 'Already have an account ? ',
                        title: 'Login',
                        color1: textBlack,
                        color2: textBlack),
                    kHeight30,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
      email: emailControler.text,
      password: passwordControler.text,
      username: nameControler.text,
      bio: bioControler.text,
      file: image!,
    );
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      Get.offAll(() => const MainScreen());
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      image = im;
    });
  }
}
