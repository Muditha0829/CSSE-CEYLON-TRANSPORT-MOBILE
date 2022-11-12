import 'package:bus_ticketing_system/models/SingleUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountBalance extends StatefulWidget {
  const AccountBalance({Key? key}) : super(key: key);

  @override
  State<AccountBalance> createState() => _AccountBalanceState();
}

class _AccountBalanceState extends State<AccountBalance> {

  late SingleUser singleUser;

  late DocumentReference<Map<String, dynamic>> userData;
  late String amount = '0.00';

  @override
  void initState() {
    // TODO: implement initState
    createTransaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Balance'),
      ),
      body: Column(
        children:  [
          const SizedBox(height: 60),
          const Center(
            child: Text('Account Balance', style: TextStyle(fontSize: 30)),
          ),
          // const Text('1000.00       Used of         5000.00'),
          const SizedBox(height: 60),
          Card(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text('Account Balance: ${singleUser.amount}', style: const TextStyle(fontSize: 25)),
              )
          ),
        ],
      ),
    );
  }

  Future<dynamic> createTransaction() async{

    userData = FirebaseFirestore.instance.collection('userData').doc('KMGlh8RrzwexEAISii2eWeEWuHj1');

    final DocumentSnapshot<Map<String, dynamic>> snapshot;

    try{
      snapshot  = await userData.get();

      if(snapshot.exists){
        singleUser = SingleUser.fromJson(snapshot.data()!);
        setState(() {
          amount = singleUser.amount;
        });
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
  }
}
