import 'package:bus_ticketing_system/models/PaymentModel.dart';
import 'package:bus_ticketing_system/screens/credit/AddPayment.dart';
import 'package:bus_ticketing_system/screens/credit/ViewPayment.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentList extends StatefulWidget {
  const PaymentList({Key? key}) : super(key: key);

  @override
  State<PaymentList> createState() => _UserListState();
}

class _UserListState extends State<PaymentList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment List"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const AddPayment();
                }));
              },
              icon: const Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder<List<PaymentModel>>(
        stream: readPayments(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            final payments = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
              children: payments.map(buildPayment).toList(),
            );
          }else if(snapshot.hasError){
            if (kDebugMode) {
              print('Error --> ${snapshot.error}');
            }
            return const Center(
              child: Text("Oops Something Went Wrong..."),
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          }
        },
      ),
      backgroundColor: Colors.green,
    );
  }

  Widget buildPayment(PaymentModel payment) {

    var borderRadius = const BorderRadius.all(Radius.circular(18));
    const double ft = 19;

    return Column(
      children: [
        const SizedBox(height: 10),
        ListTile(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          selectedTileColor: Colors.teal,
          selected: true,
          title: Column(
            children: [
              Row(
                children: [
                  const SizedBox(height: 7),
                  Text(
                      payment.name,
                      style: const TextStyle(color: Colors.white, fontSize: ft)
                  ),
                  const Spacer(),
                  Text(
                      'Rs. ${payment.amount}.00',
                      style: const TextStyle(color: Colors.white, fontSize: ft)
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    'Date: ${payment.date}',
                    style: const TextStyle(color: Colors.white, fontSize: ft)
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                      'Time: ${payment.time}',
                      style: const TextStyle(color: Colors.white, fontSize: ft)
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                          return ViewPayment(payment.id);
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        backgroundColor: Colors.green
                      ),
                      child: const Text("Show")
                  ),
                ],
              ),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return ViewPayment(payment.id);
            }));
          },
        )
      ],
    );
  }


  Stream<List<PaymentModel>> readPayments() => FirebaseFirestore.instance
      .collection('payment')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) =>
              PaymentModel.fromJson(doc.data()),
          ).toList(),
      );
}
