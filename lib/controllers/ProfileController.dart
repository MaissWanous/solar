import 'package:get/get.dart';
import 'package:udemy_flutter/models/profile_model.dart';
import '../services/profile_api.dart';

class ProfileController extends GetxController {
  var profile =
      ProfileModel(accountId: 0, fname: '', email: '', country: '').obs;
  var isLoading = true.obs;

  final ProfileApi _api = ProfileApi();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      final fetchedProfile = await _api.fetchProfile();
      if (fetchedProfile != null) {
        profile.value = fetchedProfile;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
