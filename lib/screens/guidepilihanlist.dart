import 'package:flutter/material.dart';
import 'package:teman_jalan/screens/home.dart';

class GuideListScreen extends StatelessWidget {
  final lastEmailController = TextEditingController();
  final List<GuideData> guides = [
    GuideData("Yusri", "Batam", "Guide OverPower", "Rp 350,000.00 / Hari"),
    GuideData("Beyu", "Lombok", "Guide Meta", "Rp 450,000.00 / Hari"),
    GuideData("Bima", "Jakarta", "Guide OverPower", "Rp 450,000.00 / Hari"),
    GuideData("Willy", "Lombok", "Guide Newbie", "Rp 550,000.00 / Hari"),
    GuideData("Boby", "Papua", "Guide Platinum", "Rp 2,000,000.00 / Minggu"),
    GuideData("Yayar", "Batam", "Guide Master", "Rp 2,000,000.00 / Minggu"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(
                    lastEmail: "",
                    selectedMenu: 0,
                  ),
                ),
                (route) => false);
          },
        ),
        title: Row(
          children: [
            Text(
              'Cari List Kamu',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: guides.length,
              itemBuilder: (context, index) {
                return GuideListItem(
                  guide: guides[index],
                  lastEmail: lastEmailController.text,
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Text(
                'View 1,221 Trip',
                style: TextStyle(
                  color: Colors.purple[800],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          BottomNavigationBar(
            backgroundColor: Colors.blue[300],
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: '',
              ),
            ],
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
          ),
        ],
      ),
    );
  }
}

class GuideListItem extends StatelessWidget {
  const GuideListItem(
      {super.key, required this.lastEmail, required this.guide});
  final GuideData guide;
  final String lastEmail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.person_outline, color: Colors.grey[600]),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      guide.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    Text(
                      guide.location,
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(Icons.location_on, color: Colors.red, size: 20),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  guide.title,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Text(
                  guide.rate,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GuideData {
  final String name;
  final String location;
  final String title;
  final String rate;

  GuideData(this.name, this.location, this.title, this.rate);
}
