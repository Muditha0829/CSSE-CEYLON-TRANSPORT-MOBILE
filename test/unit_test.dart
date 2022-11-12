import 'package:bus_ticketing_system/models/SingleUser.dart';
import 'package:bus_ticketing_system/screens/transaction/TransactionProfile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){



  test('Testing the Deducted Amount', () {

    SingleUser user = SingleUser(
        uid: 'KMGlh8RrzwexEAISii2eWeEWuHj1',
        phoneNo: '0763693430',
        nic: '993454567v',
        passportNo: '',
        fullName: 'Chamindu Imalsha',
        email: 'chaminduimalsha@gmail.com',
        amount: '4000',
        userType: 'LOCAL'
    );

    TransactionProfile transactionProfile = TransactionProfile(user);

    int finalAmount = transactionProfile.createTransaction(start: 'Kottawa', stop: 'Malabe', amount: 200);

    expect(finalAmount, 3800);

  });
}