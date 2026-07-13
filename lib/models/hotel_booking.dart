class HotelBooking {
  final String id;
  final String tripId;
  final String userId;
  final String hotelName;
  final String location;
  final String address;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int numberOfRooms;
  final int numberOfNights;
  final double pricePerNight;
  final double totalPrice;
  final String currency;
  final String? roomType;
  final String? confirmationNumber;
  final List<String>? amenities;
  final String status; // Confirmed, Pending, Cancelled
  final DateTime createdAt;
  final DateTime? updatedAt;

  HotelBooking({
    required this.id,
    required this.tripId,
    required this.userId,
    required this.hotelName,
    required this.location,
    required this.address,
    required this.checkInDate,
    required this.checkOutDate,
    required this.numberOfRooms,
    required this.numberOfNights,
    required this.pricePerNight,
    required this.totalPrice,
    required this.currency,
    this.roomType,
    this.confirmationNumber,
    this.amenities,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  factory HotelBooking.fromJson(Map<String, dynamic> json) {
    return HotelBooking(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      userId: json['userId'] as String,
      hotelName: json['hotelName'] as String,
      location: json['location'] as String,
      address: json['address'] as String,
      checkInDate: DateTime.parse(json['checkInDate']),
      checkOutDate: DateTime.parse(json['checkOutDate']),
      numberOfRooms: json['numberOfRooms'] as int,
      numberOfNights: json['numberOfNights'] as int,
      pricePerNight: (json['pricePerNight'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      currency: json['currency'] as String,
      roomType: json['roomType'] as String?,
      confirmationNumber: json['confirmationNumber'] as String?,
      amenities: json['amenities'] != null ? List<String>.from(json['amenities'] as List) : null,
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
      'hotelName': hotelName,
      'location': location,
      'address': address,
      'checkInDate': checkInDate.toIso8601String(),
      'checkOutDate': checkOutDate.toIso8601String(),
      'numberOfRooms': numberOfRooms,
      'numberOfNights': numberOfNights,
      'pricePerNight': pricePerNight,
      'totalPrice': totalPrice,
      'currency': currency,
      'roomType': roomType,
      'confirmationNumber': confirmationNumber,
      'amenities': amenities,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
