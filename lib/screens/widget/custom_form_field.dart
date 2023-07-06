import 'package:chatter/const/color.dart';
import 'package:chatter/controllers/form_validation.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CustomformField extends StatelessWidget {
  CustomformField(
      {Key? key,
      required this.text,
      this.keyboardType,
      required this.prefixIcon,
      this.controller,
      // required this.hide,
      this.validator,
      this.onSave,
      this.suffixIcon1,
      this.suffixIcon2,
      this.ontap,
      this.onChanged,
      required this.hide})
      : super(key: key);
  final String text;
  final TextInputType? keyboardType;
  final IconData prefixIcon;
  final IconData? suffixIcon1;
  final IconData? suffixIcon2;
  ValueChanged<String>? onChanged;

  final TextEditingController? controller;
  final bool hide;
  final String? Function(String?)? validator;
  final Function()? ontap;
  final Function(String?)? onSave;

  // final isPasswordVisibility = false.obs;

  @override
  Widget build(BuildContext context) {
    final cntrl = Get.put(FormValidationLginAndSignup());
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      onSaved: onSave,
      controller: controller,
      obscureText: hide,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        prefixIcon: Icon(
          prefixIcon,
          color: textBlack,
        ),
        suffixIcon: GestureDetector(
          onTap: ontap,
          child: Icon(
            cntrl.isPasswordVisibility.value ? suffixIcon1 : suffixIcon2,
            color: textBlack,
          ),
        ),
        labelText: text,
        labelStyle: const TextStyle(fontSize: 16, color: textBlack),
        border: normalborder(),
        focusedBorder: focusboarder(),
        enabledBorder: enabledborder(),
      ),
    );
  }

  OutlineInputBorder normalborder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    );
  }

  OutlineInputBorder enabledborder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
      borderSide: BorderSide(
        color: Colors.black45,
      ),
    );
  }

  OutlineInputBorder focusboarder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: buttonColor),
    );
  }
}
