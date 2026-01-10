import 'package:get/get.dart';
import 'package:tele/services/auth_services.dart';

class DoctorController extends GetxController {
  var isLoading = false.obs;

  Future<Map<String, dynamic>> registerDoctor({
    required String name,
    required String email,
    required String phone,
    required String username,
    required String password,
    required String consultationFee,
    required String experienceYears,
    required String specialityId,
    required String hospitalId,
    required String extraDetail,
     required String countries,
  }) async {
    try {
      isLoading.value = true;

      final response = await AuthServices().registerDoctor(
        name: name,
        email: email,
        phone: phone,
        username: username,
        password: password,
        consultationFee: consultationFee,
        experienceYears: experienceYears,
        specialityId: specialityId,
        hospitalId: hospitalId,
        extraDetail: extraDetail,
        countries: countries, 
      );

      return response;
    } finally {
      isLoading.value = false;
    }
  }
}
