
import 'package:cloud_firestore/cloud_firestore.dart'; // FieldValue ইম্পোর্ট

class User {
  String? id; // Firebase এর জন্য ইউনিক আইডি
  String? get userId => id;
  String? email;
  String? passwordHash; // পাসওয়ার্ড হ্যাশ (ফায়ারবেস অথেন্টিকেশন দিয়ে হ্যান্ডেল)
  bool isAdmin; // অ্যাডমিন স্ট্যাটাস
  bool isAnonymous; // অ্যাননিমাস মোড
  DateTime? createdAt;
  String? profileImageUrl; // প্রোফাইল ছবি URL
  String? contactNumber; // দ্বিমুখী মেসেজিং-এর জন্য

  User({
    this.id,
    this.email,
    this.passwordHash,
    this.isAdmin = false,
    this.isAnonymous = false,
    this.createdAt,
    this.profileImageUrl,
    this.contactNumber,
  });

  // Firestore থেকে ডাটা কনভার্ট করার জন্য
  factory User.fromMap(Map<String, dynamic> data, String documentId) {
    return User(
      id: documentId,
      email: data['email'],
      passwordHash: data['password_hash'],
      isAdmin: data['is_admin'] ?? false,
      isAnonymous: data['is_anonymous'] ?? false,
      createdAt: data['created_at']?.toDate(),
      profileImageUrl: data['profile_image_url'],
      contactNumber: data['contact_number'],
    );
  }

  // Firestore-এ ডাটা সেভ করার জন্য
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password_hash': passwordHash,
      'is_admin': isAdmin,
      'is_anonymous': isAnonymous,
      'created_at': createdAt ?? FieldValue.serverTimestamp(),
      'profile_image_url': profileImageUrl,
      'contact_number': contactNumber,
    };
  }
}