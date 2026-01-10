import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
import 'package:tele/controllers/doctor_list_controller.dart';
import 'package:tele/controllers/re_appointment_controller.dart';
import 'package:tele/services/new_firebase_send_message.dart';
import 'package:tele/views/screens/DoctorScreens/ReAppointmentScreen.dart';
import 'package:tele/views/screens/DoctorScreens/doctor_appointment_chat_screen.dart';
import 'package:tele/views/screens/components/config.dart';
import 'package:toastification/toastification.dart';

class DoctorAppointmentCard extends StatelessWidget {
  final String appointmentTime;
  final String appointmentDate;
  final String doctorName;
  final String patientName;
  final String patientProfile;
  final String doctorToken;
  final String patientToken;
  final String doctorPhone;
  final String patientPhone;
  final String id;
  final bool hasMultipleAppointments;
  final String doctorId;
  final String patientId;
  final int status;

  const DoctorAppointmentCard({
    super.key,
    required this.appointmentTime,
    required this.appointmentDate,
    required this.doctorName,
    required this.patientName,
    required this.patientProfile,
    required this.doctorToken,
    required this.patientToken,
    required this.doctorPhone,
    required this.patientPhone,
    required this.id,
    required this.hasMultipleAppointments,
    required this.doctorId,
    required this.patientId,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final doctorListController = Get.put(DoctorListController());
    final reAppointmentController = Get.put(ReAppointmentController());

    DateTime appointmentDateTime;
    try {
      appointmentDateTime = DateTime.parse(appointmentDate);
    } catch (e) {
      appointmentDateTime = DateFormat('dd MMMM yyyy').parse(appointmentDate);
    }

    String formattedDate =
        DateFormat('EEE, dd MMM yyyy').format(appointmentDateTime);
    final url = Config.baseUrl;
    print("STATUS: $status");

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              // Top part with patient info
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorAppointmentChatScreen(
                          id: id,
                          patientName: patientName,
                          doctorName: doctorName,
                          patientProfile: patientProfile,
                          doctorToken: doctorToken,
                          patientToken: patientToken,
                          doctorPhone: doctorPhone,
                          patientPhone: patientPhone,
                          patientId: patientId,
                          doctorId: doctorId,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.blue.shade100,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.grey.shade100,
                            backgroundImage: (patientProfile.isNotEmpty &&
                                    patientProfile != "N/A")
                                ? NetworkImage('$url/$patientProfile')
                                : const AssetImage('assets/default_image.png')
                                    as ImageProvider,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                patientName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.access_time,
                                      size: 16, color: Colors.redAccent),
                                  const SizedBox(width: 5),
                                  Text(
                                    appointmentTime,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today_rounded,
                                      size: 16, color: Colors.blueGrey),
                                  const SizedBox(width: 5),
                                  Text(
                                    formattedDate,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              if (hasMultipleAppointments)
                                 Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Text(
                                    "multiple_appointments".tr(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Divider(height: 0.5, thickness: 0.5, color: Colors.grey),

              // Buttons
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16)),
                                  ),
                                  builder: (context) {
                                    return ConfirmCompleteBottomSheet(
                                      onConfirm: () async {
                                        await reAppointmentController
                                            .reAppointment(
                                                appointmentDate,
                                                patientId,
                                                id,
                                                2,
                                                doctorName,
                                                appointmentTime,
                                                patientToken,
                                                doctorToken,
                                                doctorId,
                                                patientId);
                                      },
                                      patientToken: patientToken,
                                      doctorName: doctorName,
                                      dcotorToken: doctorToken,
                                      appointmentDate: appointmentDate,
                                      appointmentTime: appointmentTime,
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 9),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    'complete'.tr(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () async {
                                print('Re-Appointment button clicked');
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => ReAppointmentScreen(
                                    doctorName: doctorName,
                                    doctorId: doctorId,
                                    appointmentDate: appointmentDate,
                                    appointmentId: id,
                                    patientId: patientId,
                                    appointmentTime: appointmentTime,
                                    patientToken: patientToken,
                                    doctorToken: doctorToken,
                                  ),
                                );
                                // NewFirebaseSendMessage().sendReAppointmentNotification(token: patientToken);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 9),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    're_appointment'.tr(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //here
                      ],
                    ),
                    const SizedBox(height: 10),
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: Material(
                    //     child: InkWell(
                    //       onTap: () {
                    //         print("hi");
                    //         showModalBottomSheet(
                    //           isScrollControlled: true,
                    //             context: context,
                    //             builder: (context) {
                    //               return NotifyBottomSheet(
                    //                   patientToken: patientToken,
                    //                   appointmentDate: appointmentDate,
                    //                   appointmentTime: appointmentTime,
                    //                   doctorName: doctorName);
                    //             });
                    //       },
                    //       borderRadius: BorderRadius.circular(8),
                    //       child: Container(
                    //         padding: const EdgeInsets.symmetric(vertical: 9),
                    //         decoration: BoxDecoration(
                    //           color: Colors.green,
                    //           borderRadius: BorderRadius.circular(8),
                    //         ),
                    //         child: const Center(
                    //           child: Text(
                    //             'Notify',
                    //             style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 13,
                    //               fontWeight: FontWeight.w500,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),

        // --- This is the special "Re-Appointment" Badge ---
        if (status == 4)
          Positioned(
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Text(
                "re_appointment".tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        if (status == 1)
          Positioned(
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Text(
                "in_progress".tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        if (status == 2)
          Positioned(
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: const Text(
                "Completed",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class ConfirmCompleteBottomSheet extends StatelessWidget {
  final VoidCallback onConfirm;
  final String patientToken;
  final String dcotorToken;
  final String doctorName;
  final String appointmentTime;
  final String appointmentDate;

  const ConfirmCompleteBottomSheet(
      {super.key,
      required this.onConfirm,
      required this.patientToken,
      required this.dcotorToken,
      required this.doctorName,
      required this.appointmentDate,
      required this.appointmentTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: const [
                Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.green,
                  size: 40,
                ),
                SizedBox(height: 10),
                Text(
                  "Complete Appointment",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Body Section
          const Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: Text(
              "Are you sure you want to complete this appointment? This action cannot be undone.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: const BorderSide(color: Colors.grey),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close bottom sheet
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.pop(context); // Close bottom sheet
                    onConfirm(); // Call confirm function
                    // await NewFirebaseSendMessage().sendAppointmentCompletedNotification(
                    //   token: patientToken,
                    //     body: "Your appointment with Dr. $doctorName on $appointmentDate at $appointmentTime has been completed.",
                    //   );
                  },
                  child: const Text(
                    "Confirm",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class NotifyBottomSheet extends StatefulWidget {
  final String patientToken;
  final String appointmentTime;
  final String appointmentDate;
  final String doctorName;

  const NotifyBottomSheet({
    super.key,
    required this.patientToken,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.doctorName,
  });

  @override
  State<NotifyBottomSheet> createState() => _NotifyBottomSheetState();
}

class _NotifyBottomSheetState extends State<NotifyBottomSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = "Reminder: Upcoming Appointment";
    _bodyController.text =
        "This is a reminder for your appointment with Dr. ${widget.doctorName} on ${widget.appointmentDate} at ${widget.appointmentTime}. Please be prepared and join on time.";
  }

  Future<void> _sendNotification() async {
    setState(() => isLoading = true);

    try {
      await NewFirebaseSendMessage().NotifyPatient(
        token: widget.patientToken,
        title: _titleController.text.trim(),
        body: _bodyController.text.trim(),
      );

      if (mounted) Navigator.pop(context); // Close bottom sheet safely

      toastification.show(
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
        title: const Text('Success'),
        description: const Text("Notification sent successfully"),
        autoCloseDuration: const Duration(seconds: 3),
        alignment: Alignment.topRight,
        showProgressBar: true,
      );
    } catch (e) {
      toastification.show(
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        title: const Text('Error'),
        description: Text("Failed to send notification: $e"),
        autoCloseDuration: const Duration(seconds: 4),
        alignment: Alignment.topRight,
        showProgressBar: true,
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.3,
        expand: false,
        builder: (_, controllerScroll) => SingleChildScrollView(
          controller: controllerScroll,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const Text("Title", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: "Enter notification title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            const Text("Message Body", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextField(
              controller: _bodyController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "Enter notification message",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : _sendNotification,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(45),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Notify Patient'),
            ),
          ],
        ),
      ),
    )));
  }
}
