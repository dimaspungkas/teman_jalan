import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teman_jalan/screens/buatjalan.dart';
import 'package:teman_jalan/screens/homepage.dart';
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

  String username = "User";
  int _selectedIndex = 0;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
    if (widget.lastEmail != '') {
      myEmailController.text = widget.lastEmail;
    }
  }

  final List<Widget> _widgetOptions = <Widget>[
    const HomePageScreen(lastEmail: ""),
    const BuatJalan(lastEmail: ""),
    const Text('Gelar Tiker', style: TextStyle(fontSize: sizeMd)),
  ];

  PreferredSizeWidget? selectedIndex(BuildContext context, item) {
    if (item == 2) {
      return PreferredSize(
        preferredSize: Size(0.0, MediaQuery.of(context).size.height * 0.1),
        child: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.09,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: primaryBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          leading: IconButton(
            icon: Image.asset("assets/images/Icon_Smiles.png"),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginScreen(lastEmail: widget.lastEmail)),
                  (route) => false);
            },
          ),
          actions: [
            IconButton(
              icon: Image.asset("assets/images/Icon_Notification.png"),
              onPressed: () {
                print('Notifications icon pressed');
              },
            ),
            IconButton(
              icon: Image.asset(
                "assets/images/Icon_Settings.png",
              ),
              onPressed: () {
                print('Search icon pressed');
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size(0.0, sizeSm * 0.8),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: sizeMd, vertical: sizeSm),
                child: Text(
                  "Hi, $username! Mau Jalan Kemana Lagi?",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: sizeMd * 1.2,
                      fontFamily: 'Headline Small/Font',
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ),
      );
    } else if (item == 1) {
      return PreferredSize(
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
              _onItemTapped(1);
            },
          ),
          title: const Text(
            "Buat Trip Kamu",
            style: TextStyle(
                color: Colors.black,
                fontSize: sizeMd * 1.2,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
      );
    } else {
      return PreferredSize(
        preferredSize: Size(0.0, MediaQuery.of(context).size.height * 0.1),
        child: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.09,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: primaryBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          leading: IconButton(
            icon: Image.asset("assets/images/Icon_Smiles.png"),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginScreen(lastEmail: widget.lastEmail)),
                  (route) => false);
            },
          ),
          actions: [
            IconButton(
              icon: Image.asset("assets/images/Icon_Notification.png"),
              onPressed: () {
                print('Notifications icon pressed');
              },
            ),
            IconButton(
              icon: Image.asset(
                "assets/images/Icon_Settings.png",
              ),
              onPressed: () {
                print('Search icon pressed');
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size(0.0, sizeSm * 0.8),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: sizeMd, vertical: sizeSm),
                child: Text(
                  "Hi, $username! Mau Jalan Kemana Lagi?",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: sizeMd * 1.2,
                      fontFamily: 'Headline Small/Font',
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (popDisposition) => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: selectedIndex(context, _selectedIndex),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: sizeSm),
          alignment: Alignment.topCenter,
          child: Container(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ),
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 68.0,
              decoration: const BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: const SizedBox.shrink(),
                    label: _selectedIndex == 0 ? 'Home' : '',
                  ),
                  BottomNavigationBarItem(
                    icon: const SizedBox.shrink(),
                    label: _selectedIndex == 1 ? 'Buat Trip' : '',
                  ),
                  BottomNavigationBarItem(
                    icon: const SizedBox.shrink(),
                    label: _selectedIndex == 2 ? 'Gelar Tiker' : '',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.white,
                unselectedLabelStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: sizeMd * 0.7,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400),
                selectedLabelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: sizeMd * 0.8,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w600),
                onTap: _onItemTapped,
                iconSize: sizeLg,
              ),
            ),
            Positioned(
              top: _selectedIndex == 0 ? -40.0 : 0.0,
              left: MediaQuery.of(context).size.width / 8 - 38,
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.001,
                    horizontal: sizeLg),
                decoration: BoxDecoration(
                  color:
                      _selectedIndex == 0 ? Colors.white : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    _onItemTapped(0);
                  },
                  icon: _selectedIndex == 0
                      ? CircleAvatar(
                          radius: 24.0,
                          backgroundColor: primaryBlue,
                          child: Image.asset(
                            'assets/images/home.png',
                            fit: BoxFit.cover,
                            width: 28,
                            height: 28,
                          ),
                        )
                      : Image.asset("assets/images/home.png"),
                ),
              ),
            ),
            Positioned(
              top: _selectedIndex == 1 ? -40.0 : 0.0,
              left: MediaQuery.of(context).size.width / 3 + 12,
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.001,
                    horizontal: sizeLg),
                decoration: BoxDecoration(
                  color:
                      _selectedIndex == 1 ? Colors.white : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    _onItemTapped(1);
                  },
                  icon: _selectedIndex == 1
                      ? CircleAvatar(
                          radius: 24.0,
                          backgroundColor: primaryBlue,
                          child: Image.asset(
                            'assets/images/buat_jalan.png',
                            fit: BoxFit.cover,
                            width: 28,
                            height: 28,
                          ),
                        )
                      : Image.asset("assets/images/buat_jalan.png"),
                ),
              ),
            ),
            Positioned(
              top: _selectedIndex == 2 ? -40.0 : 0.0,
              left: MediaQuery.of(context).size.width / 1.5 + 12,
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.001,
                    horizontal: sizeLg),
                decoration: BoxDecoration(
                  color:
                      _selectedIndex == 2 ? Colors.white : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    _onItemTapped(2);
                  },
                  icon: _selectedIndex == 2
                      ? CircleAvatar(
                          radius: 24.0,
                          backgroundColor: primaryBlue,
                          child: Image.asset(
                            'assets/images/gelar_tiker.png',
                            fit: BoxFit.cover,
                            width: 28,
                            height: 28,
                          ),
                        )
                      : Image.asset("assets/images/gelar_tiker.png"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
