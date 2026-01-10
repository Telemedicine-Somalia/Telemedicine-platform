import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:tele/controllers/doctor_appointment_controller.dart';
import 'package:tele/services/StorageService.dart';
import 'package:tele/views/screens/components/appointment_card.dart';
import 'package:tele/views/screens/loading_message_screen.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  const DoctorAppointmentScreen({super.key});
  @override
  State<DoctorAppointmentScreen> createState() =>
      _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {
  final doctorAppointmentController = Get.put(DoctorAppointmentController());
  String? userId;
  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    Map<String, String?> userData = await StorageService.getUserData();
    setState(() {
      userId = userData["userId"] ?? "Unknown";
      doctorAppointmentController.fechtAppointments(userId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('appointments'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (doctorAppointmentController.isLoading.value) {
            return LoadingMessage();
          }
          if (doctorAppointmentController.appointmets.isEmpty) {
            return Center(child: Text("no_appointments_found".tr()));
          }
          return ListView.builder(
              itemCount: doctorAppointmentController.appointmets.length,
              // itemCount: 5,
              itemBuilder: (context, index) {
                final appointment =
                    doctorAppointmentController.appointmets[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: AppointmentCard(
                      appointmentTime: appointment.shiftTime,
                      appointmentDate: appointment.appointmentDate,
                      doctorName: appointment.patientName,
                      doctorImageUrl: appointment.patientProfile,
                      status: appointment.status),
                );
              });
        }),
      ),
    );
  }
}
