import 'package:get/get.dart';
import 'package:tele/Models/doctor_appointements_model.dart';
import 'package:tele/services/get_api_services.dart';

class DoctorAppointmentController extends GetxController {
  var isLoading = false.obs;
  var appointmets = <DoctorAppointementsModel>[].obs;
  // All confirmed appointments (can include duplicates)
  var allConfirmedAppointments = <DoctorAppointementsModel>[].obs;

  // Unique one-per-patient appointments to show in UI
  var uniquePatientAppointments = <DoctorAppointementsModel>[].obs;

  // Map to track patients with multiple appointments
  var patientsWithMultipleAppointments = <String, bool>{}.obs;
  var patientShiftTimes = <String, List<String>>{}.obs;

  Future<void> fechtAppointments(String patientId) async {
    // Change return type to Future<void>
    try {
      isLoading.value = true;
      final response = await ApiGetServices.doctorAppointements(patientId);
      appointmets.assignAll(response);
    } catch (e) {
      print("Error fetching hospitals: $e");
      //  return [];
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> confimfechtAppointments(String patientId) async {
    try {
      isLoading.value = true;
      final response = await ApiGetServices.doctorAppointements(patientId);
      // final confirmed = response.where((a) => a.status == 1).toList();
      final confirmed = response.where((a) => a.status != 2).toList();
      allConfirmedAppointments.assignAll(confirmed);
      final Map<String, List<DoctorAppointementsModel>> grouped = {};
      for (var appointment in confirmed) {
        grouped.putIfAbsent(appointment.patientToken, () => []);
        grouped[appointment.patientToken]!.add(appointment);
      }
      patientsWithMultipleAppointments.clear();
      grouped.forEach((token, appointments) {
        patientsWithMultipleAppointments[token] = appointments.length > 1;
         patientShiftTimes[token] = appointments.map((a) => a.shiftTime).toList();
      });
      uniquePatientAppointments.assignAll(
        grouped.entries.map((e) => e.value.first).toList(),
      );
    } catch (e) {
      print("Error fetching appointments: $e");
    } finally {
      isLoading.value = false;
    }
  }

  bool hasMultipleAppointments(String patientToken) {
    return patientsWithMultipleAppointments[patientToken] ?? false;
  }
}
