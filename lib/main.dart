import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meter Bill Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BillCalculatorScreen(),
    );
  }
}

class BillCalculatorScreen extends StatefulWidget {
  const BillCalculatorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
    const double rate1To30 = 35;
    const double rate31To50 = 50;
    const double rate51To75 = 70;
    const double rate76To100 = 90;
    const double rate101To150 = 110;
    const double rate151To200 = 120;
    const double rateAbove200 = 125;
    const double maintenanceFee = 500;

    double totalBill = 0;

    if (unit <= 30) {
      totalBill = unit * rate1To30;
    } else if (unit <= 50) {
      totalBill = (30 * rate1To30) + ((unit - 30) * rate31To50);
    } else if (unit <= 75) {
      totalBill = (30 * rate1To30) + (20 * rate31To50) + ((unit - 50) * rate51To75);
    } else if (unit <= 100) {
      totalBill = (30 * rate1To30) + (20 * rate31To50) + (25 * rate51To75) + ((unit - 75) * rate76To100);
    } else if (unit <= 150) {
      totalBill = (30 * rate1To30) + (20 * rate31To50) + (25 * rate51To75) + (25 * rate76To100) + ((unit - 100) * rate101To150);
    } else if (unit <= 200) {
      totalBill = (30 * rate1To30) + (20 * rate31To50) + (25 * rate51To75) + (25 * rate76To100) + (50 * rate101To150) + ((unit - 150) * rate151To200);
    } else {
      totalBill = (30 * rate1To30) + (20 * rate31To50) + (25 * rate51To75) + (25 * rate76To100) + (50 * rate101To150) + (50 * rate151To200) + ((unit - 200) * rateAbove200);
    }

    totalBill += maintenanceFee;
    return totalBill;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meter Bill Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter Units Consumed:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _unitsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter units',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBill,
              child: const Text('Calculate',
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 13, 255),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 0, 0),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey),
              ),
              child: Text(
                _result.isEmpty ? 'Enter The Number Of Units =>' : _result,
                style: const TextStyle(
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
