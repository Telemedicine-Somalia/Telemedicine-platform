import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
import 'package:tele/controllers/patient_transection_controller.dart';
import 'package:tele/services/StorageService.dart';
import 'package:tele/services/biometric_service.dart';
import 'package:tele/views/screens/loading_message_screen.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  _TransactionHistoryScreenState createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final patientTransectionController = Get.put(PatientTransectionController());
  final RxBool isBlurred = true.obs;
  final BiometricService biometricService = BiometricService();

  String userId = "Loading...";

  @override
  void initState() {
    super.initState();
    _authenticateUser();
    loadUserData();
  }

  Future<void> _authenticateUser() async {
    bool isAuthenticated = await biometricService.authenticate();
    if (!isAuthenticated) {
      // If authentication fails, show a biometric authentication prompt dialog
      
    }else{
      isBlurred.value = false;
    }
  }

 

  Future<void> loadUserData() async {
    Map<String, String?> userData = await StorageService.getUserData();
    setState(() {
      userId = userData["userId"] ?? "Unknown";
      patientTransectionController.fechtTransection(userId);
    });
  }

  String formatDate(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr).toLocal();
    return DateFormat('dd MM yy hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 9, 130, 13),
        centerTitle: true,
        title: Text(
          'transaction_history'.tr(),
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (patientTransectionController.isLoading.value) {
          return LoadingMessage();
        }
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
            itemCount: patientTransectionController.transections.length,
            itemBuilder: (context, index) {
              final transaction = patientTransectionController.transections[index];

              return Obx(() => Stack(
                    children: [
                      Card(
                        color: Colors.white.withOpacity(0.95),
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _infoRow('sender'.tr() + ':', transaction.patientName, transaction.senderPhone),
                              _infoRow('receiver'.tr() + ':', transaction.doctorName, transaction.reciverPhone),
                              _infoRow('Amount:', '', '\$${transaction.amount.toString()}'),
                              _infoRow('Date:', '', formatDate(transaction.createDate)),
                            ],
                          ),
                        ),
                      ),
                      if (isBlurred.value)
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: Container(
                                color: Colors.white.withOpacity(0.1),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ));
            },
          ),
        );
      }),
    );
  }

  Widget _infoRow(String title, String name, String phone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          if (phone.isNotEmpty)
            Text(
              phone,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
