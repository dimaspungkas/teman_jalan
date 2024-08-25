import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:teman_jalan/screens/buatjalandetail.dart';
import 'package:teman_jalan/utilities/alertmessage.dart';
import 'package:teman_jalan/utilities/colors.dart';
import 'package:teman_jalan/utilities/range.dart';

class BuatJalan extends StatefulWidget {
  const BuatJalan({super.key, required this.lastEmail});
  final String lastEmail;
  @override
  State<BuatJalan> createState() => _BuatJalanState();
}

class _BuatJalanState extends State<BuatJalan> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final namaTripController = TextEditingController();
  final kuotaTripController = TextEditingController();
  final satuanKuotaController = TextEditingController();
  final titikTemuController = TextEditingController();
  final titikPulangController = TextEditingController();
  final tanggalBerangkatController = TextEditingController();
  final tanggalPulangController = TextEditingController();
  final tipeTripController = TextEditingController();
  final noHPController = TextEditingController();
  final deskripsiTripController = TextEditingController();
  final uploadImageController = TextEditingController();

  FocusNode nodeNamaTrip = FocusNode();
  FocusNode nodeKuotaTrip = FocusNode();
  FocusNode nodeSatuanKuota = FocusNode();
  FocusNode nodeTitikTemu = FocusNode();
  FocusNode nodeTitikPulang = FocusNode();
  FocusNode nodeTanggalBerangkat = FocusNode();
  FocusNode nodeTanggalPulang = FocusNode();
  FocusNode nodeTipeTrip = FocusNode();
  FocusNode nodeNoHP = FocusNode();
  FocusNode nodeDeskripsi = FocusNode();
  FocusNode nodeButtonNext = FocusNode();

  bool isProcess = false;
  bool isUploading = false;

  final DateTime _selectedDate1 = DateTime.now();
  final DateTime _selectedDate2 = DateTime.now();
  int? selectedOption = 1;

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
        MaterialPageRoute(
            builder: (context) => const BuatJalanDetail(lastEmail: "")),
      );
    } catch (e) {
      CustomAlertDialog(type: 2, title: "Error", message: e.toString());
    }
  }

  Future<void> _selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Initial date of the picker
      firstDate: DateTime(2000), // The earliest date the picker can show
      lastDate: DateTime(2101), // The latest date the picker can show
    );
    if (picked != null && picked != _selectedDate1) {
      setState(() {
        tanggalBerangkatController.text =
            DateFormat('yyyy-MM-dd').format(picked.toLocal());
      });
    }
  }

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Initial date of the picker
      firstDate: DateTime(2000), // The earliest date the picker can show
      lastDate: DateTime(2101), // The latest date the picker can show
    );
    if (picked != null && picked != _selectedDate2) {
      setState(() {
        tanggalPulangController.text =
            DateFormat('yyyy-MM-dd').format(picked.toLocal());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (popDisposition) => false,
      child: Scaffold(
        key: scaffoldkey,
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Form(
            key: formkey,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 0.0),
                  height: MediaQuery.of(context).size.height * 0.66,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      children: <Widget>[
                        // Upload Image
                        Container(
                          height: 210,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.grey.shade100,
                                Colors.grey.shade300,
                                Colors.grey.shade400,
                                Colors.grey.shade500,
                              ],
                              stops: const [0.1, 0.3, 0.6, 0.8],
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(0.0),
                                  backgroundColor: Colors.white),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.01),
                                width: 180,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                                height: MediaQuery.of(context).size.height *
                                    0.05, //55,
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Unggah Gambar',
                                    style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 0.2,
                                      fontSize: sizeSm * 1.2,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Urbanist',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        // Nama Trip
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: namaTripController,
                            focusNode: nodeNamaTrip,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Arial',
                                fontSize: sizeMd),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white54.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: secondBlue, width: 1.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: sizeSm),
                              hintText: 'Nama Trip',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Body/Font Family',
                                  fontSize: sizeMd),
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(nodeKuotaTrip);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        // Kuota Trip
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: kuotaTripController,
                            focusNode: nodeKuotaTrip,
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Arial',
                                fontSize: sizeMd),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white54.withOpacity(0.5),
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: secondBlue, width: 1.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: sizeSm),
                              hintText: 'Kuota Trip',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Body/Font Family',
                                  fontSize: sizeMd),
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(nodeSatuanKuota);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        // Satuan Kuota Trip
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: satuanKuotaController,
                            focusNode: nodeSatuanKuota,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Arial',
                                fontSize: sizeMd),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white54.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: secondBlue, width: 1.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: sizeSm),
                              hintText: 'Satuan Kuota Trip',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Body/Font Family',
                                  fontSize: sizeMd),
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(nodeTitikTemu);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        // Titik Temu
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: titikTemuController,
                            focusNode: nodeTitikTemu,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Arial',
                                fontSize: sizeMd),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white54.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: secondBlue, width: 1.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: sizeSm),
                              hintText: 'Titik Temu',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Body/Font Family',
                                  fontSize: sizeMd),
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(nodeTitikPulang);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        // Titik Pulang
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: titikPulangController,
                            focusNode: nodeTitikPulang,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Arial',
                                fontSize: sizeMd),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white54.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: secondBlue, width: 1.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: sizeSm),
                              hintText: 'Titik Pulang',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Body/Font Family',
                                  fontSize: sizeMd),
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(nodeTanggalBerangkat);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        // Tanggal Berangkat
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: tanggalBerangkatController,
                            focusNode: nodeTanggalBerangkat,
                            readOnly: true,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Arial',
                                fontSize: sizeMd),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white54.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: secondBlue, width: 1.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: sizeSm),
                              hintText: 'Tanggal Berangkat',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Body/Font Family',
                                  fontSize: sizeMd),
                            ),
                            onTap: () => _selectDate1(context),
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(nodeTanggalPulang);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        // Tanggal Pulang
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: tanggalPulangController,
                            focusNode: nodeTanggalPulang,
                            readOnly: true,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Arial',
                                fontSize: sizeMd),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white54.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: secondBlue, width: 1.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: sizeSm),
                              hintText: 'Tanggal Pulang',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Body/Font Family',
                                  fontSize: sizeMd),
                            ),
                            onTap: () => _selectDate2(context),
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(nodeTipeTrip);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        // Tipe Trip
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                minTileHeight: sizeSm,
                                titleAlignment: ListTileTitleAlignment.center,
                                horizontalTitleGap: 4,
                                title: const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  verticalDirection: VerticalDirection.down,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Mandiri',
                                        style: TextStyle(
                                            fontSize: sizeMd,
                                            fontFamily: 'Body/Font Family'),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Buat Trip Sendiri',
                                        style: TextStyle(
                                            fontSize: sizeSm * 0.8,
                                            fontFamily: 'Body/Font Family',
                                            color: greyText),
                                      ),
                                    ),
                                  ],
                                ),
                                leading: Radio<int>(
                                  value: 1,
                                  activeColor: primaryBlue,
                                  groupValue: selectedOption,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOption = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                minTileHeight: sizeSm,
                                titleAlignment: ListTileTitleAlignment.center,
                                horizontalTitleGap: 4,
                                title: const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  verticalDirection: VerticalDirection.down,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Kolaborasi',
                                        style: TextStyle(
                                            fontSize: sizeMd,
                                            fontFamily: 'Body/Font Family'),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Bareng Destinasi Pilihan',
                                        style: TextStyle(
                                            fontSize: sizeSm * 0.8,
                                            fontFamily: 'Body/Font Family',
                                            color: greyText),
                                      ),
                                    ),
                                  ],
                                ),
                                leading: Radio<int>(
                                  value: 2,
                                  activeColor: primaryBlue,
                                  groupValue: selectedOption,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOption = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ), // Nama Lengkap
                        const SizedBox(height: sizeSm),
                        // No. Hp
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: noHPController,
                            focusNode: nodeNoHP,
                            keyboardType: TextInputType.text,
                            maxLength: 14,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Arial',
                                fontSize: sizeMd),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white54.withOpacity(0.5),
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: secondBlue, width: 1.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: sizeSm),
                              hintText: 'No. HP',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Body/Font Family',
                                  fontSize: sizeMd),
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(nodeDeskripsi);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        // Deskripsi Trip
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: deskripsiTripController,
                            focusNode: nodeDeskripsi,
                            keyboardType: TextInputType.text,
                            maxLines: 4,
                            maxLength: 500,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Arial',
                                fontSize: sizeMd),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white54.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: secondBlue, width: 1.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: sizeSm, vertical: sizeSm),
                              hintText: 'Deskripsi Trip',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Body/Font Family',
                                  fontSize: sizeMd),
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(nodeButtonNext);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: sizeSm * 0.5, vertical: sizeXxl),
                    child: ElevatedButton(
                      onPressed: () {
                        if (validateAndSave()) {
                          setState(() {
                            isProcess = true;
                          });

                          nextAction();
                        }
                      },
                      focusNode: nodeButtonNext,
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
