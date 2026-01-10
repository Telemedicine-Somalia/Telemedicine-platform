// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:tele/Models/doctor_prescriptions_model.dart';
// import 'package:tele/PrescriptionDetailScreen.dart';
// import 'package:tele/controllers/doctor_prescription_controller.dart';
// import 'package:tele/services/StorageService.dart';
// import 'package:tele/services/firebase_api.dart';
// import 'package:tele/views/screens/CallPage/call_page.dart';
// import 'package:tele/views/screens/components/config.dart';

// class PatientAppointmentChatScreen extends StatefulWidget {
//   final String doctorName;
//   final String patientName;
//   final String patientProfile;
//   final String doctorToken;
//   final String patientToken;
//   final String doctorPhone;
//   final String patientPhone;
//   final String doctorId;
//   final String patientId;

//   const PatientAppointmentChatScreen(
//       {super.key,
//       required this.doctorName,
//       required this.patientName,
//       required this.patientProfile,
//       required this.doctorToken,
//       required this.patientToken,
//       required this.doctorPhone,
//       required this.patientPhone,
//       required this.doctorId,
//       required this.patientId});

//   @override
//   State<PatientAppointmentChatScreen> createState() =>
//       _PatientAppointmentChatScreenState();
// }

// class _PatientAppointmentChatScreenState
//     extends State<PatientAppointmentChatScreen> {
//   final url = Config.baseUrl;
//   final ScrollController _scrollController = ScrollController();
//   double _avatarSize = 40;
//   bool _showFullAppBar = true;
//   String? picture;
//   String? userId;

//   final DoctorPrescriptionController controller =
//       Get.put(DoctorPrescriptionController());

//   @override
//   void initState() {
//     super.initState();
//     loadUserData();
//     _scrollController.addListener(_handleScroll);
//   }

//   Future<void> loadUserData() async {
//     Map<String, String?> userData = await StorageService.getUserData();
//     picture = userData['picture'] ?? "N/A";
//     userId = userData["userId"] ?? "Unknown";
//     print("hhhhhhhhhhhh$userId");
//     await controller.getPatientPrescriptions(
//       userId!,
//       widget.doctorId,
//     );
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.removeListener(_handleScroll);
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _handleScroll() {
//     final offset = _scrollController.offset;
//     if (offset > 0 && offset < 100) {
//       setState(() {
//         _avatarSize = 40 - (offset * 0.3).clamp(0, 16);
//         _showFullAppBar = offset < 30;
//       });
//     } else if (offset <= 0) {
//       setState(() {
//         _avatarSize = 40;
//         _showFullAppBar = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(_showFullAppBar ? 80 : 56),
//         child: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 1,
//           titleSpacing: 0,
//           automaticallyImplyLeading: false,
//           flexibleSpace: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.arrow_back, color: Colors.teal),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                       AnimatedContainer(
//                         duration: const Duration(milliseconds: 100),
//                         width: _avatarSize,
//                         height: _avatarSize,
//                         child: CircleAvatar(
//                           backgroundColor: Colors.grey.shade200,
//                           backgroundImage: (widget.patientProfile.isNotEmpty &&
//                                   widget.patientProfile != "N/A")
//                               ? NetworkImage('$url/${widget.patientProfile}')
//                               : const AssetImage('assets/default_image.png')
//                                   as ImageProvider,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               widget.patientName,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             if (_showFullAppBar) ...[
//                               const SizedBox(height: 2),
//                               Row(
//                                 children: [
//                                   Container(
//                                     width: 8,
//                                     height: 8,
//                                     decoration: const BoxDecoration(
//                                       color: Colors.green,
//                                       shape: BoxShape.circle,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 6),
//                                   const Text(
//                                     'Online',
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ],
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.call, color: Colors.teal),
//                         onPressed: () async {
//                           final roomId =
//                               "call_${DateTime.now().millisecondsSinceEpoch}";

//                           await FirebaseApis().sendCallFCM(
//                               widget.doctorToken,
//                               widget.doctorName,
//                               roomId,
//                               widget.doctorPhone,
//                               widget.patientProfile,
//                               '0',
//                               widget.patientToken,
//                               widget.doctorToken,
//                               widget.doctorId,
//                               widget.patientId);
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => CallPage(
//                                 callId: roomId,
//                                 callType: '0',
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.videocam, color: Colors.teal),
//                         onPressed: () async {
//                           final roomId =
//                               "call_${DateTime.now().millisecondsSinceEpoch}";

//                           await FirebaseApis().sendCallFCM(
//                               widget.doctorToken,
//                               widget.doctorName,
//                               roomId,
//                               widget.doctorPhone,
//                               widget.patientProfile,
//                               '1',
//                               widget.patientToken,
//                               widget.doctorToken,
//                               widget.doctorId,
//                               widget.patientId);
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => CallPage(
//                                 callId: roomId,
//                                 callType: '1',
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: Obx(() {
//               if (controller.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (controller.patientPrescriptions.isEmpty) {
//                 return const Center(child: Text("No prescriptions found."));
//               }

//               return ListView.builder(
//                 controller: _scrollController,
//                 padding: const EdgeInsets.all(16),
//                 itemCount: controller.patientPrescriptions.length,
//                 itemBuilder: (context, index) {
//                   final item = controller.patientPrescriptions[index];
//                   final date =
//                       DateFormat.yMMMMd().add_jm().format(item.createDate);
//                   final medicineCount = item.medicines?.length ?? 0;
//                   final summary = medicineCount > 0
//                       ? "$medicineCount medicine${medicineCount > 1 ? 's' : ''} prescribed"
//                       : "No medicines listed";

//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) =>
//                               PrescriptionDetailScreen(prescription: item),
//                         ),
//                       );
//                     },
//                     child: Card(
//                       color: Colors.white,
//                       elevation: 3,
//                       margin: const EdgeInsets.only(bottom: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             /// Header row: Icon + Doctor name + Arrow
//                             Row(
//                               children: [
//                                 const Icon(Icons.medical_services,
//                                     color: Colors.blue, size: 24),
//                                 const SizedBox(width: 8),
//                                 Expanded(
//                                   child: Text(
//                                     "Dr. ${item.doctorName}",
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ),
//                                 const Icon(Icons.arrow_forward_ios,
//                                     size: 16, color: Colors.grey),
//                               ],
//                             ),

//                             const SizedBox(height: 10),

//                             /// Patient
//                             Row(
//                               children: [
//                                 const Icon(Icons.person,
//                                     size: 18, color: Colors.green),
//                                 const SizedBox(width: 6),
//                                 Text("Patient: ${item.patientName}",
//                                     style: const TextStyle(fontSize: 14)),
//                               ],
//                             ),

//                             /// Date
//                             Row(
//                               children: [
//                                 const Icon(Icons.calendar_today,
//                                     size: 18, color: Colors.orange),
//                                 const SizedBox(width: 6),
//                                 Text("Date: $date",
//                                     style: const TextStyle(fontSize: 14)),
//                               ],
//                             ),

//                             /// Medicine Summary
//                             Row(
//                               children: [
//                                 const Icon(Icons.list_alt,
//                                     size: 18, color: Colors.purple),
//                                 const SizedBox(width: 6),
//                                 Text(summary,
//                                     style: const TextStyle(fontSize: 14)),
//                               ],
//                             ),

//                             const SizedBox(height: 12),

//                             /// Call-to-action
//                             Container(
//                               width: double.infinity,
//                               padding: const EdgeInsets.symmetric(vertical: 10),
//                               decoration: BoxDecoration(
//                                 color: Colors.blue.withOpacity(0.08),
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                               child: const Center(
//                                 child: Text(
//                                   "Tap to view full prescription",
//                                   style: TextStyle(
//                                     color: Colors.blue,
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),
//           // Message Input
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 4,
//                   offset: const Offset(0, -2),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//               Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style:  ElevatedButton.styleFrom(
//                       backgroundColor: Colors.teal,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadiusGeometry.circular(20)
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12)
//                     ),
//                     child: Text(
//                       'Upload a Lab',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 )
//                 // IconButton(
//                 //   icon: const Icon(Icons.add, color: Colors.teal),
//                 //   onPressed: () {},
//                 // ),
//                 // Expanded(
//                 //   child: TextField(
//                 //     decoration: InputDecoration(
//                 //       hintText: 'Type a message',
//                 //       border: OutlineInputBorder(
//                 //         borderRadius: BorderRadius.circular(24),
//                 //         borderSide: BorderSide.none,
//                 //       ),
//                 //       filled: true,
//                 //       fillColor: Colors.grey.shade200,
//                 //       contentPadding: const EdgeInsets.symmetric(
//                 //         horizontal: 16,
//                 //         vertical: 12,
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//                 // IconButton(
//                 //   icon: const Icon(Icons.send, color: Colors.teal),
//                 //   onPressed: () {},
//                 // ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
