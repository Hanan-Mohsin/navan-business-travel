class Expense {
  final String id;
  final String userId;
  final String tripId;
  final String category;
  final String description;
  final double amount;
  final String currency;
  final String status; // Pending, Approved, Rejected, Reimbursed
  final String? receiptUrl;
  final String? notes;
  final String? approvedBy;
  final DateTime date;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Expense({
    required this.id,
    required this.userId,
    required this.tripId,
    required this.category,
    required this.description,
    required this.amount,
    required this.currency,
    required this.status,
    this.receiptUrl,
    this.notes,
    this.approvedBy,
    required this.date,
    required this.createdAt,
    this.updatedAt,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'] as String,
      userId: json['userId'] as String,
      tripId: json['tripId'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: json['status'] as String,
      receiptUrl: json['receiptUrl'] as String?,
      notes: json['notes'] as String?,
      approvedBy: json['approvedBy'] as String?,
      date: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'tripId': tripId,
      'category': category,
      'description': description,
      'amount': amount,
      'currency': currency,
      'status': status,
      'receiptUrl': receiptUrl,
      'notes': notes,
      'approvedBy': approvedBy,
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
