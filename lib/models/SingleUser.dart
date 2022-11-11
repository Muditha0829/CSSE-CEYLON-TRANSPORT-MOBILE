class SingleUser {
  String uid = '';
  final String phoneNo;
  final String nic;
  final String passportNo;
  final String fullName;
  final String email;

  SingleUser({
    required this.uid,
    required this.phoneNo,
    required this.nic,
    required this.passportNo,
    required this.fullName,
    required this.email
  });

  Map<String, dynamic> toJson() =>
      {
        'uid': uid,
        'phoneNo': phoneNo,
        'nic': nic,
        'passportNo' : passportNo,
        'fullName': fullName,
        'email': email
      };

  static SingleUser fromJson(Map<String, dynamic> json) =>
      SingleUser(
        uid: json['uid'],
        phoneNo: json['phoneNo'],
        nic: json['nic'],
        passportNo: json['passportNo'],
        fullName: json['fullName'],
        email: json['email'],
      );

  SingleUser.fromSnapshot(snapshot):
        uid = snapshot.data()['uid'],
        phoneNo = snapshot.data()['phoneNo'],
        nic = snapshot.data()['nic'],
        passportNo = snapshot.data()['passportNo'],
        fullName = snapshot.data()['fullName'],
        email = snapshot.data()['email'];
}
