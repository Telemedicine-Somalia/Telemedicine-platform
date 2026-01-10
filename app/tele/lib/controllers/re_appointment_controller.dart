import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tele/controllers/doctor_appointment_controller.dart';
import 'package:tele/services/new_firebase_send_message.dart';
import 'package:tele/services/post_api_services.dart';
import 'package:tele/views/screens/components/config.dart';
import 'package:toastification/toastification.dart';

class ReAppointmentController extends GetxController {
  var isLoading = false.obs;

  Future<void> reAppointment(
    String appointmentDate,
    String shiftsId,
    String appointmentId,
    int status,
    String doctorName,
    String appointmentTime,
    String patientToken,
    String doctorToken,
    String doctorId,
    String pateintId,
  ) async {
    try {
      isLoading.value = true;
      final response = await ApiPostServices().reAppointment(
        appointmentDate,
        shiftsId,
        appointmentId,
        status,
      );

      toastification.show(
        type: response['success']
            ? ToastificationType.success
            : ToastificationType.error,
        style: ToastificationStyle.flat,
        title: Text(response['success'] ? 'Success' : 'Hmmmmm'),
        description: Text(response['message']),
        autoCloseDuration: const Duration(seconds: 3),
        alignment: Alignment.topRight,
        showProgressBar: true,
      );

      final userToken = await Config.getUserToken();
      print(
          "✅ Token: $userToken -- Doctor: $doctorName -- Date: $appointmentDate -- Time: $appointmentTime");

      // if (userToken != null && userToken.isNotEmpty) {

      if (status == 2) {
        final String title = "Appointment Completed";
        final String body =
            "Your appointment with Dr. $doctorName on $appointmentDate at $appointmentTime has been completed.";
        await NewFirebaseSendMessage().sendAppointmentCompletedNotification(
            token: patientToken, body: body);
        await ApiPostServices().saveNotifcation(title, body, '', pateintId);
      } else if (status == 4) {
        final String title = "Re-Appointment";
        final String body =
            "You have a new re-appointment with Dr. $doctorName on $appointmentDate at $appointmentTime.";
        await NewFirebaseSendMessage()
            .sendReAppointmentNotification(token: patientToken, body: body);
        await ApiPostServices().saveNotifcation(title, body, '', pateintId);
        // }
        // Else: Do nothing.
      }
      final doctorAppointmentController =
          Get.find<DoctorAppointmentController>();
      await doctorAppointmentController.confimfechtAppointments(doctorId);
      Get.back();
    } catch (e) {
      toastification.show(
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        title: Text('Error'),
        description: Text(e.toString()),
        autoCloseDuration: const Duration(seconds: 3),
        alignment: Alignment.topRight,
        showProgressBar: true,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
