import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tele/controllers/write_prescription_controller.dart';

class DoctorPrescriptionScreen extends StatefulWidget {
  final String patientId;
  final String doctorId;
  final String appointmentId;
  final String doctorToken;
  final String patientToken;

  const DoctorPrescriptionScreen({
    super.key,
    required this.patientId,
    required this.doctorId,
    required this.appointmentId,
    required this.doctorToken,
    required this.patientToken,
  });

  @override
  State<DoctorPrescriptionScreen> createState() =>
      _DoctorPrescriptionScreenState();
}

class _DoctorPrescriptionScreenState extends State<DoctorPrescriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  final writePrescriptionController = Get.put(WritePrescriptionController());
  final TextEditingController advice = TextEditingController();

  List<Map<String, TextEditingController>> medications = [
    {
      "medicine_name": TextEditingController(),
      "dosage": TextEditingController(),
      "duration": TextEditingController(),
      "frequency": TextEditingController(),
    }
  ];

  void addMedicationField() {
    setState(() {
      medications.add({
        "medicine_name": TextEditingController(),
        "dosage": TextEditingController(),
        "duration": TextEditingController(),
        "frequency": TextEditingController(),
      });
    });
  }

  void removeMedicationField(int index) {
    if (medications.length <= 1) return;
    setState(() {
      medications.removeAt(index);
    });
  }

  InputDecoration getInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey[50],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Future<void> onSendPressed() async {
    if (!_formKey.currentState!.validate()) return;

    await writePrescriptionController.writePrescription(
      patientId: widget.patientId,
      doctorId: widget.doctorId,
      appointmentId: widget.appointmentId,
      extraDetail: advice.text.trim(),
      medicines: medications.map((med) {
        return {
          "medicine_name": med["medicine_name"]!.text.trim(),
          "dosage": med["dosage"]!.text.trim(),
          "duration": med["duration"]!.text.trim(),
          "frequency": med["frequency"]!.text.trim(),
        };
      }).toList(),
      doctorToken: widget.doctorToken,
      patientToken: widget.patientToken,
    );

    // You can enable toast/snackbar here
  }

  Widget buildMedicationCard(int index) {
    final c = medications[index];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.medical_services, color: Colors.blue),
              const SizedBox(width: 8),
              Text("Medication ${index + 1}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              const Spacer(),
              if (medications.length > 1)
                IconButton(
                  onPressed: () => removeMedicationField(index),
                  icon: const Icon(Icons.close, color: Colors.red),
                  tooltip: "Remove",
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: c["medicine_name"],
                  decoration: getInputDecoration("Medicine Name"),
                  validator: (v) =>
                      v == null || v.isEmpty ? "Required" : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: c["dosage"],
                  decoration: getInputDecoration("Dosage (mg)"),
                  keyboardType: TextInputType.number,
                  validator: (v) =>
                      v == null || v.isEmpty ? "Required" : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: c["duration"],
                  decoration: getInputDecoration("Duration (days)"),
                  keyboardType: TextInputType.number,
                  validator: (v) =>
                      v == null || v.isEmpty ? "Required" : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: c["frequency"],
                  decoration: getInputDecoration("Frequency"),
                  validator: (v) =>
                      v == null || v.isEmpty ? "Required" : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text("Write Prescription",
            style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ...List.generate(medications.length, buildMedicationCard),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: addMedicationField,
                icon: const Icon(Icons.add),
                label: const Text("Add Medication"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.green,
                  side: const BorderSide(color: Colors.blue),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: advice,
                maxLines: 3,
                decoration: getInputDecoration("Advice / Notes"),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: ElevatedButton.icon(
          onPressed: onSendPressed,
          icon: const Icon(Icons.send),
          label: const Text("Send Prescription"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
