class PaymentModel {
  String id = '';
  final String name;
  final String cardNumber;
  final String amount;
  final String date;
  final String time;

  PaymentModel({
    required this.id,
    required this.name,
    required this.cardNumber,
    required this.amount,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'cardNumber': cardNumber,
    'amount': amount,
    'date': date,
    'time': time
  };

  static PaymentModel fromJson(Map<String, dynamic> json) => PaymentModel(
      id: json['id'],
      name: json['name'],
      cardNumber: json['cardNumber'],
      amount: json['amount'],
      date: json['date'],
      time: json['time']
  );
}