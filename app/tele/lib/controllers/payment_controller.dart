import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tele/services/evs_plus_services.dart';
import 'package:tele/services/post_api_services.dart';
import 'package:tele/views/screens/main_screen.dart';
import 'package:toastification/toastification.dart';

class PaymentController extends GetxController {
  var isLoading = false.obs;
  var paymentStatus = ''.obs;
  var errorMessage = ''.obs;
  var isPaymentSuccessful = false.obs;

  Future<void> pay({
    required String phone,
    required double amount,
    required String merchantUid,
    required String apiUserId,
    required String apiKey,
    String description = 'Test',
    String invoiceId = '000',
    String referenceId = '00',
    String currency = 'USD',
  }) async {
    try {
      isLoading.value = true;
      paymentStatus.value = '';
      errorMessage.value = '';
      isPaymentSuccessful.value = false;
      final result = await EvsPlusServices().payByWaafiPay(
          phone: phone,
          amount: amount,
          merchantUid: merchantUid,
          apiUserId: apiUserId,
          apiKey: apiKey);

      if (result['status']) {
        paymentStatus.value = result['message'];
        isPaymentSuccessful.value = true;
        print(result['message']);
      } else {
        errorMessage.value = result['error'];
        isPaymentSuccessful.value = false;
        print(result['message']);
        print(result['error']);
      }
    } catch (e) {
      errorMessage.value = 'Something went wrong: $e';
      isPaymentSuccessful.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  ///
  ///
  Future<void> bookAndPayController(
      String doctorId,
      String patientId,
      String shiftsId,
      String senderPhone,
      String reciverPhone,
      double amount,
      String appointmentDate,
      String reason) async {
    try {
      isLoading.value = true;
      final response = await ApiPostServices().bookAndPay(doctorId, patientId,
          shiftsId, senderPhone, reciverPhone, amount, appointmentDate, reason);
      // if(response['success']) {
      // }
      toastification.show(
        type: response['success']
            ? ToastificationType.success
            : ToastificationType.error,
        style: ToastificationStyle.flat,
        title: Text(response['success'] ? 'Success' : 'Hmmmmm'),
        description: Text(response['message']),
        autoCloseDuration: const Duration(seconds: 3),
        // animationDuration: const Duration(microseconds: 300),
        alignment: Alignment.topRight,
        showProgressBar: true,
      );
      Get.offAll(() => MainScreen());
    } catch (e) {
      toastification.show(
        type: ToastificationType.error, // Fixing incorrect toast type
        style: ToastificationStyle.flat,
        title: Text('Error'), // Fixed incorrect conditional syntax
        description: Text(e.toString()), // Displaying the caught exception
        autoCloseDuration: const Duration(seconds: 3),
        alignment: Alignment.topRight,
        showProgressBar: true,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
