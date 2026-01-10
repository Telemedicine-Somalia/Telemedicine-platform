import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tele/Models/lab_request_Model.dart';
import 'package:toastification/toastification.dart';
import 'package:pdf/widgets.dart' as pw;


class LabRequestDetailScreen extends StatelessWidget {
  final LabRequestModel labRequest;

  const LabRequestDetailScreen({super.key, required this.labRequest});

  Future<void> _printLabRequest(BuildContext context) async {
    final pdf = pw.Document();
    final date = DateFormat.yMMMMd().add_jm().format(labRequest.createDate);

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(
              child: pw.Column(
                children: [
                  pw.Text("Dr. ${labRequest.doctorName}",
                      style:
                          pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                  pw.Text("Phone: ${labRequest.doctorPhone}",
                      style: pw.TextStyle(fontSize: 16)),
                ],
              ),
            ),
            pw.Divider(),
            pw.Text("Patient Information",
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Text("Name: ${labRequest.patientName}"),
            pw.Text("Age: ${labRequest.patientAge}"),
            pw.Text("Gender: ${labRequest.patientGender}"),
            pw.Text("Phone: ${labRequest.patientPhone}"),
            pw.SizedBox(height: 16),
            pw.Text("Lab Request Details",
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Text("Date: $date"),
            pw.Text("Lab Request ID: ${labRequest.sequenceId}"),
            // pw.Text("Appointment ID: ${labRequest.appointmentId}"),
            pw.Text("Shift: ${labRequest.shiftDay}, ${labRequest.shiftTime}"),
            pw.SizedBox(height: 16),
            pw.Text("Requested Tests",
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            if (labRequest.requestTests.isEmpty)
              pw.Text("No tests requested.")
            else
              ...labRequest.requestTests.map(
                (test) => pw.Bullet(
                  text: "${test.testName} - Priority: ${test.priority}",
                ),
              ),
            pw.SizedBox(height: 16),
            pw.Text("Notes",
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Text(labRequest.notes.isEmpty ? "No additional notes." : labRequest.notes),
          ],
        ),
      ),
    );

    try {
      await Printing.layoutPdf(onLayout: (format) async => pdf.save());
    } catch (e) {
      toastification.show(
        context: context,
        title: const Text('Print Failed'),
        description: Text('Error: $e'),
        type: ToastificationType.error,
      );
    }
  }

  Future<void> _downloadLabRequest(BuildContext context) async {
    final pdf = pw.Document();
    final date = DateFormat.yMMMMd().add_jm().format(labRequest.createDate);

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(
              child: pw.Column(
                children: [
                  pw.Text("Dr. ${labRequest.doctorName}",
                      style:
                          pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                  pw.Text("Phone: ${labRequest.doctorPhone}",
                      style: pw.TextStyle(fontSize: 16)),
                ],
              ),
            ),
            pw.Divider(),
            pw.Text("Patient Information",
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Text("Name: ${labRequest.patientName}"),
            pw.Text("Age: ${labRequest.patientAge}"),
            pw.Text("Gender: ${labRequest.patientGender}"),
            pw.Text("Phone: ${labRequest.patientPhone}"),
            pw.SizedBox(height: 16),
            pw.Text("Lab Request Details",
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Text("Date: $date"),
            pw.Text("Lab Request ID: ${labRequest.sequenceId}"),
            pw.Text("Appointment ID: ${labRequest.appointmentId}"),
            pw.Text("Shift: ${labRequest.shiftDay}, ${labRequest.shiftTime}"),
            pw.SizedBox(height: 16),
            pw.Text("Requested Tests",
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            if (labRequest.requestTests.isEmpty)
              pw.Text("No tests requested.")
            else
              ...labRequest.requestTests.map(
                (test) => pw.Bullet(
                  text: "${test.testName} - Priority: ${test.priority}",
                ),
              ),
            pw.SizedBox(height: 16),
            pw.Text("Notes",
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Text(labRequest.notes.isEmpty ? "No additional notes." : labRequest.notes),
          ],
        ),
      ),
    );

    try {
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/lab_request_${labRequest.sequenceId}.pdf");
      await file.writeAsBytes(await pdf.save());

      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Lab Request PDF',
      );
    } catch (e) {
      toastification.show(
        context: context,
        title: const Text('Download Failed'),
        description: Text('Error: $e'),
        type: ToastificationType.error,
      );
      print("❌ $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final date = DateFormat.yMMMMd().add_jm().format(labRequest.createDate);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Lab Request"),
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.green),
        titleTextStyle: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: Colors.white,
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Header
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: Image.asset("assets/images/logo.jpg", fit: BoxFit.contain),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Dr. ${labRequest.doctorName}",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      Text(
                        "Phone: ${labRequest.doctorPhone}",
                        style: const TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _sectionHeader(Icons.person, "Patient Information"),
                const SizedBox(height: 8),
                _buildInfoRow("Name", labRequest.patientName),
                _buildInfoRow("Age", "${labRequest.patientAge}"),
                _buildInfoRow("Gender", labRequest.patientGender),
                _buildInfoRow("Phone", labRequest.patientPhone),
                const SizedBox(height: 20),
                _sectionHeader(Icons.description, "Lab Request Details"),
                const SizedBox(height: 8),
                _buildInfoRow("Date", date),
                _buildInfoRow("Lab Request ID", labRequest.sequenceId),
                _buildInfoRow("Appointment ID", labRequest.appointmentId),
                _buildInfoRow("Shift", "${labRequest.shiftDay}, ${labRequest.shiftTime}"),
                const SizedBox(height: 20),
                _sectionHeader(Icons.medical_services, "Requested Tests"),
                const SizedBox(height: 8),
                labRequest.requestTests.isEmpty
                    ? const Text("No tests requested.",
                        style: TextStyle(color: Colors.redAccent))
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: labRequest.requestTests.length,
                        separatorBuilder: (_, __) => const Divider(height: 16),
                        itemBuilder: (context, i) {
                          final test = labRequest.requestTests[i];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.circle, size: 12, color: Colors.green),
                            title: Text(
                              test.testName,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "Priority: ${test.priority}\n${test.description}",
                              style: const TextStyle(fontSize: 15),
                            ),
                          );
                        },
                      ),
                const SizedBox(height: 20),
                _sectionHeader(Icons.note, "Notes"),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: Text(labRequest.notes.isEmpty ? "No additional notes." : labRequest.notes),
                ),
                const SizedBox(height: 32),
                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => _downloadLabRequest(context),
                      icon: const Icon(Icons.share),
                      label: const Text("Share as PDF"),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.green,
                        side: const BorderSide(color: Colors.green, width: 1.5),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => _printLabRequest(context),
                      icon: const Icon(Icons.print),
                      label: const Text("Print"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: Colors.green, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
