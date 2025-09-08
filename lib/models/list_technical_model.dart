class TechnicalUser {
  final int accountId;
  final String fname;
  final String? lname;
  final String email;
  final String? phone;
  final String country;
  final String? profilePic;

  TechnicalUser({
    required this.accountId,
    required this.fname,
    this.lname,
    required this.email,
    this.phone,
    required this.country,
    this.profilePic,
  });

  factory TechnicalUser.fromJson(Map<String, dynamic> json) {
    return TechnicalUser(
      accountId: json['accountId'],
      fname: json['Fname'] ?? '',
      lname: json['Lname'],
      email: json['email'] ?? '',
      phone: json['phone'],
      country: json['country'] ?? '',
      profilePic: json['profilePic'],
    );
  }

  String get fullName {
    return lname == null || lname!.isEmpty ? fname : '$fname $lname';
  }

  String get imagePath {
    if (profilePic == null || profilePic!.isEmpty) {
      return 'assets/images/sample_avatar.png'; // المسار الافتراضي للصورة
    }
    return profilePic!;
  }
}
