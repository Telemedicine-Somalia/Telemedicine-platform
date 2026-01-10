// import 'package:get/get.dart';
// import 'package:tele/services/auth_services.dart';

// class ForgetPasswordController extends GetxController {
//   var isLoading = false.obs;
//   var message = "".obs;
//   var isOtpVerified = false.obs;

//   // Step 1: Request OTP
//   Future<void> requestOtp(String email) async {
//     isLoading.value = true;
//     final response = await AuthServices.forgetPassword(email);
//     isLoading.value = false;
//     message.value = response['message'];
//     if (response['success']) {
//       Get.snackbar("Success", message.value);
//     } else {
//       Get.snackbar("Error", message.value);
//     }
//   }

//   // Step 2: Verify OTP
//   Future<void> verifyOtp(String email, String otp) async {
//     isLoading.value = true;
//     final response = await AuthServices.verifyOtp(email, otp);
//     isLoading.value = false;
//     message.value = response['message'];
//     if (response['success']) {
//       isOtpVerified.value = true;
//       Get.snackbar("Success", message.value);
//     } else {
//       Get.snackbar("Error", message.value);
//     }
//   }

//   // Step 3: Reset Password
//   Future<void> resetPassword(
//       String email, String newPassword, String confirmPassword) async {
//     isLoading.value = true;
//     final response =
//         await AuthServices.resetPassword(email, newPassword, confirmPassword);
//     isLoading.value = false;
//     message.value = response['message'];
//     if (response['success']) {
//       Get.snackbar("Success", message.value);
//       Get.offAllNamed("/login"); // go back to login after success
//     } else {
//       Get.snackbar("Error", message.value);
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:tele/services/auth_services.dart';

class ForgetPasswordController extends GetxController {
  var isLoading = false.obs;
  var message = "".obs;
  var isOtpVerified = false.obs;
  var currentStep = 1.obs; // 👈 controls which step to show
  var isOtpRequested = false.obs;
  var isVerifyOtpClicked = false.obs;

  // Step 1: Request OTP
  Future<void> requestOtp(String email) async {
    isLoading.value = true;
    final response = await AuthServices.forgetPassword(email);
    isLoading.value = false;
    message.value = response['message'];

    if (response['success']) {
      currentStep.value = 2; // 👈 move to OTP step
      Get.snackbar("Success", message.value);
    } else {
      Get.snackbar("Error", message.value);
    }
  }

  // Step 2: Verify OTP
  Future<void> verifyOtp(String email, String otp) async {
    isLoading.value = true;
    final response = await AuthServices.verifyOtp(email, otp);
    isLoading.value = false;
    message.value = response['message'];

    if (response['success']) {
      isOtpVerified.value = true;
      currentStep.value = 3; // 👈 move to reset password step
      Get.snackbar("Success", message.value);
    } else {
      Get.snackbar("Error", message.value);
    }
  }

  // Step 3: Reset Password
  Future<void> resetPassword(
      String email, String newPassword, String confirmPassword) async {
    isLoading.value = true;
    final response =
        await AuthServices.resetPassword(email, newPassword, confirmPassword);
    isLoading.value = false;
    message.value = response['message'];

    if (response['success']) {
      Get.snackbar("Success", message.value);
      Get.offAllNamed("/login"); // back to login
    } else {
      Get.snackbar("Error", message.value);
    }
  }
}
