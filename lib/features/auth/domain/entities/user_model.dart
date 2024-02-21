import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String email;
  final String fullName;
  final String userName;
  final String phoneNo;
  final String? profilePicture;
  final String? preferences;
  final Timestamp? createdDate;

  const UserModel({
    this.id,
    required this.email,
    required this.fullName,
    required this.userName,
    required this.phoneNo,
    required this.profilePicture,
    required this.preferences,
    required this.createdDate
  });

  toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Phone": phoneNo,
      "ProfilePicture": profilePicture,
      "preferences": preferences,
      "createdDate": createdDate,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      email: data["Email"],
      fullName: data["FullName"],
      userName: data["UserName"],
      phoneNo: data["Phone"],
      profilePicture: data["ProfilePicture"],
      preferences: data["preferences"],
      createdDate: data["createdDate"],
    );
  }
}
