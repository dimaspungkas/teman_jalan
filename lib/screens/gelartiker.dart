import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:teman_jalan/utilities/alertmessage.dart';
import 'package:teman_jalan/utilities/colors.dart';
import 'package:teman_jalan/utilities/range.dart';

class GelarTiker extends StatefulWidget {
  const GelarTiker({super.key, required this.lastEmail});
  final String lastEmail;
  @override
  State<GelarTiker> createState() => _GelarTikerState();
}

class _GelarTikerState extends State<GelarTiker> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final namaItemController = TextEditingController();
  final hargaItemController = TextEditingController();
  final diskonItemController = TextEditingController();
  final tanggalAwalDiskonController = TextEditingController();
  final tanggalAkhirDiskonController = TextEditingController();
  final kategoriController = TextEditingController();
  final spesifikasiController = TextEditingController();
  final uploadImageController = TextEditingController();

  FocusNode nodeNamaItem = FocusNode();
  FocusNode nodeHargaItem = FocusNode();
  FocusNode nodeCBDiskonItem = FocusNode();
  FocusNode nodeDiskonItem = FocusNode();
  FocusNode nodeTitikPulang = FocusNode();
  FocusNode nodeTanggalAwalDiskon = FocusNode();
  FocusNode nodeTanggalAkhirDiskon = FocusNode();
  FocusNode nodeKategori = FocusNode();
  FocusNode nodeSpesifikasi = FocusNode();
  FocusNode nodeButtonSubmit = FocusNode();
  FocusNode nodeButtonList = FocusNode();

  bool isProcess = false;
  bool isUploading = false;
  bool _isCheckedDiskon = false;

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
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => const GelarTikerDetail(lastEmail: "")),
      // );
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
        tanggalAwalDiskonController.text =
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
        tanggalAkhirDiskonController.text =
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
                  height: MediaQuery.of(context).size.height * 0.6,
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
                        // Nama Item
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: namaItemController,
                            focusNode: nodeNamaItem,
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
                              hintText: 'Nama Item',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Body/Font Family',
                                  fontSize: sizeMd),
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(nodeHargaItem);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        // Harga Item
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: hargaItemController,
                            focusNode: nodeHargaItem,
                            keyboardType: TextInputType.number,
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
                              hintText: 'Kuota Trip',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Body/Font Family',
                                  fontSize: sizeMd),
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(nodeCBDiskonItem);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        // Diskon Item
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: sizeSm),
                                minTileHeight: sizeSm,
                                titleAlignment: ListTileTitleAlignment.center,
                                horizontalTitleGap: 4,
                                title: const Text(
                                  'Diskon',
                                  style: TextStyle(
                                      fontSize: sizeMd,
                                      fontFamily: 'Body/Font Family'),
                                ),
                                leading: Checkbox(
                                  value: _isCheckedDiskon,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isCheckedDiskon = value!;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: sizeSm),
                                alignment: Alignment.centerLeft,
                                child: TextFormField(
                                  controller: diskonItemController,
                                  focusNode: nodeDiskonItem,
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
                                    hintText: '% Diskon',
                                    hintStyle: const TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Body/Font Family',
                                        fontSize: sizeMd),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: sizeSm),
                        // Tanggal Awal Diskon
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: tanggalAwalDiskonController,
                            focusNode: nodeTanggalAwalDiskon,
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
                              hintText: 'Tanggal Awal Diskon',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Body/Font Family',
                                  fontSize: sizeMd),
                            ),
                            onTap: () => _selectDate1(context),
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(nodeTanggalAkhirDiskon);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        // Tanggal Akhir Diskon
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: tanggalAkhirDiskonController,
                            focusNode: nodeTanggalAkhirDiskon,
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
                              hintText: 'Tanggal Akhir Diskon',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Body/Font Family',
                                  fontSize: sizeMd),
                            ),
                            onTap: () => _selectDate2(context),
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(nodeKategori);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        // Kategori
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: kategoriController,
                            focusNode: nodeKategori,
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
                              hintText: 'Kategori',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Body/Font Family',
                                  fontSize: sizeMd),
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(nodeSpesifikasi);
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
                            controller: spesifikasiController,
                            focusNode: nodeSpesifikasi,
                            keyboardType: TextInputType.text,
                            maxLines: 3,
                            maxLength: 250,
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
                              hintText: 'Spesifikasi',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Body/Font Family',
                                  fontSize: sizeMd),
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(nodeButtonSubmit);
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
                        horizontal: sizeSm * 0.5, vertical: sizeXxl * 2.2),
                    child: ElevatedButton(
                      onPressed: () {
                        if (validateAndSave()) {
                          setState(() {
                            isProcess = true;
                          });

                          nextAction();
                        }
                      },
                      focusNode: nodeButtonSubmit,
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
                            'Submit',
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: sizeSm * 0.5, vertical: sizeXxl),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const SignUp()),
                        // );
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
                        height: MediaQuery.of(context).size.height * 0.05, //55,
                        child: const Align(
                          child: Text(
                            'List',
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
