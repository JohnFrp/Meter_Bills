import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meter Bill Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BillCalculatorScreen(),
    );
  }
}

class BillCalculatorScreen extends StatefulWidget {
  const BillCalculatorScreen({Key? key}) : super(key: key);

  @override
  _BillCalculatorScreenState createState() => _BillCalculatorScreenState();
}

class _BillCalculatorScreenState extends State<BillCalculatorScreen> {
  final TextEditingController _unitsController = TextEditingController();
  String _result = "";

  void _calculateBill() {
  final String unitsText = _unitsController.text.trim();
  
  if (unitsText.isEmpty) {
    // Handle empty input case
    setState(() {
      _result = 'Please Enter A Units Value.';
    });
    return;
  }

  final int units = int.tryParse(unitsText) ?? 0;
  final double bill = _calculateTotalBill(units);
  final formatter = NumberFormat('#,###.00');

  setState(() {
    _result = 'Total Bills: ${formatter.format(bill)} Kyats';
  });
}


  double _calculateTotalBill(int unit) {
    const double RATE_1_TO_30 = 35;
    const double RATE_31_TO_50 = 50;
    const double RATE_51_TO_75 = 70;
    const double RATE_76_TO_100 = 90;
    const double RATE_101_TO_150 = 110;
    const double RATE_151_TO_200 = 120;
    const double RATE_ABOVE_200 = 125;
    const double MAINTENANCE_FEE = 500;

    double totalBill = 0;

    if (unit <= 30) {
      totalBill = unit * RATE_1_TO_30;
    } else if (unit <= 50) {
      totalBill = (30 * RATE_1_TO_30) + ((unit - 30) * RATE_31_TO_50);
    } else if (unit <= 75) {
      totalBill = (30 * RATE_1_TO_30) + (20 * RATE_31_TO_50) + ((unit - 50) * RATE_51_TO_75);
    } else if (unit <= 100) {
      totalBill = (30 * RATE_1_TO_30) + (20 * RATE_31_TO_50) + (25 * RATE_51_TO_75) + ((unit - 75) * RATE_76_TO_100);
    } else if (unit <= 150) {
      totalBill = (30 * RATE_1_TO_30) + (20 * RATE_31_TO_50) + (25 * RATE_51_TO_75) + (25 * RATE_76_TO_100) + ((unit - 100) * RATE_101_TO_150);
    } else if (unit <= 200) {
      totalBill = (30 * RATE_1_TO_30) + (20 * RATE_31_TO_50) + (25 * RATE_51_TO_75) + (25 * RATE_76_TO_100) + (50 * RATE_101_TO_150) + ((unit - 150) * RATE_151_TO_200);
    } else {
      totalBill = (30 * RATE_1_TO_30) + (20 * RATE_31_TO_50) + (25 * RATE_51_TO_75) + (25 * RATE_76_TO_100) + (50 * RATE_101_TO_150) + (50 * RATE_151_TO_200) + ((unit - 200) * RATE_ABOVE_200);
    }

    totalBill += MAINTENANCE_FEE;
    return totalBill;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meter Bill Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter Units Consumed:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _unitsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter units',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBill,
              child: Text('Calculate',
              style: TextStyle(
                  color: const Color.fromARGB(255, 0, 13, 255),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 0, 0),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey),
              ),
              child: Text(
                _result.isEmpty ? 'Enter The Number Of Units' : _result,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
