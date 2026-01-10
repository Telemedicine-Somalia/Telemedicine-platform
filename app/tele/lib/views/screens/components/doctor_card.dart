import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tele/Models/doctors_list_nodel.dart';
import 'package:tele/views/screens/components/config.dart';
import 'package:tele/views/screens/doctor_profile_screen.dart';
import 'package:tele/views/screens/patient/shift_appointment_screen.dart';

class DoctorCard extends StatefulWidget {
  final DoctorList doctor;
  const DoctorCard({super.key, required this.doctor});
  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  final url = Config.baseUrl;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30, // Adjust size as needed
                  backgroundImage: (widget.doctor.picture.isNotEmpty &&
                          widget.doctor.picture != "N/A")
                      ? NetworkImage("$url/${widget.doctor.picture}")
                      : AssetImage('assets/default_image.png')
                          as ImageProvider,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.doctor.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${widget.doctor.experienceyears} ${'years_of_experience'.tr()}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DoctorProfileScreen(doctor: widget.doctor)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 9, 130, 13),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text("view_profile".tr(),
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.star, color: Colors.amber),
                // Text(doctor.rating != null ? doctor.rating.toString() : 'N/A'),
                Text(widget.doctor.rating.toString()),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(thickness: 1, color: Colors.greenAccent),
                  const SizedBox(height: 10),
                  Text("${'hospital'.tr()}: ${widget.doctor.hospitalname}"),
                  const SizedBox(height: 5),
                  Text("${'speciality'.tr()}: ${widget.doctor.speciality}"),
                  const SizedBox(height: 5),
                  Text("${'language'.tr()}: ${widget.doctor.countries}"),
                  const SizedBox(height: 5),
                  Text("Standard Charges: \$${widget.doctor.consultationfee}"),
                  // Text("Standard Charges: \$${0.01}"),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              // AppointmentScreen(doctor: widget.doctor)
                              ShiftAppointmentScreen(doctor: widget.doctor)
                              ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 9, 130, 13),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("book_appointment".tr(),
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
