import 'package:cloud_firestore/cloud_firestore.dart';

class PricePackage {
  final String nameAr;
  final String nameEn;
  final double price;
  final String duration;
  final String descriptionAr;
  final String descriptionEn;

  PricePackage({
    required this.nameAr,
    required this.nameEn,
    required this.price,
    required this.duration,
    this.descriptionAr = '',
    this.descriptionEn = '',
  });

  factory PricePackage.fromMap(Map<String, dynamic> map) => PricePackage(
    nameAr: map['name_ar'] ?? '',
    nameEn: map['name_en'] ?? '',
    price: (map['price'] ?? 0).toDouble(),
    duration: map['duration'] ?? '',
    descriptionAr: map['description_ar'] ?? '',
    descriptionEn: map['description_en'] ?? '',
  );

  Map<String, dynamic> toMap() => {
    'name_ar': nameAr, 'name_en': nameEn,
    'price': price, 'duration': duration,
    'description_ar': descriptionAr, 'description_en': descriptionEn,
  };
}

class Listing {
  final String id;
  final String type; // nursery, summer_club, activity, babysitter
  final String nameAr;
  final String nameEn;
  final String descriptionAr;
  final String descriptionEn;
  final String area;
  final GeoPoint? locationGeo;
  final String addressAr;
  final String addressEn;
  final List<PricePackage> pricePackages;
  final int ageMin;
  final int ageMax;
  final List<String> photos;
  final String coverPhoto;
  final double ratingAvg;
  final int reviewsCount;
  final List<String> facilities;
  final bool transportation;
  final bool featured;
  final bool active;
  final String whatsapp;
  final String phone;
  final String? instagram;
  final String? website;
  final String ownerId;
  final DateTime createdAt;

  Listing({
    required this.id,
    required this.type,
    required this.nameAr,
    required this.nameEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.area,
    this.locationGeo,
    required this.addressAr,
    required this.addressEn,
    required this.pricePackages,
    required this.ageMin,
    required this.ageMax,
    required this.photos,
    required this.coverPhoto,
    required this.ratingAvg,
    required this.reviewsCount,
    required this.facilities,
    required this.transportation,
    required this.featured,
    required this.active,
    required this.whatsapp,
    required this.phone,
    this.instagram,
    this.website,
    required this.ownerId,
    required this.createdAt,
  });

  String name(String lang) => lang == 'ar' ? nameAr : nameEn;
  String description(String lang) => lang == 'ar' ? descriptionAr : descriptionEn;
  String address(String lang) => lang == 'ar' ? addressAr : addressEn;

  factory Listing.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Listing(
      id: doc.id,
      type: data['type'] ?? 'nursery',
      nameAr: data['name_ar'] ?? '',
      nameEn: data['name_en'] ?? '',
      descriptionAr: data['description_ar'] ?? '',
      descriptionEn: data['description_en'] ?? '',
      area: data['area'] ?? '',
      locationGeo: data['location_geo'],
      addressAr: data['address_ar'] ?? '',
      addressEn: data['address_en'] ?? '',
      pricePackages: (data['price_packages'] as List<dynamic>?)
          ?.map((p) => PricePackage.fromMap(p))
          .toList() ?? [],
      ageMin: data['age_min'] ?? 0,
      ageMax: data['age_max'] ?? 18,
      photos: List<String>.from(data['photos'] ?? []),
      coverPhoto: data['cover_photo'] ?? '',
      ratingAvg: (data['rating_avg'] ?? 0).toDouble(),
      reviewsCount: data['reviews_count'] ?? 0,
      facilities: List<String>.from(data['facilities'] ?? []),
      transportation: data['transportation'] ?? false,
      featured: data['featured'] ?? false,
      active: data['active'] ?? true,
      whatsapp: data['whatsapp'] ?? '',
      phone: data['phone'] ?? '',
      instagram: data['instagram'],
      website: data['website'],
      ownerId: data['owner_id'] ?? '',
      createdAt: (data['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
    'type': type, 'name_ar': nameAr, 'name_en': nameEn,
    'description_ar': descriptionAr, 'description_en': descriptionEn,
    'area': area, 'location_geo': locationGeo,
    'address_ar': addressAr, 'address_en': addressEn,
    'price_packages': pricePackages.map((p) => p.toMap()).toList(),
    'age_min': ageMin, 'age_max': ageMax,
    'photos': photos, 'cover_photo': coverPhoto,
    'rating_avg': ratingAvg, 'reviews_count': reviewsCount,
    'facilities': facilities, 'transportation': transportation,
    'featured': featured, 'active': active,
    'whatsapp': whatsapp, 'phone': phone,
    'instagram': instagram, 'website': website,
    'owner_id': ownerId, 'created_at': Timestamp.fromDate(createdAt),
  };
}
