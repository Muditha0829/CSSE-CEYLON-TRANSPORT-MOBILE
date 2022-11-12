
import 'package:bus_ticketing_system/models/PaymentModel.dart';
import 'package:bus_ticketing_system/screens/credit/PaymentList.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ViewPayment extends StatefulWidget {

  final String paymentId;

  const ViewPayment(this.paymentId, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ViewPayment> createState() => _UpdateUserState(paymentId);
}

class _UpdateUserState extends State<ViewPayment> {

  String paymentId;
  final nameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  _UpdateUserState(this.paymentId);

  late PaymentModel paymentData;
  late DocumentReference<Map<String, dynamic>> singlePayment;
  final double textBorder = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Payment"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {

            },
          ),
        ],
      ),
      backgroundColor: Colors.teal,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          const Center(child: Text("View a Single Payment")),
          const SizedBox(height: 40),
          const Text("Cardholder's Name:"),
          const SizedBox(height: 10),
          TextField(
            readOnly: true,
            controller: nameController,
            decoration: InputDecoration(
              hintText: '',
              labelText: '',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(textBorder))),

            ),
          ),
          const SizedBox(height: 20),
          const Text("Card Number:"),
          const SizedBox(height: 10),
          TextField(
            readOnly: true,
            controller: cardNumberController,
            decoration: InputDecoration(
              hintText: '',
              labelText: '',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
          ),
          const SizedBox(height: 24),
          const Text("Payment Amount:"),
          const SizedBox(height: 10),
          TextField(
            readOnly: true,
            controller: amountController,
            decoration: InputDecoration(
              hintText: '',
              labelText: '',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
          ),
          const SizedBox(height: 24),
          const Text("Payment Date:"),
          const SizedBox(height: 10),
          TextField(
            readOnly: true,
            controller: dateController,
            decoration: InputDecoration(
              hintText: '',
              labelText: '',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
          ),
          const SizedBox(height: 24),
          const Text("Payment Time:"),
          const SizedBox(height: 10),
          TextField(
            readOnly: true,
            controller: timeController,
            decoration: InputDecoration(
              hintText: '',
              labelText: '',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              shadowColor: Colors.blueAccent,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              minimumSize: const Size(50, 50),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_){
                return const PaymentList();
              }));
            },
            child: const Text('Back', style: TextStyle(fontSize: 18)),
          ),
          const SizedBox(height: 24),
          // ElevatedButton(
          //   onPressed: () {
          //     showDialog(
          //         context: context,
          //         builder: (context) => alertBox(),
          //     );
          //   },
          //   child: const Text('Delete Donation'),
          // ),
        ],
      ),
    );
  }


  @override
  void initState() {
    readPayment();
    super.initState();
  }

  readPayment() async {
    singlePayment =
        FirebaseFirestore.instance.collection('payment').doc(paymentId);

    print(paymentId);

    final DocumentSnapshot<Map<String, dynamic>> snapshot;

    try {
      snapshot = await singlePayment.get();

      if (snapshot.exists) {
        paymentData = PaymentModel.fromJson(snapshot.data()!);
        nameController.text = paymentData.name;
        cardNumberController.text = paymentData.cardNumber;
        amountController.text = 'Rs.${paymentData.amount}.00';
        dateController.text = paymentData.date;
        timeController.text = paymentData.time;
      } else {
        if (kDebugMode) {
          print("No data found");
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err.toString());
      }
    }
  }

}


