import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teman_jalan/screens/home.dart';
import 'package:teman_jalan/screens/signup.dart';
import 'package:teman_jalan/utilities/range.dart';
import 'package:teman_jalan/utilities/colors.dart';
import 'package:teman_jalan/utilities/alertmessage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.lastEmail});
  final String lastEmail;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final myEmailController = TextEditingController();
  final myPasswordController = TextEditingController();

  FocusNode nodeEmail = FocusNode();
  FocusNode nodePassword = FocusNode();

  bool hidePassword = true;
  bool isProcess = false;

  @override
  void initState() {
    //HttpOverrides.global = new MyHttpOverrides();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
    if (widget.lastEmail != '') {
      myEmailController.text = widget.lastEmail;
    }
  }

  bool validateAndSave() {
    final form = formkey.currentState;

    if (myEmailController.text == '' || myEmailController.text.isEmpty) {
      var dialog = const CustomAlertDialog(
          type: 4, title: "Information", message: "Please input your email");
      showDialog(context: context, builder: (BuildContext context) => dialog);
      return false;
    } else if (myPasswordController.text == '' ||
        myPasswordController.text.isEmpty) {
      var dialog = const CustomAlertDialog(
          type: 4, title: "Information", message: "Please input your password");
      showDialog(context: context, builder: (BuildContext context) => dialog);
      return false;
    }
    if (form!.validate()) {
      form.save();

      return true;
    }
    return false;
  }

  Future<void> loginAction() async {
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(lastEmail: widget.lastEmail)),
      );
    } catch (e) {
      CustomAlertDialog(type: 2, title: "Error", message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Form(
          key: formkey,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.only(top: sizeXl),
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.grey.shade50,
                        Colors.grey.shade50,
                        Colors.grey.shade50,
                        Colors.grey.shade50,
                      ],
                      stops: const [0.1, 0.3, 0.6, 0.8],
                    ),
                  ),
                  child: Image.asset('assets/images/bg-login.png',
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: sizeMd, vertical: sizeXl),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    const SizedBox(height: sizeXxl * 2.5),
                    // Text(
                    //   'HALO TEMAN JALAN!',
                    //   style: TextStyle(
                    //     color: primaryBlue,
                    //     fontFamily: 'Josefin Sans',
                    //     fontSize: MediaQuery.of(context).size.width * 0.08,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: sizeSm),
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        controller: myEmailController,
                        focusNode: nodeEmail,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Arial',
                            fontSize: sizeMd),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white54.withOpacity(0.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: secondBlue, width: 1.0),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          hintText: 'Email',
                          hintStyle: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Josefin Sans',
                              fontSize: sizeMd),
                        ),
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(nodePassword);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          final emailRegExp = RegExp(
                            r'^[^@]+@[^@]+\.[^@]+$',
                            caseSensitive: false,
                          );
                          if (!emailRegExp.hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: sizeMd),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: sizeSm),
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        controller: myPasswordController,
                        focusNode: nodePassword,
                        obscureText: hidePassword,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Arial',
                            fontSize: sizeMd),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white54.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: secondBlue, width: 1.0),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.4),
                            icon: Icon(hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Josefin Sans',
                              fontSize: sizeMd),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          print('TextButton clicked');
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: primaryBlue,
                                decorationThickness: 2,
                                fontSize: 18,
                                color: primaryBlue),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: sizeSm),
                      child: ElevatedButton(
                        onPressed: () {
                          if (validateAndSave()) {
                            setState(() {
                              isProcess = true;
                            });

                            loginAction();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(0.0),
                            backgroundColor: primaryBlue),
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.03),
                          width: MediaQuery.of(context).size.width,
                          height:
                              MediaQuery.of(context).size.height * 0.05, //55,
                          child: const Align(
                              child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.2,
                              fontSize: sizeMd,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Urbanist',
                            ),
                          )),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: sizeSm),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(0.0),
                            backgroundColor: primaryPurple),
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width *
                                  0.03), //EdgeInsets.fromLTRB(20, 10, 20, 10),
                          width: MediaQuery.of(context).size.width,
                          height:
                              MediaQuery.of(context).size.height * 0.05, //55,
                          child: const Align(
                              child: Text(
                            'Daftar',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.2,
                              fontSize: sizeMd,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Urbanist',
                            ),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
