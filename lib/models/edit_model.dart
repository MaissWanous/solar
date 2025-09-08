class EditModel {
  final int accountId;
  final String fname;
  final String lname;
  final String email;
  final int phone;
  final String country;
  final String type;
  final String? profilePic;
  final String createdAt;
  final String updatedAt;

  EditModel({
    required this.accountId,
    required this.fname,
    required this.lname,
    required this.email,
    required this.phone,
    required this.country,
    required this.type,
    this.profilePic,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EditModel.fromJson(Map<String, dynamic> json) {
    return EditModel(
      accountId: json['accountId'],
      fname: json['Fname'] ?? '',
      lname: json['Lname'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? 0,
      country: json['country'] ?? '',
      type: json['type'] ?? '',
      profilePic: json['profilePic'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
