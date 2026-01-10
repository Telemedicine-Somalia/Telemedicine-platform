// user_controller.dart
import 'package:tele/controllers/adds_controller.dart';
import 'package:tele/controllers/appoinments_controller.dart';
import 'package:tele/controllers/doctor_appointment_controller.dart';
import 'package:tele/controllers/doctor_transection_controller.dart';
import 'package:tele/views/screens/components/config.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  // Method to check user type and fetch related data
  Future<void> checkUserType() async {
    String? userType = await Config.getUserType(); // Get user type
    if (userType != null) {
      print("Current User Type: $userType");

      // If user type is '1', fetch related data
      if (userType == '1') {
        final AddsController addsController = Get.find<AddsController>();
        final AppoinmentsController appoinmentsController = Get.find<AppoinmentsController>();
        await addsController.allAdds();

        String? userId = await Config.getUserId();
        if (userId != null) {
          await appoinmentsController.fechtAppointments(userId); // Fetch appointments
        }
      }
      // If user type is '0', fetch related data
      else if (userType == '0') {
        final AddsController addsController = Get.find<AddsController>();
        await addsController.allAdds();
        
        final DoctorAppointmentController appoinmentsController = Get.find<DoctorAppointmentController>();
        final DoctorTransectionController doctorTransectionController = Get.find<DoctorTransectionController>();
        
        String? userId = await Config.getUserId();
        if (userId != null) {
          await appoinmentsController.fechtAppointments(userId); // Fetch doctor appointments
          await doctorTransectionController.fechtTransection(userId); // Fetch doctor transactions
        }
      }
    }
  }
}
