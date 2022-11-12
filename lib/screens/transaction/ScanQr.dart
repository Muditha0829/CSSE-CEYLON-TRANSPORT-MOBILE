import 'dart:io';
import 'package:bus_ticketing_system/models/SingleUser.dart';
import 'package:bus_ticketing_system/screens/transaction/TransactionProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQr extends StatefulWidget {
  const ScanQr({Key? key}) : super(key: key);

  @override
  State<ScanQr> createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {

  final GlobalKey _globalKey = GlobalKey();
  QRViewController? qrController;
  Barcode? result;
  late SingleUser singleUser;
  late DocumentReference<Map<String, dynamic>> oneUser;
  late bool checkUser;
  late int callCount = 0;

  void getUserById(userId) async{

    oneUser = FirebaseFirestore.instance.collection('userData').doc(userId);

    final DocumentSnapshot<Map<String, dynamic>> snapshot;
    snapshot = await oneUser.get();

    if(snapshot.exists){
      callCount += 1;
      if(callCount == 1){
        singleUser = SingleUser.fromJson(snapshot.data()!);
        changeScreen(singleUser);
        setState(() {
          checkUser = true;
        });
      }
    }else{
      if (kDebugMode) {
        print("No data found");
      }
    }
  }

  @override
  void dispose(){
    qrController?.dispose();
    qrController?.pauseCamera();
    qrController?.stopCamera();
    super.dispose();
  }

  @override
  void reassemble() async{
    super.reassemble();

    if(Platform.isAndroid){
      await qrController!.resumeCamera();
    }
  }

  void changeScreen(singleUser) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_){
      return TransactionProfile(singleUser);
    }));
  }

  void qrScan(QRViewController controller){
    // qrController = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
      });
      getUserById(event.code);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Qr Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //ElevatedButton(onPressed: (){getUserById('KMGlh8RrzwexEAISii2eWeEWuHj1');}, child: const Text('getData')),
            SizedBox(
              height: 400,
              width: 400,
              child: QRView(
                key: _globalKey,
                onQRViewCreated: qrScan,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              child: buildResult(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildResult(){
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey
      ),
      child: Text(
        result != null ? 'Result : ${result!.code}' : 'Scan a code!',
        style: const TextStyle(color: Colors.white),
        maxLines: 3,
      ),
    );
  }
}
