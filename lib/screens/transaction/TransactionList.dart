import 'package:bus_ticketing_system/models/TransactionModel.dart';
import 'package:bus_ticketing_system/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  State<TransactionList> createState() => _UserListState();
}

class _UserListState extends State<TransactionList> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text("Transaction List"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_){
                return const Home();
              }));
            },
            icon: const Icon(Icons.home),
          ),
        ],
      ),
      body: StreamBuilder<List<TransactionModel>>(
        stream: getDataById(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            final users = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
              children: users.map(buildUser).toList(),
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
    );
  }

  Widget buildUser(TransactionModel transaction) {

    var borderRadius = const BorderRadius.all(Radius.circular(18));
    const double ft = 19;

    return Column(
      children: [
        const SizedBox(height: 10),
        ListTile(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          selectedTileColor: Colors.blueAccent,
          selected: true,
          title: Column(
            children: [
              const SizedBox(height: 9),
              Row(
                children: [
                  const Icon(Icons.directions_bus_filled_sharp, color: Colors.white),
                  Text(
                      '  ${transaction.start}',
                      style: const TextStyle(color: Colors.white, fontSize: ft)
                  ),
                  const Spacer(),
                  const Icon(Icons.directions_bus_filled_sharp, color: Colors.white),
                  Text(
                      '  ${transaction.stop}',
                      style: const TextStyle(color: Colors.white, fontSize: ft)
                  ),
                ],
              ),
              const SizedBox(height: 23),
              Row(
                children: [
                  const Spacer(),
                  Text(
                      'Rs. ${transaction.amount.toString()}',
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
                          return const Home();
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          backgroundColor: Colors.cyan
                      ),
                      child: const Text("View")
                  )
                ],
              ),
              const SizedBox(height: 9),
            ],
          ),
          onTap: () {
            getDataById();
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return const Home();
            }));
          },
        ),
      ],
    );
  }

  alertBox<Widget>(String id) {
    return AlertDialog(
      title: const Text("Do you want to delete?"),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan
            ),
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("No")
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red
            ),
            onPressed: (){
              deleteUser(id);
              Navigator.of(context).push(MaterialPageRoute(builder: (_){
                return const TransactionList();
              }));
            },
            child: const Text("Yes")
        )
      ],
    );
  }

  Future<dynamic> deleteUser(userId) async{
    var singleDonation = FirebaseFirestore.instance.collection('waterDonation').doc(userId);
    try{
      await singleDonation.delete();
    }catch(err){
      if (kDebugMode) {
        print(err.toString());
      }
    }
  }

  Stream<List<TransactionModel>> readTransactions() => FirebaseFirestore.instance
      .collection('transaction')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) =>
          TransactionModel.fromJson(doc.data()),
      ).toList(),
  );

  Stream<List<TransactionModel>> getDataById() => FirebaseFirestore.instance
      .collection('transaction').where('passengerId', isEqualTo: auth.currentUser?.uid).snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) =>
          TransactionModel.fromJson(doc.data()),
      ).toList()
  );

  getDataByIdOld(){

    final transaction = FirebaseFirestore.instance.collection('transaction');

    var results = transaction.where('age', isGreaterThan: 20).get();
    
    if (kDebugMode) {
      print(results);
    }
  }
}
