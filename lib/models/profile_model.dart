class ProfileModel {
  final int accountId;
  final String fname;
  final String? lname;
  final String email;
  final String? phone;
  final String? country;

  ProfileModel({
    required this.accountId,
    required this.fname,
    this.lname,
    required this.email,
    this.phone,
    this.country,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    // تحويل phone الى نص حتى لو كان رقم
    String? phoneString;
    if (json['phone'] != null) {
      phoneString = json['phone'].toString();
    }
    String? countryString = json['country'];
    // تأكد أن country ليست null
    if(countryString == null || countryString.isEmpty){
      countryString = 'Syria,Homs'; // أو أي قيمة افتراضية تريدها
    }
    return ProfileModel(
      accountId: json['accountId'],
      fname: json['Fname'],
      lname: json['Lname'],
      email: json['email'],
      phone: phoneString,
      country: countryString,
    );
  }
}
