import 'package:get/get.dart';
import 'package:tele/Models/lab_request_Model.dart';
import 'package:tele/services/get_api_services.dart';

class LabsRequestedController extends GetxController {
  var isLoading = false.obs;
  var doctorLabsRequest = <LabRequestModel>[].obs;
  var patientLabsRequest = <LabRequestModel>[].obs;

  Future<void> getDoctorLabsRequest({
    required String patientId,
    required String doctorId,
    required String appointmentId
  }
  ) async {
    try {
       isLoading.value = true;
    final response = await ApiGetServices().doctorLabRequest(patientId: patientId, doctorId: doctorId, appointmentId: appointmentId);
    doctorLabsRequest.assignAll(response);
    } catch (e) {
      print("error from doctor getDoctorLabsRequest $e");
    }finally{
      isLoading.value = false;
    }
  }
  Future<void> getPatientLabsRequest({
    required String patientId,
    required String doctorId,
    required String appointmentId
  }
  ) async {
    try {
       isLoading.value = true;
    final response = await ApiGetServices().patientLabRequest(patientId: patientId, doctorId: doctorId, appointmentId: appointmentId);
    patientLabsRequest.assignAll(response);
    } catch (e) {
      print("error from doctor getPatientLabsRequest $e");
    }finally{
      isLoading.value = false;
    }
  }
}