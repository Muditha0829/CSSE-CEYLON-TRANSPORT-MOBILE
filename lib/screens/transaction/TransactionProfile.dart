import 'package:bus_ticketing_system/models/SingleUser.dart';
import 'package:bus_ticketing_system/models/TransactionModel.dart';
import 'package:bus_ticketing_system/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionProfile extends StatefulWidget {

  final SingleUser singleUser;

  const TransactionProfile(this.singleUser, {Key? key,}) : super(key: key);

  @override
  State<TransactionProfile> createState() => _TransactionProfileState();
}

class _TransactionProfileState extends State<TransactionProfile> {

  final amountController = TextEditingController();
  final startController = TextEditingController();
  final stopController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const Home();
                }));
              },
              icon: const Icon(Icons.home),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const Center(
            child: Text('Payment Page', style: TextStyle(fontSize: 30, color: Colors.blueGrey)),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const Text('Name:  ', style: TextStyle(fontSize: 22, color: Colors.blue)),
              Text(widget.singleUser.fullName, style: const TextStyle(fontSize: 22, color: Colors.blueAccent)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const Text('Amount:  ', style: TextStyle(fontSize: 22, color: Colors.blue)),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: startController,
                  decoration: const InputDecoration(hintText: 'Start Destination', labelText: 'Start Destination'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const Text('Amount:  ', style: TextStyle(fontSize: 22, color: Colors.blue)),
              SizedBox(
                width: 300,
                child:  TextField(
                  controller: stopController,
                  decoration: const InputDecoration(hintText: 'Stop Destination', labelText: 'Stop Destination'),
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const Text('Amount:  ', style: TextStyle(fontSize: 22, color: Colors.blue)),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: amountController,
                  decoration: const InputDecoration(hintText: 'Enter Amount', labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                createTransaction(
                    start: startController.text,
                    stop: stopController.text,
                    amount: int.parse(amountController.text),
                );
              },
              child: const Text('Pay'),
            ),
          )
        ],
      )
    );
  }

  Future<dynamic> createTransaction({required String start, required String stop, required int amount}) async{
    final transaction = FirebaseFirestore.instance.collection('transaction').doc();

    final transactionProfile = TransactionModel(
        id: transaction.id,
        start: start,
        stop: stop,
        amount: amount,
        passengerId: widget.singleUser.uid,
    );

    final json = transactionProfile.toJson();

    await transaction.set(json);
  }
}
