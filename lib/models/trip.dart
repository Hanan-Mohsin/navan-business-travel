class Trip {
  final String id;
  final String userId;
  final String destination;
  final String purpose;
  final DateTime startDate;
  final DateTime endDate;
  final String status; // Upcoming, In Progress, Completed, Cancelled
  final double budget;
  final double spent;
  final String? hotelName;
  final String? flightNumber;
  final List<String> travelers;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Trip({
    required this.id,
    required this.userId,
    required this.destination,
    required this.purpose,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.budget,
    required this.spent,
    this.hotelName,
    this.flightNumber,
    required this.travelers,
    required this.createdAt,
    this.updatedAt,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'] as String,
      userId: json['userId'] as String,
      destination: json['destination'] as String,
      purpose: json['purpose'] as String,
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      status: json['status'] as String,
      budget: (json['budget'] as num).toDouble(),
      spent: (json['spent'] as num).toDouble(),
      hotelName: json['hotelName'] as String?,
      flightNumber: json['flightNumber'] as String?,
      travelers: List<String>.from(json['travelers'] as List),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'destination': destination,
      'purpose': purpose,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status,
      'budget': budget,
      'spent': spent,
      'hotelName': hotelName,
      'flightNumber': flightNumber,
      'travelers': travelers,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
