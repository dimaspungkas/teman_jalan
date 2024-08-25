import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teman_jalan/screens/scanktp.dart';
import 'package:teman_jalan/utilities/colors.dart';
import 'package:teman_jalan/utilities/range.dart';

class PersetujuanBuatJalan extends StatefulWidget {
  const PersetujuanBuatJalan({super.key});
  @override
  State<PersetujuanBuatJalan> createState() => _PersetujuanBuatJalanState();
}

class _PersetujuanBuatJalanState extends State<PersetujuanBuatJalan> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();

  bool isProcess = false;
  bool _isCheckedTerms = false;
  bool _isCheckedDeal = false;

  @override
  void initState() {
    //HttpOverrides.global = new MyHttpOverrides();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (popDisposition) => false,
      child: Scaffold(
        key: scaffoldkey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ScanKTP(lastEmail: "")),
              );
            },
          ),
          title: const Text(
            "Persetujuan",
            style: TextStyle(
                color: Colors.black,
                fontSize: sizeMd * 1.2,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Form(
            key: formkey,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: sizeSm, vertical: sizeSm * 0.5),
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: sizeSm, vertical: 0.0),
                    child: ListView(
                      children: <Widget>[
                        const Text(
                          '1. \t Types Of Data We Collect',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: sizeMd),
                        ),
                        const SizedBox(height: sizeSm * 0.5),
                        const Text(
                          '\u2022 \t Vehicle details: Make, model, year, and VIN for accurate service recommendations.',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: sizeMd * 0.8),
                        ),
                        const Text(
                          '\u2022 \t Contact information: Necessary for communication with mechanics and service updates.',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: sizeMd * 0.8),
                        ),
                        const Text(
                          '\u2022 \t Location data: Facilitates finding nearby repair shops and tracking service progress.',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: sizeMd * 0.8),
                        ),
                        const SizedBox(height: sizeMd),
                        const Text(
                          '2. \t Use Of Your Personal Data',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: sizeMd),
                        ),
                        const SizedBox(height: sizeSm * 0.5),
                        const Text(
                          "\u2022 \t During app installation, carefully review the permissions requested by the mechanic app. Grant only the permissions required for the app's core functionality. For instance, providing location access only when the app is active ensures better privacy",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: sizeMd * 0.8),
                        ),
                        const SizedBox(height: sizeMd),
                        const Text(
                          '3. \t Disclosure Of Your Personal Data',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: sizeMd),
                        ),
                        const SizedBox(height: sizeSm * 0.5),
                        const Text(
                          '\u2022 \t Ensure that the mechanic app uses robust encryption protocols to secure your data during transmission and storage. This safeguards your sensitive information from unauthorized access and potential breaches.',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: sizeMd * 0.8),
                        ),
                        const Text(
                          '\u2022 \t Anonymization of Data.',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: sizeMd * 0.8),
                        ),
                        const Text(
                          '\u2022 \t Mechanic app developers should employ techniques to anonymize user data whenever possible. By removing personally identifiable information, data can still be used for app improvements without compromising user privacy.',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: sizeMd * 0.8),
                        ),
                        const SizedBox(height: sizeMd),
                        const Text(
                          '4. \t Location Tracking',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: sizeMd),
                        ),
                        const SizedBox(height: sizeSm * 0.5),
                        const Text(
                          "\u2022 \t Utilize location tracking settings judiciously. Share your location only when necessary (e.g., when scheduling a service) and disable location services when not actively using the app.",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: sizeMd * 0.8),
                        ),
                        const SizedBox(height: sizeSm),
                        ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 0.0),
                          minTileHeight: sizeSm,
                          titleAlignment: ListTileTitleAlignment.center,
                          horizontalTitleGap: 4,
                          visualDensity: VisualDensity.comfortable,
                          leading: Checkbox(
                            value: _isCheckedTerms,
                            onChanged: (bool? value) {
                              setState(() {
                                _isCheckedTerms = value!;
                              });
                            },
                          ),
                          title: const Text('Saya telah membaca persetujuan'),
                        ),
                        ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 0.0),
                          visualDensity: VisualDensity.comfortable,
                          minTileHeight: sizeSm,
                          titleAlignment: ListTileTitleAlignment.center,
                          horizontalTitleGap: 4,
                          leading: Checkbox(
                            value: _isCheckedDeal,
                            onChanged: (bool? value) {
                              setState(() {
                                _isCheckedDeal = value!;
                              });
                            },
                          ),
                          title: const Text('Saya menyetujui persyaratan'),
                        ),
                      ],
                    ),
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
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const VerifCode()),
                        // );
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
                        height: MediaQuery.of(context).size.height * 0.05, //55,
                        child: const Align(
                          child: Text(
                            'Selesai',
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
