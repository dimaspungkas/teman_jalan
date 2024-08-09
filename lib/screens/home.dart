import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teman_jalan/utilities/range.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.lastEmail});
  final String lastEmail;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final myEmailController = TextEditingController();
  final myPasswordController = TextEditingController();

  FocusNode nodeEmail = FocusNode();
  FocusNode nodePassword = FocusNode();

  bool hidePassword = true;

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
                  height: MediaQuery.of(context).size.height * 0.55,
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
                  child:
                      Image.asset('assets/images/Login.png', fit: BoxFit.cover),
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
                    const SizedBox(height: sizeXxl),
                    Text(
                      'HALO TEMAN JALAN!',
                      style: TextStyle(
                        color: Colors.blue[900],
                        //Color.fromRGBO(0, 0, 118, 2),
                        fontFamily: 'Josefin Sans',
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: sizeXl),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: sizeSm),
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        controller: myEmailController,
                        focusNode: nodeEmail,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontFamily: 'Arial',
                            fontSize: sizeMd),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white54.withOpacity(0.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Color(0x002743FD),
                                width: 1.0), // Border color and width
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
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.03),
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        controller: myPasswordController,
                        focusNode: nodePassword,
                        obscureText: hidePassword,
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontFamily: 'Arial',
                            fontSize: sizeMd),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white54.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Color(0x002743FD),
                                width: 1.0), // Border color and width
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
                                decorationColor: Colors.blue,
                                decorationThickness: 2,
                                fontSize: 18,
                                color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.03),
                      child: ElevatedButton(
                        onPressed: () {
                          // if (validateAndSave()) {
                          //   setState(() {
                          //     isApiCallProcess = true;
                          //   });

                          //   loginAction();
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(0.0),
                            backgroundColor: const Color(0xFF54ADFF)),
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
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.03),
                      child: ElevatedButton(
                        onPressed: () {
                          // if (validateAndSave()) {
                          //   setState(() {
                          //     isApiCallProcess = true;
                          //   });

                          //   loginAction();
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(0.0),
                            backgroundColor: const Color(0xFF3c2d63)),
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
