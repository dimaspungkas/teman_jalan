import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teman_jalan/screens/login.dart';
import 'package:teman_jalan/utilities/colors.dart';
import 'package:teman_jalan/utilities/range.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.lastEmail});
  final String lastEmail;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final myEmailController = TextEditingController();

  FocusNode nodePassword = FocusNode();

  String username = "";

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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.07,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: primaryBlue,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.account_circle_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LoginScreen(lastEmail: widget.lastEmail)),
              );
            },
          ),
          title: Text("Hi, $username! Mau Jalan Kemana Lagi?",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: sizeMd,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w900)),
        ),
      ),
    );
  }
}
