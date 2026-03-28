import 'package:cloud_firestore/cloud_firestore.dart';

class Kid {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String notes;

  Kid({required this.id, required this.name, required this.age, this.gender = 'boy', this.notes = ''});

  factory Kid.fromMap(String id, Map<String, dynamic> m) => Kid(
    id: id, name: m['name'] ?? '', age: m['age'] ?? 0,
    gender: m['gender'] ?? 'boy', notes: m['notes'] ?? '',
  );
}

class AppUser {
  final String uid;
  final String nameAr;
  final String nameEn;
  final String phone;
  final String email;
  final String avatarUrl;
  final String area;
  final String language;
  final List<String> favorites;
  final List<Kid> kids;
  final DateTime createdAt;

  AppUser({
    required this.uid, required this.nameAr, required this.nameEn,
    required this.phone, this.email = '', this.avatarUrl = '',
    this.area = '', this.language = 'ar', this.favorites = const [],
    this.kids = const [], required this.createdAt,
  });

  String name(String lang) => lang == 'ar' ? nameAr : nameEn;

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return AppUser(
      uid: doc.id, nameAr: d['name_ar'] ?? '', nameEn: d['name_en'] ?? '',
      phone: d['phone'] ?? '', email: d['email'] ?? '',
      avatarUrl: d['avatar_url'] ?? '', area: d['area'] ?? '',
      language: d['language'] ?? 'ar',
      favorites: List<String>.from(d['favorites'] ?? []),
      createdAt: (d['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
