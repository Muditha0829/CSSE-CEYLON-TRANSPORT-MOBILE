class TransactionModel {
  String id = '';
  final String start;
  final String stop;
  final int amount;
  final String passengerId;

  TransactionModel({
    required this.id,
    required this.start,
    required this.stop,
    required this.amount,
    required this.passengerId
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'start': start,
    'stop': stop,
    'amount': amount,
    'passengerId': passengerId
  };

  static TransactionModel fromJson(Map<String, dynamic> json) => TransactionModel(
      id: json['id'],
      start: json['start'],
      stop: json['stop'],
      amount: json['amount'],
      passengerId: json['passengerId']
  );
}