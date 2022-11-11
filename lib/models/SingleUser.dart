class SingleUser {
  String uid = '';
  final String phoneNo;
  final String nic;
  final String fullName;
  final String email;
  final String amount;

  SingleUser({
    required this.uid,
    required this.phoneNo,
    required this.nic,
    required this.fullName,
    required this.email,
    required this.amount
  });

  Map<String, dynamic> toJson() =>
      {
        'uid': uid,
        'phoneNo': phoneNo,
        'nic': nic,
        'fullName': fullName,
        'email': email,
        'amount': amount,
      };

  static SingleUser fromJson(Map<String, dynamic> json) =>
      SingleUser(
        uid: json['uid'],
        phoneNo: json['phoneNo'],
        nic: json['nic'],
        fullName: json['fullName'],
        email: json['email'],
        amount: json['amount'],
      );
}
