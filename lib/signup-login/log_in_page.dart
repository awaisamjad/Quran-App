// ignore_for_file: sort_child_properties_last, library_private_types_in_public_api, use_build_context_synchronously, no_leading_underscores_for_local_identifiers
import 'package:facebook_auth/facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:material_text_fields/utils/form_validation.dart';
import 'package:Quran/home_page.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Quran/signup-login/sign_up_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
class LogInPage extends StatefulWidget {
  const LogInPage();

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  //~ Function to check if username already exists
  Future<bool> doesEmailExist(String email) async {
    List<String> signInMethods =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    return signInMethods.isNotEmpty;
  }

//~ Function to check if password matches the provided email
  Future<bool> doesPasswordMatch(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      return false;
    }
  }
  //~ Function to sign in user with Google
  Future<void> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuth = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    }
  } catch (error) {
    print("Google sign-in error: $error");
  }
}

//~ Function to sign in user with Apple
Future<void> signInWithApple() async {
  try {
    final result = await SignInWithApple.getAppleIDCredential(
      scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
    );
    
    final AuthCredential credential = OAuthProvider("apple.com").credential(
      idToken: result.identityToken,
      accessToken: result.authorizationCode,
    );
    
    await FirebaseAuth.instance.signInWithCredential(credential);
  } catch (error) {
    print("Apple sign-in error: $error");
  }
}
//~ Function to sign in user with Facebook
// Future<void> signInWithFacebook() async {
//   try {
//     final result = await FacebookAuth.instance.login();
//     final AuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
//     await FirebaseAuth.instance.signInWithCredential(credential);
//   } catch (error) {
//     print("Facebook sign-in error: $error");
//   }
// }




//~ Function to sign in user with the provided email and password
  Future<void> signInUser(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        final snackBar = SnackBar(
            content: Text("Please enter both email and password."),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return; // Return early if either field is empty
      }

      if (!await doesEmailExist(email)) {
        final snackBar = SnackBar(
          content: Text("Email is not registered."),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return; // Return early if email is not registered
      }

      if (!await doesPasswordMatch(email, password)) {
        final snackBar = SnackBar(
            content: Text("Password is incorrect."),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return; // Return early if password is incorrect
      }

      //~ After successful password match, navigate to the home page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      final snackBar = SnackBar(
          content: Text("Something went wrong."),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  bool _isPasswordVisible = false; // Password isnt visible by default
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 185, 228, 198),
       body: 
      StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //? If the user is logged in, navigate to the home page
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return HomePage();
          } else if (snapshot.hasError) {
            return Center(child: Text('Something went wrong!'));
          } else {
            return 
            SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80,
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
                        "Log in",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 40),
                      //~ Email text field
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

                      //~ Password text field
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

                      //~ Login button
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          final email = _emailTextController.text;
                          final password = _passwordTextController.text;

                          signInUser(email, password);
                        },
                        child: Text(
                          'Log in',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
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
                      //~ Social media Buttons
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
                              signInWithGoogle();
                            },
                            child: Icon(FontAwesomeIcons.google,
                                color: Colors.green, size: 32),
                          ),
                          SizedBox(width: 40),
                          GestureDetector(
                            onTap: () {
                              signInWithApple();
                            },
                            child: Icon(FontAwesomeIcons.apple,
                                color: Colors.green, size: 33),
                          ),
                        ],
                      ),

                      SizedBox(height: 30),
                      //~ Text to navigate to the sign up page
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't have an account ? ",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                              ),
                            ),
                            TextSpan(
                              text: 'Register here',
                              style: TextStyle(
                                color:
                                    Colors.blue, // Change the color as you like
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpPage()),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      //~ Text to navigate to the home page if user is not interested
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Not interested ?',
                              style: TextStyle(
                                color:
                                    Colors.blue, // Change the color as you like
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
            );
          }
        }
      )
    );
  }
}