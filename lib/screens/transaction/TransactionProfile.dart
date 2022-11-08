import 'package:bus_ticketing_system/models/SingleUser.dart';
import 'package:flutter/material.dart';

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
              const Text('Name:  ', style: TextStyle(fontSize: 22, color: Colors.blue)),
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
                child: ListView(
                  children: [
                    TextField(
                      controller: amountController,
                      decoration: const InputDecoration(hintText: 'Start Destination', labelText: 'Start Destination'),
                      keyboardType: TextInputType.text,
                    ),
                    TextField(
                      controller: amountController,
                      decoration: const InputDecoration(hintText: 'Stop Destination', labelText: 'Stop Destination'),
                      keyboardType: TextInputType.text,
                    ),
                    TextField(
                      controller: amountController,
                      decoration: const InputDecoration(hintText: 'Enter Amount', labelText: 'Amount'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                )
              )
            ],
          ),
        ],
      )
    );
  }
}
