import 'package:flutter/material.dart';

class Slippage extends StatefulWidget {
  const Slippage({super.key});

  @override
  State<Slippage> createState() => _SlippageState();
}

class _SlippageState extends State<Slippage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("สลิปเงินฝาก"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "ค้นหา",
                    labelStyle: TextStyle(
                      color: Colors.green.shade700,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.green.shade700,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
