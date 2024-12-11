import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../Home/HomePage.dart';
import '../Loan/LoanPage.dart';
import '../Savings/SavingsPage.dart';

class Percenpage extends StatefulWidget {
  const Percenpage({super.key});

  @override
  State<Percenpage> createState() => _PercenpageState();
}

class _PercenpageState extends State<Percenpage> {
  int _selectedIndex = 0;

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false,
      );
    } else if (index == 1) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Savingspage()),
            (Route<dynamic> route) => false,
      );
    } else if (index == 2) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Loanpage()),
            (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เปอร์เซ็นแบ่งจ่าย"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow("สมาชิก", 70, isPercentage: true),
            SizedBox(height: 10),
            _buildRow("กรรมการ", 15, isPercentage: true),
            SizedBox(height: 10),
            _buildRow("สาธารณูปโภค", 10, isPercentage: true),
            SizedBox(height: 10),
            _buildRow("สมทบทุน", 3, isPercentage: true),
            SizedBox(height: 10),
            _buildRow("ประกันเสียง", 2, isPercentage: true),
            SizedBox(height: 30),
            _buildRow("เปอร์เซ็นเงินกู้", 15, isPercentage: true),
          ],
        ),
      ),
      bottomNavigationBar: _buildMenuBar(),
    );
  }

  Widget _buildRow(String label, double value, {bool isPercentage = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: TextField(
            enabled: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              hintText: isPercentage
                  ? "${value.toStringAsFixed(1)}%"
                  : value.toStringAsFixed(1),
            ),
          ),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {

            });
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black, backgroundColor: Colors.yellow,
          ),
          child: Text("แก้ไข"),
        ),
      ],
    );
  }

  Widget _buildMenuBar() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GNav(
          activeColor: Colors.white,
          tabBackgroundColor: Colors.green.shade300,
          gap: 10,
          padding: EdgeInsets.all(15),
          selectedIndex: _selectedIndex,
          onTabChange: _onTabChange,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'หน้าหลัก',
            ),
            GButton(
              icon: Icons.savings,
              text: 'เงินฝาก',
            ),
            GButton(
              icon: Icons.account_balance,
              text: 'เงินกู้',
            ),
          ],
        ),
      ),
    );
  }
}
