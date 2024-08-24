import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:teman_jalan/utilities/colors.dart';
import 'package:teman_jalan/utilities/range.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key, required this.lastEmail});
  final String lastEmail;
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final myEmailController = TextEditingController();

  FocusNode nodePassword = FocusNode();

  String username = "User";

  final List<Map<String, String>> imgWishlist = [
    {'title': 'Title 1', 'img': 'assets/images/Default_Image.png'},
    {'title': 'Title 2', 'img': 'assets/images/Default_Image.png'},
    {'title': 'Title 3', 'img': 'assets/images/Default_Image.png'},
    {'title': 'Title 4', 'img': 'assets/images/Default_Image.png'},
    {'title': 'Title 5', 'img': 'assets/images/Default_Image.png'},
  ];

  final List<Map<String, String>> imgCeritaJalan = [
    {
      'title': 'Title 1',
      'desc': 'Tips and Trick buat lu yang mau ke Title 1',
      'img': 'assets/images/Default_Image.png'
    },
    {
      'title': 'Title 2',
      'desc': 'Tips and Trick buat lu yang mau ke Title 2',
      'img': 'assets/images/Default_Image.png'
    },
    {
      'title': 'Title 3',
      'desc': 'Tips and Trick buat lu yang mau ke Title 3',
      'img': 'assets/images/Default_Image.png'
    },
  ];

  final List<Map<String, dynamic>> imgItemJalan = [
    {
      'title': 'Title 1',
      'price': 1100000,
      'img': 'assets/images/Default_Image.png'
    },
    {
      'title': 'Title 2',
      'price': 4200000,
      'img': 'assets/images/Default_Image.png'
    },
    {
      'title': 'Title 2',
      'price': 600000,
      'img': 'assets/images/Default_Image.png'
    },
  ];

  final List<Map<String, dynamic>> imgCariTemanJalan = [
    {
      'title': 'Title 1',
      'desc': 'Ketemuan di Title 1',
      'price': 600000,
      'total': 9,
      'quota': 10,
      'img': 'assets/images/Default_Image.png'
    },
    {
      'title': 'Title 2',
      'desc': 'Ketemuan di Title 2',
      'price': 3500000,
      'total': 3,
      'quota': 15,
      'img': 'assets/images/Default_Image.png'
    },
  ];

  final List<Map<String, String>> imgPilihGuide = [
    {'title': 'Title 1 - Title 1', 'img': 'assets/images/Default_Image.png'},
    {'title': 'Title 2 - Title 2', 'img': 'assets/images/Default_Image.png'},
    {'title': 'Title 3 - Title 3', 'img': 'assets/images/Default_Image.png'},
    {'title': 'Title 4 - Title 4', 'img': 'assets/images/Default_Image.png'},
    {'title': 'Title 5 - Title 5', 'img': 'assets/images/Default_Image.png'},
  ];

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

  String formatCurrency(double amount) {
    final NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id_ID', // Indonesian locale
      symbol: 'Rp', // Currency symbol
      decimalDigits: 2, // No decimal points for Rupiah
    );
    return currencyFormatter.format(amount);
  }

  Widget buildWhislist(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: sizeSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 11,
                  child: Text(
                    "Check Wishlist Favorit Kamu",
                    style: TextStyle(fontSize: sizeMd * 1.2),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(Icons.arrow_forward),
                )
              ],
            ),
          ),
          const SizedBox(height: sizeSm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            height: 136,
            child: ListView.builder(
              scrollDirection:
                  Axis.horizontal, // Scroll direction set to horizontal
              itemCount: imgWishlist.length,
              itemBuilder: (context, index) {
                return Container(
                    margin: const EdgeInsets.only(right: 12.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 0.8),
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(imgWishlist[index]['img']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        Text(
                          imgWishlist[index]['title']!,
                          style: const TextStyle(fontSize: sizeMd),
                        ),
                      ],
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCeritaJalan(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: sizeSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 11,
                  child: Text(
                    "Semua Cerita perjalanan ada disini !",
                    style: TextStyle(fontSize: sizeMd * 1.2),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(Icons.arrow_forward),
                )
              ],
            ),
          ),
          const SizedBox(height: sizeSm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            height: 254,
            child: ListView.builder(
              scrollDirection:
                  Axis.horizontal, // Scroll direction set to horizontal
              itemCount: imgCeritaJalan.length,
              itemBuilder: (context, index) {
                return Container(
                    margin: const EdgeInsets.only(right: 12.0),
                    width: 320,
                    height: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          width: 320,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            image: DecorationImage(
                              image: AssetImage(imgCeritaJalan[index]['img']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: sizeSm),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex: 11,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        imgCeritaJalan[index]['title']!,
                                        style:
                                            const TextStyle(fontSize: sizeMd),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        imgCeritaJalan[index]['desc']!,
                                        style:
                                            const TextStyle(fontSize: sizeSm),
                                      ),
                                    ),
                                  ],
                                )),
                            const Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.play_circle_rounded,
                                fill: 1.0,
                                color: Colors.red,
                                size: sizeXl,
                              ),
                            )
                          ],
                        ),
                      ],
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItemJalan(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: sizeSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 11,
                  child: Text(
                    "Item Buat Nemenin Perjalanan Kamu !",
                    style: TextStyle(fontSize: sizeMd * 1.2),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(Icons.arrow_forward),
                )
              ],
            ),
          ),
          const SizedBox(height: sizeSm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            height: 190,
            child: ListView.builder(
              scrollDirection:
                  Axis.horizontal, // Scroll direction set to horizontal
              itemCount: imgItemJalan.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 12.0),
                  width: 134,
                  height: 190,
                  decoration: const BoxDecoration(
                    color: primaryBlue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(0.0),
                          width: 116,
                          height: 119,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            image: DecorationImage(
                              image: AssetImage(imgItemJalan[index]['img']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: sizeSm * 0.5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            imgItemJalan[index]['title']!,
                            style: const TextStyle(
                                fontSize: sizeMd,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Title Small/Font'),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            formatCurrency(
                                imgItemJalan[index]['price'].toDouble()),
                            style: const TextStyle(fontSize: sizeSm),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCariTemanJalan(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: sizeSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 11,
                  child: Text(
                    "Cari Temen Jalan Sekarang !",
                    style: TextStyle(fontSize: sizeMd * 1.2),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(Icons.arrow_forward),
                )
              ],
            ),
          ),
          const SizedBox(height: sizeSm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            height: 270,
            child: ListView.builder(
              scrollDirection:
                  Axis.vertical, // Scroll direction set to horizontal
              itemCount: imgCariTemanJalan.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  width: 400,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: primaryBlue,
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            ),
                            image: DecorationImage(
                              image:
                                  AssetImage(imgCariTemanJalan[index]['img']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: sizeSm),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      imgCariTemanJalan[index]['title']!,
                                      style: const TextStyle(fontSize: sizeLg),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      imgCariTemanJalan[index]['desc']!,
                                      style: const TextStyle(
                                          fontSize: sizeSm, color: greyText),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.black87,
                                  ),
                                  const SizedBox(width: 4),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      formatCurrency(imgCariTemanJalan[index]
                                              ['price']
                                          .toDouble()),
                                      style: const TextStyle(
                                          fontSize: sizeSm, color: greyText),
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  const Icon(
                                    Icons.circle,
                                    size: 4.0,
                                    color: greyText,
                                  ),
                                  const SizedBox(width: 2),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      '${imgCariTemanJalan[index]['total']}/${imgCariTemanJalan[index]['quota']} orang',
                                      style: const TextStyle(
                                          fontSize: sizeSm, color: greyText),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPilihGuide(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: sizeSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/Default_Image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: sizeSm),
                const Expanded(
                  flex: 11,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Guide Pilihan",
                          style: TextStyle(fontSize: sizeSm, color: greyText),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Pilih Guide buat pandu kamu",
                          style: TextStyle(fontSize: sizeMd),
                        ),
                      )
                    ],
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Icon(Icons.arrow_forward),
                )
              ],
            ),
          ),
          const SizedBox(height: sizeSm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            height: 152,
            child: ListView.builder(
              scrollDirection:
                  Axis.horizontal, // Scroll direction set to horizontal
              itemCount: imgPilihGuide.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 4.0),
                  height: 148,
                  child: Container(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(0.0),
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            ),
                            image: DecorationImage(
                              image: AssetImage(imgPilihGuide[index]['img']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: sizeSm * 0.5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            imgPilihGuide[index]['title']!,
                            style: const TextStyle(
                                fontSize: sizeMd,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Title Small/Font'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Wishlist
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: buildWhislist(context),
            ),
            // Cerita Jalan
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: buildCeritaJalan(context),
            ),
            // Item Teman Jalan
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: buildItemJalan(context),
            ),
            // Cari Teman Jalan
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: buildCariTemanJalan(context),
            ),
            // Pilih Guide
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: buildPilihGuide(context),
            ),
          ],
        ),
      ),
    );
  }
}
