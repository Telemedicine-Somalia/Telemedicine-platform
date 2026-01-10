import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tele/views/screens/components/config.dart';

class AppointmentCard extends StatefulWidget {
  final String appointmentTime;
  final String appointmentDate;
  final String doctorName;
  final String doctorImageUrl;
  final int status; // Status number (0, 1, 2, or other)
  const AppointmentCard({
    super.key,
    required this.appointmentTime,
    required this.appointmentDate,
    required this.doctorName,
    required this.doctorImageUrl,
    required this.status,
  });
  @override
  _AppointmentCardState createState() => _AppointmentCardState();
}
class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    // DateTime appointmentDate = DateTime.parse(widget.appointmentDate);
    DateFormat inputFormat =
        DateFormat('dd MMMM yyyy'); // Input format for "02 April 2025"
    // DateTime appointmentDate = inputFormat.parse(widget.appointmentDate);
    DateTime appointmentDate;
    try {
      appointmentDate = DateTime.parse(widget.appointmentDate);
    } catch (e) {
      appointmentDate =
          DateFormat('dd MMMM yyyy').parse(widget.appointmentDate);
    }
    // Format the date
    String formattedDate = DateFormat('EEE MMMM yy').format(appointmentDate);
    // Determine status text and color
    Map<int, Map<String, dynamic>> statusInfo = {
      0: {"text": "pending".tr(), "color": Colors.orange},
      1: {"text": "confirmed".tr(), "color": Colors.green},
      2: {"text": "completed".tr(), "color": Colors.blue},
      4: {"text": "re_appointment".tr(), "color": Colors.green},
    };

    final statusText = statusInfo[widget.status]?["text"] ?? "cancelled".tr();
    final statusColor = statusInfo[widget.status]?["color"] ?? Colors.red;
    final url = Config.baseUrl;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8, top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Appointment date header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "appointment_date".tr(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.circle, color: Colors.white, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        statusText,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Time slot row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      widget.appointmentTime,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                   
                  ],
                ),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Doctor information
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: (widget.doctorImageUrl?.isNotEmpty ??
                              false) &&
                          widget.doctorImageUrl != "N/A"
                      ? NetworkImage('$url/${widget.doctorImageUrl}')
                      : AssetImage('assets/default_image.png') as ImageProvider,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  widget.doctorName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.green, // Online status indicator
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
