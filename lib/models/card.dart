class CorporateCard {
  final String id;
  final String userId;
  final String cardNumber;
  final String cardHolder;
  final String cardType; // Visa, Mastercard, Amex
  final String status; // Active, Inactive, Locked
  final double spendLimit;
  final double spent;
  final DateTime expiryDate;
  final DateTime issuedDate;
  final DateTime? updatedAt;

  CorporateCard({
    required this.id,
    required this.userId,
    required this.cardNumber,
    required this.cardHolder,
    required this.cardType,
    required this.status,
    required this.spendLimit,
    required this.spent,
    required this.expiryDate,
    required this.issuedDate,
    this.updatedAt,
  });

  factory CorporateCard.fromJson(Map<String, dynamic> json) {
    return CorporateCard(
      id: json['id'] as String,
      userId: json['userId'] as String,
      cardNumber: json['cardNumber'] as String,
      cardHolder: json['cardHolder'] as String,
      cardType: json['cardType'] as String,
      status: json['status'] as String,
      spendLimit: (json['spendLimit'] as num).toDouble(),
      spent: (json['spent'] as num).toDouble(),
      expiryDate: DateTime.parse(json['expiryDate']),
      issuedDate: DateTime.parse(json['issuedDate']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'cardNumber': cardNumber,
      'cardHolder': cardHolder,
      'cardType': cardType,
      'status': status,
      'spendLimit': spendLimit,
      'spent': spent,
      'expiryDate': expiryDate.toIso8601String(),
      'issuedDate': issuedDate.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  String get maskedCardNumber {
    return '**** **** **** ${cardNumber.substring(cardNumber.length - 4)}';
  }
}
