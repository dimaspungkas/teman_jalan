import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:teman_jalan/screens/home.dart';
import 'package:teman_jalan/screens/scanktp.dart';
import 'package:teman_jalan/utilities/alertmessage.dart';
import 'package:teman_jalan/utilities/colors.dart';
import 'package:teman_jalan/utilities/range.dart';

class BuatJalanDetail extends StatefulWidget {
  const BuatJalanDetail({super.key, required this.lastEmail});
  final String lastEmail;
  @override
  State<BuatJalanDetail> createState() => _BuatJalanDetailState();
}

class _BuatJalanDetailState extends State<BuatJalanDetail> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final kolaborasiController = TextEditingController();
  final namaTempatController = TextEditingController();
  final totalBiayaKolaborasiController = TextEditingController();
  final biayaKonsumsiController = TextEditingController();
  final biayaJasaTripController = TextEditingController();
  final totalBiayaTripController = TextEditingController();
  final cbPotongJasaController = TextEditingController();
  final jumlahDiskonController = TextEditingController();
  final tanggalAwalDiskonController = TextEditingController();
  final tanggalAkhirDiskonController = TextEditingController();

  FocusNode nodeNamaTempat = FocusNode();
  FocusNode nodeKolaborasi = FocusNode();
  FocusNode nodeTotalBiayaKolaborasi = FocusNode();
  FocusNode nodeBiayaKonsumsi = FocusNode();
  FocusNode nodeBiayaJasaTrip = FocusNode();
  FocusNode nodeTotalBiayaTrip = FocusNode();
  FocusNode nodeCBPotongJasa = FocusNode();
  FocusNode nodeJumlahDiskon = FocusNode();
  FocusNode nodeTanggalAwalDiskon = FocusNode();
  FocusNode nodeTanggalAkhirDiskon = FocusNode();
  FocusNode nodeButtonNext = FocusNode();

  bool isProcess = false;
  bool _isCheckedKolaborasi = false;
  bool _isCheckedDiskon = false;
  bool _isTransportBerangkat = false;
  bool _isTransportPulang = false;
  bool _isMakanPagi = false;
  bool _isMakanSiang = false;
  bool _isMakanMalam = false;
  bool _isCemilan = false;
  bool _isTiketMasuk = false;
  bool _isPenginapan = false;
  bool _isOleholeh = false;

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
            builder: (context) => ScanKTP(
                  lastEmail: widget.lastEmail,
                )),
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

  String formatCurrency(double amount) {
    final NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id_ID', // Indonesian locale
      symbol: 'Rp', // Currency symbol
      decimalDigits: 2, // No decimal points for Rupiah
    );
    return currencyFormatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (popDisposition) => false,
      child: Scaffold(
        key: scaffoldkey,
        resizeToAvoidBottomInset: false,
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
                      builder: (context) => HomeScreen(
                        lastEmail: widget.lastEmail,
                        selectedMenu: 1,
                      ),
                    ),
                    (route) => false);
              },
            ),
            title: const Text(
              "Detail Trip Kamu",
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
                      horizontal: sizeSm * 0.5, vertical: 0.0),
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      children: <Widget>[
                        // Kolaborasi
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
                                title: const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  verticalDirection: VerticalDirection.down,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Wisata',
                                        style: TextStyle(
                                            fontSize: sizeMd,
                                            fontFamily: 'Body/Font Family'),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Klik Detail',
                                        style: TextStyle(
                                            fontSize: sizeSm * 0.8,
                                            fontFamily: 'Body/Font Family',
                                            color: greyText),
                                      ),
                                    ),
                                  ],
                                ),
                                leading: Checkbox(
                                  value: _isCheckedKolaborasi,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isCheckedKolaborasi = value!;
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
                                  controller: namaTempatController,
                                  focusNode: nodeNamaTempat,
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
                                    hintText: 'Nama Tempat',
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
                        // Total Biaya Kolaborasi
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: totalBiayaKolaborasiController,
                            focusNode: nodeTotalBiayaKolaborasi,
                            keyboardType: TextInputType.number,
                            readOnly: true,
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
                              hintText: 'Total Biaya Kolaborasi',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Body/Font Family',
                                  fontSize: sizeMd),
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(nodeBiayaKonsumsi);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        // Biaya Konsumsi
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: biayaKonsumsiController,
                            focusNode: nodeBiayaKonsumsi,
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
                              hintText: 'Biaya Konsumsi',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Body/Font Family',
                                  fontSize: sizeMd),
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(nodeBiayaJasaTrip);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        // Biaya Jasa Trip
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: biayaJasaTripController,
                            focusNode: nodeBiayaJasaTrip,
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
                              hintText: 'Biaya Jasa Trip',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Body/Font Family',
                                  fontSize: sizeMd),
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(nodeCBPotongJasa);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        // Total Biaya Trip
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: totalBiayaTripController,
                            focusNode: nodeTotalBiayaTrip,
                            keyboardType: TextInputType.number,
                            readOnly: true,
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
                              hintText: 'Total Biaya Trip',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Body/Font Family',
                                  fontSize: sizeMd),
                            ),
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        // Diskon Trip
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
                                title: const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  verticalDirection: VerticalDirection.down,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Diskon',
                                        style: TextStyle(
                                            fontSize: sizeMd,
                                            fontFamily: 'Body/Font Family'),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Dipotong dari Jasa',
                                        style: TextStyle(
                                            fontSize: sizeSm * 0.8,
                                            fontFamily: 'Body/Font Family',
                                            color: greyText),
                                      ),
                                    ),
                                  ],
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
                              flex: 4,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: sizeSm),
                                alignment: Alignment.centerLeft,
                                child: TextFormField(
                                  controller: jumlahDiskonController,
                                  focusNode: nodeJumlahDiskon,
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
                              //FocusScope.of(context).requestFocus(nodeTipeTrip);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        // Checkbox
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                minTileHeight: sizeSm,
                                titleAlignment: ListTileTitleAlignment.center,
                                horizontalTitleGap: 4,
                                title: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Transportasi Berangkat',
                                    style: TextStyle(
                                        fontSize: sizeMd,
                                        fontFamily: 'Body/Font Family'),
                                  ),
                                ),
                                leading: Checkbox(
                                  value: _isTransportBerangkat,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isTransportBerangkat = value!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                minTileHeight: sizeSm,
                                titleAlignment: ListTileTitleAlignment.center,
                                horizontalTitleGap: 4,
                                title: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Transportasi Pulang',
                                    style: TextStyle(
                                        fontSize: sizeMd,
                                        fontFamily: 'Body/Font Family'),
                                  ),
                                ),
                                leading: Checkbox(
                                  value: _isTransportPulang,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isTransportPulang = value!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                minTileHeight: sizeSm,
                                titleAlignment: ListTileTitleAlignment.center,
                                horizontalTitleGap: 4,
                                title: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Makan Pagi',
                                    style: TextStyle(
                                        fontSize: sizeMd,
                                        fontFamily: 'Body/Font Family'),
                                  ),
                                ),
                                leading: Checkbox(
                                  value: _isMakanPagi,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isMakanPagi = value!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                minTileHeight: sizeSm,
                                titleAlignment: ListTileTitleAlignment.center,
                                horizontalTitleGap: 4,
                                title: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Makan Siang',
                                    style: TextStyle(
                                        fontSize: sizeMd,
                                        fontFamily: 'Body/Font Family'),
                                  ),
                                ),
                                leading: Checkbox(
                                  value: _isMakanSiang,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isMakanSiang = value!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                minTileHeight: sizeSm,
                                titleAlignment: ListTileTitleAlignment.center,
                                horizontalTitleGap: 4,
                                title: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Makan Malam',
                                    style: TextStyle(
                                        fontSize: sizeMd,
                                        fontFamily: 'Body/Font Family'),
                                  ),
                                ),
                                leading: Checkbox(
                                  value: _isMakanMalam,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isMakanMalam = value!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                minTileHeight: sizeSm,
                                titleAlignment: ListTileTitleAlignment.center,
                                horizontalTitleGap: 4,
                                title: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Cemilan',
                                    style: TextStyle(
                                        fontSize: sizeMd,
                                        fontFamily: 'Body/Font Family'),
                                  ),
                                ),
                                leading: Checkbox(
                                  value: _isCemilan,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isCemilan = value!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                minTileHeight: sizeSm,
                                titleAlignment: ListTileTitleAlignment.center,
                                horizontalTitleGap: 4,
                                title: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Tiket Masuk Tujuan',
                                    style: TextStyle(
                                        fontSize: sizeMd,
                                        fontFamily: 'Body/Font Family'),
                                  ),
                                ),
                                leading: Checkbox(
                                  value: _isTiketMasuk,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isTiketMasuk = value!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                minTileHeight: sizeSm,
                                titleAlignment: ListTileTitleAlignment.center,
                                horizontalTitleGap: 4,
                                title: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Penginapan',
                                    style: TextStyle(
                                        fontSize: sizeMd,
                                        fontFamily: 'Body/Font Family'),
                                  ),
                                ),
                                leading: Checkbox(
                                  value: _isPenginapan,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isPenginapan = value!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                minTileHeight: sizeSm,
                                titleAlignment: ListTileTitleAlignment.center,
                                horizontalTitleGap: 4,
                                title: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Oleh-oleh',
                                    style: TextStyle(
                                        fontSize: sizeMd,
                                        fontFamily: 'Body/Font Family'),
                                  ),
                                ),
                                leading: Checkbox(
                                  value: _isOleholeh,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isOleholeh = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
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
