import 'package:get/get.dart';
import 'package:tele/Models/lab_report_model.dart';
import 'package:tele/services/get_api_services.dart';

class LabsReportController extends GetxController {
  var isLoading = false.obs;
  var labsReport = <LabReportModel>[].obs;

  Future<void> labsReports(
      String patientId, String doctorId, String appointmentId) async {
    try {
      isLoading.value = true;
      final response = await ApiGetServices()
          .labsReports(patientId, doctorId, appointmentId);
      labsReport.assignAll(response);
    } catch (e) {
      print("Error fetching hospitals: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
