import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teman_jalan/screens/buatjalandetail.dart';
import 'package:teman_jalan/screens/persetujuanbuatjalan.dart';
import 'package:teman_jalan/utilities/alertmessage.dart';
import 'package:teman_jalan/utilities/colors.dart';
import 'package:teman_jalan/utilities/range.dart';

class ScanKTP extends StatefulWidget {
  const ScanKTP({super.key, required this.lastEmail});
  final String lastEmail;
  @override
  State<ScanKTP> createState() => _ScanKTPState();
}

class _ScanKTPState extends State<ScanKTP> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final noKTPController = TextEditingController();

  FocusNode nodeButtonNext = FocusNode();

  bool isProcess = false;

  @override
  void initState() {
    //HttpOverrides.global = new MyHttpOverrides();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
  }

  bool validateAndSave() {
    final form = formkey.currentState;

    // if (emailController.text == '' || emailController.text.isEmpty) {
    //   var dialog = const CustomAlertDialog(
    //       type: 4, title: "Information", message: "Please input your email");
    //   showDialog(context: context, builder: (BuildContext context) => dialog);
    //   return false;
    // } else if (passwordController.text == '' ||
    //     passwordController.text.isEmpty) {
    //   var dialog = const CustomAlertDialog(
    //       type: 4, title: "Information", message: "Please input your password");
    //   showDialog(context: context, builder: (BuildContext context) => dialog);
    //   return false;
    // }
    if (form!.validate()) {
      form.save();

      return true;
    }
    return false;
  }

  Future<void> nextAction() async {
    try {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PersetujuanBuatJalan()),
      );
    } catch (e) {
      CustomAlertDialog(type: 2, title: "Error", message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (popDisposition) => false,
      child: Scaffold(
        key: scaffoldkey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(0.0, MediaQuery.of(context).size.height * 0.1),
          child: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.07,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => BuatJalanDetail(
                        lastEmail: widget.lastEmail,
                      ),
                    ),
                    (route) => false);
              },
            ),
            title: const Text(
              "Konfirmasi Sebagai Travel Agent",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: sizeMd * 1.2,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w700),
            ),
            centerTitle: true,
          ),
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Form(
            key: formkey,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: sizeXl * 1.4, vertical: 0.0),
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: sizeSm),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Scan KTP Kamu untuk jadi Travel Agent',
                            style: TextStyle(
                                fontSize: sizeLg * 1.1,
                                fontFamily: 'Josefin Sans',
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: sizeSm * 0.8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: sizeSm),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Kami akan memastikan data diri lengkap kalian aman dan kami hanya menggunakan untuk keperluan Teman Jalan saja',
                            style: TextStyle(
                                fontSize: sizeMd,
                                fontFamily: 'Josefin Sans',
                                color: greyText),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: sizeSm),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: sizeSm, vertical: sizeXl),
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              'assets/images/scanKTP.png',
                              width: 300,
                              height: 300,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: sizeSm, vertical: sizeSm),
                    child: ElevatedButton(
                      onPressed: () {
                        if (validateAndSave()) {
                          setState(() {
                            isProcess = true;
                          });

                          nextAction();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0.0),
                          backgroundColor: primaryBlue),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.03),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.05, //55,
                        child: const Align(
                          child: Text(
                            'Lanjut',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.2,
                              fontSize: sizeMd,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Urbanist',
                            ),
                          ),
                        ),
                      ),
                    ),
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
