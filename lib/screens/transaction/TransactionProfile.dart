import 'package:bus_ticketing_system/models/SingleUser.dart';
import 'package:bus_ticketing_system/models/TransactionModel.dart';
import 'package:bus_ticketing_system/screens/home/home.dart';
import 'package:flutter/foundation.dart';
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

  late SingleUser singleUser;

  late DocumentReference<Map<String, dynamic>> userData;
  final double textBorder = 20;

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
            child: Text('Payment Page', style: TextStyle(fontSize: 30, color: Colors.cyan)),
          ),
          const Image(
              image: AssetImage(
                  'assets/payment.jpg'
              )
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
                width: 340,
                child: TextField(
                  controller: startController,
                  decoration: const InputDecoration(
                      hintText: 'Start Destination',
                      labelText: 'Start Destination',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)))
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const Text('Amount:  ', style: TextStyle(fontSize: 22, color: Colors.blue)),
              SizedBox(
                width: 340,
                child:  TextField(
                  controller: stopController,
                  decoration: const InputDecoration(
                      hintText: 'Stop Destination',
                      labelText: 'Stop Destination',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)))
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const Text('Amount:  ', style: TextStyle(fontSize: 22, color: Colors.blue)),
              SizedBox(
                width: 340,
                child: TextField(
                  controller: amountController,
                  decoration: const InputDecoration(
                      hintText: 'Enter Amount',
                      labelText: 'Amount',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)))
                  ),
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
              style: ElevatedButton.styleFrom(
                primary: Colors.cyan,
                onPrimary: Colors.white,
                shadowColor: Colors.blueAccent,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                minimumSize: const Size(150, 50),
              ),
              onPressed: () {
                createTransaction(
                    start: startController.text,
                    stop: stopController.text,
                    amount: int.parse(amountController.text),
                );
              },
              child: const Text('Pay Now', style: TextStyle(fontSize: 20)),
            ),
          )
        ],
      )
    );
  }

  goToPage(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return const Home();
    }));
  }

  showMessage(message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Future<dynamic> createTransaction({required String start, required String stop, required int amount}) async{

    userData = FirebaseFirestore.instance.collection('userData').doc(widget.singleUser.uid);

    final DocumentSnapshot<Map<String, dynamic>> snapshot;

    try{
      snapshot  = await userData.get();

      if(snapshot.exists){
        singleUser = SingleUser.fromJson(snapshot.data()!);
      }else{
        if (kDebugMode) {
          print("No data found");
        }
      }
    }catch(err){
      if (kDebugMode) {
        print(err.toString());
      }
    }

    if(int.parse(singleUser.amount) < int.parse(amountController.text)){
      showMessage('Your Balance is Insufficient To Proceed.');
    }else{

      await FirebaseFirestore.instance.collection('userData').doc(widget.singleUser.uid).update({
        "amount": (int.parse(singleUser.amount) - int.parse(amountController.text)).toString(),
      });
      
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

      goToPage();
    }
  }
}
