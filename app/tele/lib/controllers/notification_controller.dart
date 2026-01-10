import 'package:get/get.dart';
import 'package:tele/Models/notifications_model.dart';
import 'package:tele/services/get_api_services.dart';

class NotificationController extends GetxController {
  final ApiGetServices _notificationService = ApiGetServices();

  var isLoading = false.obs;
  var patientNotifications = <PatientNotification>[].obs;
  var doctorNotifications = <DoctorNotification>[].obs;

  Future<void> fetchPatientNotifications(String patientId) async {
    try {
      isLoading.value = true;
      final notifs = await _notificationService.fetchNotification<PatientNotification>(
        userId: patientId,
        userType: "patient",
        fromJson: PatientNotification.fromJson,
      );
      patientNotifications.assignAll(notifs);
    } catch (e) {
      print("Error fetching patient notifications: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchDoctorNotifications(String doctorId) async {
    try {
      isLoading.value = true;
      final notifs = await _notificationService.fetchNotification<DoctorNotification>(
        userId: doctorId,
        userType: "doctor",
        fromJson: DoctorNotification.fromJson,
      );
      doctorNotifications.assignAll(notifs);
    } catch (e) {
      print("Error fetching doctor notifications: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
