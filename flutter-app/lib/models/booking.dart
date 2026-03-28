import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String id;
  final String userId;
  final String listingId;
  final String listingNameAr;
  final String listingNameEn;
  final String listingType;
  final Map<String, dynamic> package;
  final DateTime startDate;
  final DateTime endDate;
  final List<Map<String, dynamic>> kids;
  final String status; // pending, confirmed, completed, cancelled, rejected
  final double totalPrice;
  final String? couponCode;
  final double discount;
  final String paymentMethod;
  final String paymentStatus;
  final String notes;
  final DateTime createdAt;

  Booking({
    required this.id, required this.userId, required this.listingId,
    required this.listingNameAr, required this.listingNameEn,
    required this.listingType, required this.package,
    required this.startDate, required this.endDate,
    required this.kids, required this.status,
    required this.totalPrice, this.couponCode, this.discount = 0,
    required this.paymentMethod, required this.paymentStatus,
    this.notes = '', required this.createdAt,
  });

  factory Booking.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return Booking(
      id: doc.id,
      userId: d['userId'] ?? '',
      listingId: d['listingId'] ?? '',
      listingNameAr: d['listing_name_ar'] ?? '',
      listingNameEn: d['listing_name_en'] ?? '',
      listingType: d['listing_type'] ?? '',
      package: Map<String, dynamic>.from(d['package'] ?? {}),
      startDate: (d['start_date'] as Timestamp).toDate(),
      endDate: (d['end_date'] as Timestamp).toDate(),
      kids: List<Map<String, dynamic>>.from(d['kids'] ?? []),
      status: d['status'] ?? 'pending',
      totalPrice: (d['total_price'] ?? 0).toDouble(),
      couponCode: d['coupon_code'],
      discount: (d['discount'] ?? 0).toDouble(),
      paymentMethod: d['payment_method'] ?? 'cash',
      paymentStatus: d['payment_status'] ?? 'pending',
      notes: d['notes'] ?? '',
      createdAt: (d['created_at'] as Timestamp).toDate(),
    );
  }
}
