import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>(); // ✅ Correct FormKey implementation

  moveToHome(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        changeButton = true;
      });

      await Future.delayed(Duration(seconds: 1));

      if (!mounted) return; // ✅ Fix: Prevent context issues after async call
      Navigator.pushNamed(context, MyRoutes.homeRoute);

      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 80),
          child: Form( // ✅ Wrap with Form widget
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Login Image
                Image.asset(
                  "assets/images/hey.png",
                  fit: BoxFit.contain,
                  height: 150,
                ),
                SizedBox(height: 20.0),

                // Welcome Text
                Text(
                  "Welcome $name",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      // Username Field
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter Username",
                          labelText: "Username",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Username cannot be empty";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.0),

                      // Password Field
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Enter Password",
                          labelText: "Password",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password cannot be empty";
                          } else if (value.length < 6) {
                            return "Password length should be at least 6";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30.0),

                      // Login Button with animation
                      Material(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(changeButton ? 50 : 8),
                        child: InkWell(
                          splashColor: Colors.red,
                          onTap: () => moveToHome(context),
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            width: changeButton ? 50 : 120,
                            height: 50,
                            alignment: Alignment.center,
                            child: changeButton
                                ? Icon(Icons.done, color: Colors.white)
                                : Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),

                      // Forgot Password
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Sign up Section
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


















// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/utils/routes.dart';
// import 'package:velocity_x/velocity_x.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   String name = "";
//   bool changeButton = false;
//   final _formkey = GlobalKey<FormState>();
//   moveToHome(BuildContext context) async {
//     if (_formkey.currentState?.validate() ?? false) {
//       setState(() {
//         changeButton = true;
//       });
//       await Future.delayed(Duration(seconds: 1));
//       // ignore: use_build_context_synchronously
//       await Navigator.pushNamed(context, MyRoutes.homeRoute);
//       setState(() {
//         changeButton = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: context.canvasColor,
//       child: SingleChildScrollView(
//         child: Form(
//           key: _formkey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Login Image
//               Image.asset(
//                 "assets/images/hey.png",
//                 fit: BoxFit.contain,
//                 height: 200,
//               ),
//               SizedBox(height: 20.0),
//               // Welcome Text
//               Text(
//                 "Welcome $name",
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                     vertical: 16.0, horizontal: 32.0),
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       decoration: InputDecoration(
//                         hintText: "Enter Username",
//                         labelText: "Username",
//                         enabledBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors.deepPurple), // Normal border color
//                         ),
//                         focusedBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors.deepPurple), // Focused border color
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Username cannot be empty";
//                         }
//                         return null;
//                       },
//                       onChanged: (value) {
//                         setState(() {
//                           name = value;
//                         });
//                       },
//                     ),
//                     SizedBox(height: 16.0),
//                     TextFormField(
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         hintText: "Enter Password",
//                         labelText: "Password",
//                         enabledBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors.deepPurple), // Normal border color
//                         ),
//                         focusedBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors.deepPurple), // Focused border color
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Password cannot be empty";
//                         } else if (value.length < 6) {
//                           return "Password length should be at least 6";
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 30.0),
//                     // Login Button with animation
//                     Material(
//                       color: Colors.deepPurple,
//                       borderRadius:
//                           BorderRadius.circular(changeButton ? 50 : 8),
//                       child: InkWell(
//                         splashColor: Colors.red,
//                         onTap: () => moveToHome(context),
//                         child: AnimatedContainer(
//                           duration: Duration(seconds: 1),
//                           width: changeButton ? 50 : 100,
//                           height: 50,
//                           alignment: Alignment.center,
//                           child: changeButton
//                               ? Icon(
//                                   Icons.done,
//                                   color: Colors.white,
//                                 )
//                               : Text(
//                                   "Login",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
