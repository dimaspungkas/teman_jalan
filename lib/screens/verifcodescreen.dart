import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teman_jalan/screens/security.dart';
import 'package:teman_jalan/utilities/colors.dart';
import 'package:teman_jalan/utilities/range.dart';

class VerifCode extends StatefulWidget {
  const VerifCode({super.key});
  @override
  State<VerifCode> createState() => _VerifCodeState();
}

class _VerifCodeState extends State<VerifCode> {
  String code = '';
  late Timer _timer;
  int _start = 90;

  bool isResendCode = false;

  @override
  void initState() {
    //HttpOverrides.global = new MyHttpOverrides();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  String get _formattedTime {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _onKeyTap(String value) {
    setState(() {
      if (code.length < 4) {
        code += value;
      }
    });
  }

  void _onBackspaceTap() {
    setState(() {
      if (code.isNotEmpty) {
        code = code.substring(0, code.length - 1);
      }
    });
  }

  void _onClearTap() {
    setState(() {
      code = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (popDisposition) => false,
      child: Scaffold(
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
                MaterialPageRoute(builder: (context) => const Security()),
              );
            },
          ),
          title: const Text(
            'Masukkan Kode Verifikasi SMS',
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
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: sizeSm, vertical: sizeMd),
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: sizeSm, vertical: 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Kode telah dikirimkan $_formattedTime',
                        style: const TextStyle(
                            fontSize: sizeMd,
                            fontWeight: FontWeight.w500,
                            color: primaryBlue),
                      ),
                      const SizedBox(height: sizeSm * 0.5),
                      Container(
                        padding: const EdgeInsets.only(bottom: sizeXl),
                        child: const Text(
                          'Kirim ulang',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: primaryBlue,
                              decorationThickness: 2,
                              fontSize: sizeSm,
                              color: primaryBlue),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          4,
                          (index) => _buildCodeNumberBox(
                            index < code.length ? code[index] : '',
                          ),
                        ),
                      ),
                      const SizedBox(height: sizeXxl),
                      _buildKeyboard(),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VerifCode()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0.0),
                        backgroundColor: primaryBlue),
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.03),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.05, //55,
                      child: const Align(
                        child: Text(
                          'Finish',
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
    );
  }

  Widget _buildCodeNumberBox(String number) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: Colors.transparent, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        number,
        style: const TextStyle(fontSize: sizeLg, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildKeyboard() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildKeyboardButton('1', const Icon(Icons.block)),
            _buildKeyboardButton('2', const Icon(Icons.block)),
            _buildKeyboardButton('3', const Icon(Icons.block)),
          ],
        ),
        const SizedBox(height: sizeLg),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildKeyboardButton('4', const Icon(Icons.block)),
            _buildKeyboardButton('5', const Icon(Icons.block)),
            _buildKeyboardButton('6', const Icon(Icons.block)),
          ],
        ),
        const SizedBox(height: sizeLg),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildKeyboardButton('7', const Icon(Icons.block)),
            _buildKeyboardButton('8', const Icon(Icons.block)),
            _buildKeyboardButton('9', const Icon(Icons.block)),
          ],
        ),
        const SizedBox(height: sizeLg),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildKeyboardButton('.', const Icon(Icons.block),
                onTap: _onClearTap),
            _buildKeyboardButton('0', const Icon(Icons.block)),
            _buildKeyboardButton('', const Icon(Icons.backspace),
                onTap: _onBackspaceTap),
          ],
        ),
      ],
    );
  }

  Widget _buildKeyboardButton(String label, Icon icons, {VoidCallback? onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? () => _onKeyTap(label),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 80,
          height: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          child: label == ''
              ? icons
              : Text(
                  label,
                  style: const TextStyle(
                    fontSize: sizeXl,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Josefin Sans',
                  ),
                ),
        ),
      ),
    );
  }
}
