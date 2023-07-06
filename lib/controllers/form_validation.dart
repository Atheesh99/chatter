import 'package:get/get.dart';

class FormValidationLginAndSignup extends GetxController {
  var email = '';
  var username = '';
  var password = '';

  var isPasswordVisibility = true.obs;

//////////// mailvalidation
  String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email address is required';
      //charater,@,.
    } else if (!RegExp(r'^[\w.+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email)) {
      return 'Invalid email address';
    } else {
      return null;
    }
  }

////////////passwordvalidation
  String? validatePassword(String password) {
    // Check if password meets the length requirement
    if (password.isEmpty) {
      return 'Please enter a password';
    }
    if (password.length < 7) {
      return 'Password must be at least  characters';
    } // Check if password contains at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]')) &&
        !password.contains(RegExp(r'[a-z]'))) {
      return 'password containes at least one charater';
    }
    return null;
  }

  //////////  User Name Validate ///////
  String? validateUsername(String username) {
    final RegExp usernameRegex = RegExp(r"^[a-zA-Z]+([_ -]?[a-zA-Z])*$");
    if (username.isEmpty) {
      return "Username is required";
    } else if (username.length < 4) {
      return "Username must be at least 4 characters long";
    } else if (username.length > 20) {
      return "Username must be less than 20 characters long";
    } //uppercase,lowercase,_,-,white space after charter
    else if (!usernameRegex.hasMatch(username)) {
      return "Invalid username format";
    } else {
      return null;
    }
  }

// Validate all fields on button press
  bool validateForm() {
    final emailError = validateEmail(email);
    final usernameError = validateUsername(username);
    final passwordError = validatePassword(password);

    // Display validation errors if any
    if (emailError != null) {
      Get.snackbar('Error', emailError);
      return false;
    } else if (usernameError != null) {
      Get.snackbar('Error', usernameError);
      return false;
    } else if (passwordError != null) {
      Get.snackbar('Error', passwordError);
      return false;
    }

    // All fields are valid
    return true;
  }
}
