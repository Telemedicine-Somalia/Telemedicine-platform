// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import 'package:tele/controllers/doctor_prescription_controller.dart';
// import 'package:tele/services/StorageService.dart';
// import 'package:tele/services/firebase_api.dart';
// import 'package:tele/views/screens/CallPage/call_page.dart';
// import 'package:tele/views/screens/components/config.dart';
// import 'package:tele/PrescriptionDetailScreen.dart';

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

//   const PatientAppointmentChatScreen({
//     super.key,
//     required this.doctorName,
//     required this.patientName,
//     required this.patientProfile,
//     required this.doctorToken,
//     required this.patientToken,
//     required this.doctorPhone,
//     required this.patientPhone,
//     required this.doctorId,
//     required this.patientId,
//   });

//   @override
//   State<PatientAppointmentChatScreen> createState() =>
//       _PatientAppointmentChatScreenState();
// }

// class _PatientAppointmentChatScreenState
//     extends State<PatientAppointmentChatScreen> {
//   final DoctorPrescriptionController controller =
//       Get.put(DoctorPrescriptionController());
//   final ScrollController _scrollController = ScrollController();

//   double _avatarSize = 40;
//   bool _showFullAppBar = true;
//   String? picture;
//   String? userId;
//   final url = Config.baseUrl;

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

//     await controller.getPatientPrescriptions(userId!, widget.doctorId);
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

//   Widget _buildCustomAppBar() {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 1,
//       titleSpacing: 0,
//       automaticallyImplyLeading: false,
//       flexibleSpace: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           child: Row(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.arrow_back, color: Colors.teal),
//                 onPressed: () => Navigator.pop(context),
//               ),
//               AnimatedContainer(
//                 duration: const Duration(milliseconds: 100),
//                 width: _avatarSize,
//                 height: _avatarSize,
//                 child: CircleAvatar(
//                   backgroundColor: Colors.grey.shade200,
//                   backgroundImage: (widget.patientProfile.isNotEmpty &&
//                           widget.patientProfile != "N/A")
//                       ? NetworkImage('$url/${widget.patientProfile}')
//                       : const AssetImage('assets/default_image.png')
//                           as ImageProvider,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.patientName,
//                       style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     if (_showFullAppBar) ...[
//                       const SizedBox(height: 2),
//                       Row(
//                         children: [
//                           Container(
//                             width: 8,
//                             height: 8,
//                             decoration: const BoxDecoration(
//                                 color: Colors.green, shape: BoxShape.circle),
//                           ),
//                           const SizedBox(width: 6),
//                           const Text('Online',
//                               style:
//                                   TextStyle(fontSize: 12, color: Colors.grey)),
//                         ],
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.call, color: Colors.teal),
//                 onPressed: () async {
//                   final roomId =
//                       "call_${DateTime.now().millisecondsSinceEpoch}";
//                   await FirebaseApis().sendCallFCM(
//                     widget.doctorToken,
//                     widget.doctorName,
//                     roomId,
//                     widget.doctorPhone,
//                     widget.patientProfile,
//                     '0',
//                     widget.patientToken,
//                     widget.doctorToken,
//                     widget.doctorId,
//                     widget.patientId,
//                   );
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) =>
//                               CallPage(callId: roomId, callType: '0')));
//                 },
//               ),
//               IconButton(
//                 icon: const Icon(Icons.videocam, color: Colors.teal),
//                 onPressed: () async {
//                   final roomId =
//                       "call_${DateTime.now().millisecondsSinceEpoch}";
//                   await FirebaseApis().sendCallFCM(
//                     widget.doctorToken,
//                     widget.doctorName,
//                     roomId,
//                     widget.doctorPhone,
//                     widget.patientProfile,
//                     '1',
//                     widget.patientToken,
//                     widget.doctorToken,
//                     widget.doctorId,
//                     widget.patientId,
//                   );
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) =>
//                               CallPage(callId: roomId, callType: '1')));
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPrescriptionTab() {
//     return Column(
//       children: [
//         Expanded(
//           child: Obx(() {
//             if (controller.isLoading.value) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (controller.patientPrescriptions.isEmpty) {
//               return const Center(child: Text("No prescriptions found."));
//             }

//             return ListView.builder(
//               controller: _scrollController,
//               padding: const EdgeInsets.all(16),
//               itemCount: controller.patientPrescriptions.length,
//               itemBuilder: (context, index) {
//                 final item = controller.patientPrescriptions[index];
//                 final date =
//                     DateFormat.yMMMMd().add_jm().format(item.createDate);
//                 final medicineCount = item.medicines?.length ?? 0;
//                 final summary = medicineCount > 0
//                     ? "$medicineCount medicine${medicineCount > 1 ? 's' : ''} prescribed"
//                     : "No medicines listed";

//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) =>
//                               PrescriptionDetailScreen(prescription: item)),
//                     );
//                   },
//                   child: Card(
//                     elevation: 3,
//                     margin: const EdgeInsets.only(bottom: 14),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               const Icon(Icons.medical_services,
//                                   color: Colors.blue),
//                               const SizedBox(width: 8),
//                               Expanded(
//                                 child: Text("Dr. ${item.doctorName}",
//                                     style: const TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600)),
//                               ),
//                               const Icon(Icons.arrow_forward_ios,
//                                   size: 16, color: Colors.grey),
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//                           Row(
//                             children: [
//                               const Icon(Icons.person,
//                                   size: 18, color: Colors.green),
//                               const SizedBox(width: 6),
//                               Text("Patient: ${item.patientName}",
//                                   style: const TextStyle(fontSize: 14)),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               const Icon(Icons.calendar_today,
//                                   size: 18, color: Colors.orange),
//                               const SizedBox(width: 6),
//                               Text("Date: $date",
//                                   style: const TextStyle(fontSize: 14)),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               const Icon(Icons.list_alt,
//                                   size: 18, color: Colors.purple),
//                               const SizedBox(width: 6),
//                               Text(summary,
//                                   style: const TextStyle(fontSize: 14)),
//                             ],
//                           ),
//                           const SizedBox(height: 12),
//                           Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.symmetric(vertical: 10),
//                             decoration: BoxDecoration(
//                               color: Colors.blue.withOpacity(0.08),
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             child: const Center(
//                               child: Text(
//                                 "Tap to view full prescription",
//                                 style: TextStyle(
//                                     color: Colors.blue,
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 14),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () {
//                 // TODO: Implement add prescription logic
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.teal,
//                 padding: const EdgeInsets.symmetric(vertical: 14),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12)),
//               ),
//               child: const Text("Add Prescription",
//                   style: TextStyle(fontSize: 16, color: Colors.white)),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildLabsTab() {
//     return Column(
//       children: [
//         Expanded(
//           child: Center(
//             child: Text("No lab reports uploaded.",
//                 style: TextStyle(color: Colors.grey[600])),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () {
//                 // TODO: Implement lab upload functionality
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.teal,
//                 padding: const EdgeInsets.symmetric(vertical: 14),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12)),
//               ),
//               child: const Text("Upload a Lab",
//                   style: TextStyle(fontSize: 16, color: Colors.white)),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(_showFullAppBar ? 120 : 96),
//           child: Column(
//             children: [
//               _buildCustomAppBar(),
//               TabBar(
//                 labelColor: Colors.teal,
//                 unselectedLabelColor: Colors.grey,
//                 indicatorColor: Colors.teal,
//                 indicator: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50),
//                   color: Colors.teal.withOpacity(0.2),
//                 ),
//                 tabs: const [
//                   Tab(text: "Prescription"),
//                   Tab(text: "Labs"),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             _buildPrescriptionTab(),
//             _buildLabsTab(),
//           ],
//         ),
//       ),
//     );
//   }
// }
