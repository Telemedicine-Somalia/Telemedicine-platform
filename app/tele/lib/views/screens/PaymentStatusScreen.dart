import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class PaymentStatusScreen extends StatelessWidget {
  final bool isSuccess;
  final String paymentStatus;
  final String errorMessage;

  const PaymentStatusScreen({
    super.key, 
    required this.isSuccess, required this.paymentStatus, required this.errorMessage });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 9, 130, 13), // Background color
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 240),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSuccess ? Icons.check_circle : Icons.cancel,
                  color: isSuccess ? Colors.green : Colors.red,
                  size: 60,
                ),
                const SizedBox(height: 16),
                Text(
                  isSuccess ? "success".tr() : "failed".tr(),
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  isSuccess
                      ? paymentStatus
                      : errorMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 9, 130, 13),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      isSuccess ? "done".tr() : "try_again".tr(),
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
