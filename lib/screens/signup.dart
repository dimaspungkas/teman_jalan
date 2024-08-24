import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:teman_jalan/screens/login.dart';
import 'package:teman_jalan/screens/security.dart';
import 'package:teman_jalan/utilities/alertmessage.dart';
import 'package:teman_jalan/utilities/colors.dart';
import 'package:teman_jalan/utilities/range.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final namaLengkapController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final tempatLahirController = TextEditingController();
  final jenisKelaminController = TextEditingController();
  final alamatController = TextEditingController();
  final noHpController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  FocusNode nodeNama = FocusNode();
  FocusNode nodeTanggalLahir = FocusNode();
  FocusNode nodeTempatLahir = FocusNode();
  FocusNode nodeJenisKelamin = FocusNode();
  FocusNode nodeAlamat = FocusNode();
  FocusNode nodeNoHP = FocusNode();
  FocusNode nodeEmail = FocusNode();
  FocusNode nodePassword = FocusNode();
  FocusNode nodeConfirmPassword = FocusNode();

  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool isProcess = false;

  DateTime _selectedDate = DateTime.now();
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
        MaterialPageRoute(builder: (context) => const Security()),
      );
    } catch (e) {
      CustomAlertDialog(type: 2, title: "Error", message: e.toString());
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Initial date of the picker
      firstDate: DateTime(2000), // The earliest date the picker can show
      lastDate: DateTime(2101), // The latest date the picker can show
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        tanggalLahirController.text =
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
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const LoginScreen(lastEmail: "")),
                  (route) => false);
            },
          ),
          title: const Text(
            "Lengkapi dan Cek Data",
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
                      horizontal: sizeSm, vertical: 0.0),
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      children: <Widget>[
                        // Tipe Pendaftar
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
                                title: const Text(
                                  'Pribadi',
                                  style: TextStyle(
                                      fontSize: sizeSm,
                                      fontFamily: 'Body/Font Family'),
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
                                title: const Text(
                                  'Organisasi / Badan',
                                  style: TextStyle(
                                      fontSize: sizeSm,
                                      fontFamily: 'Body/Font Family'),
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
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: namaLengkapController,
                            focusNode: nodeNama,
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
                              hintText: 'Nama Lengkap',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Josefin Sans',
                                  fontSize: sizeMd),
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(nodeTanggalLahir);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeMd),
                        // Tanggal Lahir
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: tanggalLahirController,
                            focusNode: nodeTanggalLahir,
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
                              hintText: 'Tanggal Lahir',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Josefin Sans',
                                  fontSize: sizeMd),
                            ),
                            onTap: () => _selectDate(context),
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(nodeTempatLahir);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeMd),
                        // Tempat Lahir
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: tempatLahirController,
                            focusNode: nodeTempatLahir,
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
                              hintText: 'Tempat Lahir',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Josefin Sans',
                                  fontSize: sizeMd),
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(nodeJenisKelamin);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeMd),
                        // Jenis Kelamin
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: jenisKelaminController,
                            focusNode: nodeJenisKelamin,
                            keyboardType: TextInputType.text,
                            maxLength: 1,
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
                              hintText: 'Jenis Kelamin (L/P)',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Josefin Sans',
                                  fontSize: sizeMd),
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(nodeAlamat);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        // Alamat
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: alamatController,
                            focusNode: nodeAlamat,
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
                              hintText: 'Alamat',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Josefin Sans',
                                  fontSize: sizeMd),
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(nodeNoHP);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        // No HP
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: noHpController,
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
                                  fontFamily: 'Josefin Sans',
                                  fontSize: sizeMd),
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(nodeEmail);
                            },
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        // Email
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: emailController,
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
                                borderSide: const BorderSide(
                                    color: secondBlue, width: 1.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: sizeSm),
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
                        // Password
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: passwordController,
                            focusNode: nodePassword,
                            obscureText: hidePassword,
                            maxLength: 20,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Arial',
                                fontSize: sizeMd),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white54.withOpacity(0.1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: secondBlue, width: 1.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: sizeSm),
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
                        const SizedBox(height: sizeSm),
                        // Confirm Password
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: sizeSm),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: confirmPasswordController,
                            focusNode: nodeConfirmPassword,
                            obscureText: hideConfirmPassword,
                            maxLength: 20,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Arial',
                                fontSize: sizeMd),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white54.withOpacity(0.1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: secondBlue, width: 1.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: sizeSm),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hideConfirmPassword = !hideConfirmPassword;
                                  });
                                },
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.4),
                                icon: Icon(hideConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                              hintText: 'Confirm Password',
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Josefin Sans',
                                  fontSize: sizeMd),
                            ),
                          ),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
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
