class FlightBooking {
  final String id;
  final String tripId;
  final String userId;
  final String airline;
  final String flightNumber;
  final String departureAirport;
  final String arrivalAirport;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final double price;
  final String currency;
  final int passengers;
  final String? seatNumber;
  final String? bookingReference;
  final String status; // Confirmed, Pending, Cancelled
  final DateTime createdAt;
  final DateTime? updatedAt;

  FlightBooking({
    required this.id,
    required this.tripId,
    required this.userId,
    required this.airline,
    required this.flightNumber,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    required this.currency,
    required this.passengers,
    this.seatNumber,
    this.bookingReference,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  factory FlightBooking.fromJson(Map<String, dynamic> json) {
    return FlightBooking(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      userId: json['userId'] as String,
      airline: json['airline'] as String,
      flightNumber: json['flightNumber'] as String,
      departureAirport: json['departureAirport'] as String,
      arrivalAirport: json['arrivalAirport'] as String,
      departureTime: DateTime.parse(json['departureTime']),
      arrivalTime: DateTime.parse(json['arrivalTime']),
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      passengers: json['passengers'] as int,
      seatNumber: json['seatNumber'] as String?,
      bookingReference: json['bookingReference'] as String?,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tripId': tripId,
      'userId': userId,
      'airline': airline,
      'flightNumber': flightNumber,
      'departureAirport': departureAirport,
      'arrivalAirport': arrivalAirport,
      'departureTime': departureTime.toIso8601String(),
      'arrivalTime': arrivalTime.toIso8601String(),
      'price': price,
      'currency': currency,
      'passengers': passengers,
      'seatNumber': seatNumber,
      'bookingReference': bookingReference,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
