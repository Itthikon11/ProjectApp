import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Depositpage extends StatefulWidget {
  const Depositpage({super.key});

  @override
  State<Depositpage> createState() => _DepositpageState();
}

class _DepositpageState extends State<Depositpage> {
  List<String> months = [
    'มกราคม',
    'กุมภาพันธ์',
    'มีนาคม',
    'เมษายน',
    'พฤษภาคม',
    'มิถุนายน',
    'กรกฎาคม',
    'สิงหาคม',
    'กันยายน',
    'ตุลาคม',
    'พฤศจิกายน',
    'ธันวาคม'
  ];
  String? selectedMonth;
  List<Widget> depositFields = [];
  double totalAmount = 0.0;
  List<TextEditingController> controllers = [];
  String? _idUserError;

  void addAmount(double amount) {
    setState(() {
      totalAmount = 0.0;
      for (var controller in controllers) {
        double value = double.tryParse(controller.text) ?? 0.0;
        totalAmount += value;
      }
    });
  }

  bool _isNumeric(String value) {
    return double.tryParse(value) != null;
  }

  @override
  void initState() {
    super.initState();
    addField();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ฝากเงิน"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "เลขสมาชิก"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Expanded(
                child: ListView(
              children: [
                ...depositFields,
              ],
            )),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: addField,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TotalBar(context),
    );
  }

  void addField() {
    if (depositFields.length <= 12) {
      setState(() {
        TextEditingController controller = TextEditingController();
        controllers.add(controller);

        depositFields.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: "จำนวนเงิน",
                      errorText: _idUserError,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      double amount = double.tryParse(value) ?? 0.0;
                      addAmount(amount);
                      setState(() {
                        _idUserError = _isNumeric(value) ? null : "กรุณาใส่ตัวเลขเท่านั้น";
                      });
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedMonth,
                    decoration: InputDecoration(
                      labelText: 'เลือกเดือน',
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMonth = newValue;
                      });
                    },
                    items: months.map<DropdownMenuItem<String>>((String month) {
                      return DropdownMenuItem<String>(
                        value: month,
                        child: Text(month),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    }
  }

  Widget TotalBar(BuildContext context) {
    return Container(
      color: Colors.green,
      height: 90,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "ยอดรวม : ฿${totalAmount.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "รหัสสมาชิก :",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "ชื่อสมาชิก :",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "โปรดตรวจสอบข้อมูลทุกครั้งก่อนโอน",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.red,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      content: SizedBox(
                        width: 300.0,
                        height: 300.0,
                        child: QrImageView(
                          data: 'https://chatgpt.com/',
                          version: QrVersions.auto,
                          size: 200,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("ปิด"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text("ฝากเงิน"),
            ),
          ],
        ),
      ),
    );
  }
}
