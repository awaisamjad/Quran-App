// ignore_for_file: sort_child_properties_last, library_private_types_in_public_api, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:material_text_fields/utils/form_validation.dart';
import 'package:Quran/home_page.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Quran/signup-login/log_in_page.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:facebook_auth/facebook_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage();

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isPasswordVisible = false; // Password isnt visible by default
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  //~ Function to check if user name is valid
  // Function to check if the username is valid
bool isUsernameValid(String username) {
  // Ensures all lowercase, at least one number, more than 8 characters long, and allows underscores
  RegExp pattern = RegExp(r'^(?=.*[a-z])(?=.*\d)[a-z\d_]{8,}$');
  return pattern.hasMatch(username);
}

//~ Function to check if the username is clean (no profanity)
bool isUsernameClean(String username) {
  final filter = ProfanityFilter();
  return !filter.hasProfanity(username);
}

//~ Function to check if the username already exists#
//! needs work
Future<bool> doesUsernameExist(String username) async {
  final QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance
          .collection('users') // Change this to your actual collection name
          .where('username', isEqualTo: username)
          .get();

  return querySnapshot.docs.isNotEmpty;
}

  //~ Function to check if email already exists
  Future<bool> doesEmailExist(String email) async {
    List<String> signInMethods =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    return signInMethods.isNotEmpty;
  }

  //~ Function to sign up a user with the provided username, email, and password
  Future<void> signUpUser(
      String username, String email, String password) async {
    try {
      if (!isUsernameValid(username)) {
        final snackBar = SnackBar(
          content: Text(
            "Invalid username format. Does it meet these requirements: Ensures all lowercase, at least one number, more than 8 characters long, and no spaces.",
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return; // Return early if username is invalid
      }

      if (!isUsernameClean(username)) {
        final snackBar = SnackBar(
          content: Text("Username contains inappropriate content."),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return; // Return early if username contains profanity
      }

      if (await doesUsernameExist(username)) {
        final snackBar = SnackBar(
          content: Text("Username already exists."),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return; // Return early if username already exists
      }

      if (await doesEmailExist(email)) {
        final snackBar = SnackBar(
          content: Text("Email is already registered."),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return; // Return early if email is already registered
      }

      // Call your sign-up function here using username, email, and password
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the current user after successful sign-up
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Update user's display name with the provided username
        await user.updateDisplayName(username);

        // After updating display name, navigate to the home page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Handle error if user is null
        throw Exception("An error occurred during sign-up.");
      }
    } catch (e) {
      // Display error message to the user
      final snackBar = SnackBar(
        content: Text("Error: ${e.toString()}"),
        duration: Duration(seconds: 20),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 185, 228, 198),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Quran App",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Assalamu Alaikum",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 40),
                //~ Instructions
                // Text(
                //   "Sign up",
                //   style: TextStyle(
                //     fontSize: 24,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.green,
                //   ),
                // ),
                SizedBox(height: 40),
                //~ Username
                MaterialTextField(
                  keyboardType: TextInputType.text,
                  hint: 'Username',
                  textInputAction: TextInputAction.next,
                  controller: _usernameTextController,
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: FormValidation.requiredTextField,
                  onChanged: (text) {
                    print('Username: $text');
                  },
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  labelText: 'Username', // Change this to your desired label
                  theme: FilledOrOutlinedTextTheme(
                    fillColor: Colors.green.withAlpha(50),
                    radius: 12,
                  ),
                ),
                SizedBox(height: 20),

                //~ Email
                MaterialTextField(
                  keyboardType: TextInputType.emailAddress,
                  hint: 'Email',
                  textInputAction: TextInputAction.next,
                  controller: _emailTextController,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: FormValidation.emailTextField,
                  onChanged: (text) {
                    print('Email: $text');
                  },
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  labelText: 'Email', // Change this to your desired label
                  theme: FilledOrOutlinedTextTheme(
                    fillColor: Colors.green.withAlpha(50),
                    radius: 12,
                  ),
                ),
                SizedBox(height: 20),

                //~ Password
                MaterialTextField(
                  keyboardType: TextInputType.text,
                  hint: 'Password',
                  textInputAction: TextInputAction.done,
                  obscureText: !_isPasswordVisible,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                  theme: FilledOrOutlinedTextTheme(
                    fillColor: Colors.green.withAlpha(50),
                    radius: 12,
                  ),
                  prefixIcon: Icon(Icons.lock_outline),
                  controller: _passwordTextController,
                  validator: FormValidation.requiredTextField,
                ),
                SizedBox(height: 40),

                //~ Sign Up Button
                ElevatedButton(
                  onPressed: () {
                    final username = _usernameTextController.text;
                    final email = _emailTextController.text;
                    final password = _passwordTextController.text;

                    signUpUser(username, email, password);
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Or',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 30),
                //~ Social Media Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Handle Facebook sign-in logic here
                        // For example, you can call a function to initiate Facebook sign-in
                        // signInWithFacebook();
                      },
                      child: Icon(FontAwesomeIcons.facebook,
                          color: Colors.green, size: 32),
                    ),
                    SizedBox(width: 40),
                    GestureDetector(
                      onTap: () {
                        // Handle Google sign-in logic here
                        // For example, you can call a function to initiate Google sign-in
                        // signInWithGoogle();
                      },
                      child: Icon(FontAwesomeIcons.google,
                          color: Colors.green, size: 32),
                    ),
                    SizedBox(width: 40),
                    GestureDetector(
                      onTap: () {
                        // Handle Apple sign-in logic here
                        // For example, you can call a function to initiate Apple sign-in
                        // signInWithApple();
                      },
                      child: Icon(FontAwesomeIcons.apple,
                          color: Colors.green, size: 33),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Already have an account ? ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign in here',
                        style: TextStyle(
                          color: Colors.blue, // Change the color as you like
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LogInPage()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Not interested ?',
                        style: TextStyle(
                          color: Colors.blue, // Change the color as you like
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
