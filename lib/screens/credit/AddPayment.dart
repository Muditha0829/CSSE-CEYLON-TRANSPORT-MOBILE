import 'package:bus_ticketing_system/models/PaymentModel.dart';
import 'package:bus_ticketing_system/screens/credit/PaymentList.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPayment extends StatefulWidget {
  const AddPayment({Key? key}) : super(key: key);

  @override
  State<AddPayment> createState() => _CrudAppState();
}

class _CrudAppState extends State<AddPayment> {

  final nameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final double textBorder = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Payment"),
      ),
      backgroundColor: Colors.white70,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          const Center(child: Text("Create a Payment")),
          const SizedBox(height: 40),
          const Text("Cardholder's Name:"),
          const SizedBox(height: 10),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Enter Cardholder Name',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(textBorder))),

            ),
          ),
          const SizedBox(height: 20),
          const Text("Card Number:"),
          const SizedBox(height: 10),
          TextField(
            controller: cardNumberController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Enter Card Number',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          const Text("Payment Amount:"),
          const SizedBox(height: 10),
          TextField(
            controller: amountController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Enter Payment Amount',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          const Text("Payment Date:"),
          const SizedBox(height: 10),
          TextField(
            controller: dateController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Enter Payment Date',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          const Text("Payment Time:"),
          const SizedBox(height: 10),
          TextField(
            controller: timeController,
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Enter Payment Time',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(textBorder))),
            ),
            keyboardType: TextInputType.number,
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

              createPayment(
                name: nameController.text,
                cardNumber: cardNumberController.text,
                amount: amountController.text,
                date: '10/11/2022',
                time: '9.15',
              );
            },
            child: const Text('Confirm', style: TextStyle(fontSize: 18)),
          )
        ],
      ),
    );
  }

  showMessage(message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  goToPage(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return const PaymentList();
    }));
  }

  Future<dynamic> createPayment({
    required String name,
    required String cardNumber,
    required String amount,
    required String date,
    required String time
  }) async {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);

    String pattern2 = r'\d';
    RegExp regExp2 = RegExp(pattern2);

    if (name == '' || cardNumber == '' || amount == '') {
      showMessage('Please fill Out Required Fields');
    } else {
      final docPayment = FirebaseFirestore.instance.collection('payment').doc();

      final payment = PaymentModel(
          id: docPayment.id,
          name: name,
          cardNumber: cardNumber,
          amount: amount,
          date: date,
          time: time
      );

      final json = payment.toJson();

      await docPayment.set(json);

      showMessage('Payment Added Successfully');

      goToPage();
    }
  }
}
