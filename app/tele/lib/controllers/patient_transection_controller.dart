import 'package:get/get.dart';
import 'package:tele/Models/transection_model.dart';
import 'package:tele/services/get_api_services.dart';

class PatientTransectionController extends GetxController{
  var isLoading = false.obs;
  var transections = <PatientTransectionModel>[].obs;

  Future<void> fechtTransection(String patientId) async {
    // Change return type to Future<void>
    try {
      isLoading.value = true;
      final response = await ApiGetServices.patientTransection(patientId);
      transections.assignAll(response);
      
    } catch (e) {
      print("Error fetching hospitals: $e");
      //  return [];
    } finally {
      isLoading.value = false;
    }
  }
}