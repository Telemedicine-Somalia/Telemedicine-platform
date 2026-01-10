import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:tele/controllers/doctor_appointment_controller.dart';
import 'package:tele/services/StorageService.dart';
import 'package:tele/views/screens/components/docotor_appointment_card.dart';
import 'package:tele/views/screens/loading_message_screen.dart';

class ConseltaionScreen extends StatefulWidget {
  const ConseltaionScreen({super.key});

  @override
  State<ConseltaionScreen> createState() => _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<ConseltaionScreen> {
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
      doctorAppointmentController.confimfechtAppointments(userId!);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Consultation'.tr(),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Use GetX navigation to go back
            if (Navigator.canPop(context)) {
              Get.back();
            } else {
              // If can't go back, navigate to home screen
              Get.offAllNamed('/doctormainscreen');
            }
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if(doctorAppointmentController.isLoading.value){
            return LoadingMessage();
          }
          if(doctorAppointmentController.allConfirmedAppointments.isEmpty){
            return Center(child: Text("No Appointments Found".tr()));
          }
          return ListView.builder(
            itemCount: doctorAppointmentController.allConfirmedAppointments.length,
            // itemCount: 5,
            itemBuilder: (context,index) {
              final appointment = doctorAppointmentController.allConfirmedAppointments[index];
              final hasMultiple = doctorAppointmentController.hasMultipleAppointments(appointment.patientToken);
              print('for doctor ${appointment.doctorToken} -- ${appointment.id}');
              print('for pateint ${appointment.patientToken} -- ${appointment.id}');
              return Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: DoctorAppointmentCard(
                  appointmentTime: appointment.shiftTime, 
                  appointmentDate: appointment.appointmentDate, 
                  doctorName: appointment.doctorName, 
                  patientName: appointment.patientName, 
                  patientProfile: appointment.patientProfile,
                  doctorToken: appointment.doctorToken,
                  patientToken: appointment.patientToken,
                  doctorPhone: appointment.doctorPhone,
                  patientPhone: appointment.patientPhone,
                  id: appointment.id,
                  hasMultipleAppointments: hasMultiple,
                  doctorId: appointment.doctorId,
                  patientId:appointment.patientId ,
                  status: appointment.status,
                  // /status: appointment.status
                  ),
                );
            });
        }),
      ),
    );
  }
}