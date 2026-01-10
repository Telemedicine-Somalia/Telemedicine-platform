import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:tele/controllers/request_labs_controller.dart';

class DoctorLabRequest extends StatefulWidget {
  final String doctorId;
  final String patientId;
  final String appointmentId;
  final String doctorToken;
  final String patientToken;

  const DoctorLabRequest({
    super.key,
    required this.doctorId,
    required this.patientId,
    required this.appointmentId,
    required this.doctorToken,
    required this.patientToken,
  });

  @override
  State<DoctorLabRequest> createState() => _DoctorLabRequestState();
}

class _DoctorLabRequestState extends State<DoctorLabRequest> {
  final _formKey = GlobalKey<FormState>();
  final requestLabsController = Get.put(RequestLabsController());
  final TextEditingController notes = TextEditingController();

  List<Map<String, TextEditingController>> labRequestTests = [
    {
      "test_name": TextEditingController(),
      "description": TextEditingController(),
      "priority": TextEditingController(),
    }
  ];

  void addLabRequestField() {
    setState(() {
      labRequestTests.add({
        "test_name": TextEditingController(),
        "description": TextEditingController(),
        "priority": TextEditingController(),
      });
    });
  }

  void removeLabRequestField(int index) {
    if (labRequestTests.length <= 1) return;
    setState(() => labRequestTests.removeAt(index));
  }

  Future<void> submitLabRequests() async {
    if (!_formKey.currentState!.validate()) return;

    final requestedLabs = labRequestTests.map((item) {
      return {
        "test_name": item["test_name"]!.text.trim(),
        "description": item["description"]!.text.trim(),
        "priority": item["priority"]!.text.trim(),
      };
    }).toList();

    await requestLabsController.writeLabRequest(
      requestedLabs: requestedLabs,
      patientId: widget.patientId,
      doctorId: widget.doctorId,
      appointmentId: widget.appointmentId,
      notes: notes.text.trim(),
      doctorToken: widget.doctorToken,
      patientToken: widget.patientToken,
    );
  }

  Widget buildTextField(TextEditingController controller, String label,
      {bool isRequired = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: isRequired
          ? (value) => (value == null || value.trim().isEmpty) ? 'Required' : null
          : null,
    );
  }

  Widget buildLabCard(int index) {
    final c = labRequestTests[index];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.biotech, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                "${'test'.tr()} ${index + 1}",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              if (labRequestTests.length > 1)
                IconButton(
                  onPressed: () => removeLabRequestField(index),
                  icon: const Icon(Icons.close, color: Colors.red),
                  tooltip: "Remove",
                ),
            ],
          ),
          const SizedBox(height: 10),
          buildTextField(c["test_name"]!, "test_name".tr(), isRequired: true),
          const SizedBox(height: 12),
          buildTextField(c["description"]!, "description".tr()),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: c["priority"]!.text.isNotEmpty ? c["priority"]!.text : null,
            items: ['low'.tr(), 'medium'.tr(), 'high'.tr()]
                .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                .toList(),
            onChanged: (value) => setState(() => c["priority"]!.text = value ?? ''),
            decoration: InputDecoration(
              labelText: "priority".tr(),
              filled: true,
              fillColor: Colors.grey[50],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
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
        title: Text("Lab_Request".tr(), style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Obx(() {
        if (requestLabsController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Test Fields
                ...List.generate(labRequestTests.length, buildLabCard),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: addLabRequestField,
                  icon: const Icon(Icons.add),
                  label: Text("add_another_test".tr()),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.green,
                    side: const BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    minimumSize: const Size.fromHeight(50),
                  ),
                ),
                const SizedBox(height: 30),
                // Notes Section
                buildTextField(notes, "additional_notes".tr()),
                const SizedBox(height: 100),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: ElevatedButton(
          onPressed: submitLabRequests,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text("submit_request".tr(), style: TextStyle(fontSize: 16,color: Colors.white),),
        ),
      ),
    );
  }
}
