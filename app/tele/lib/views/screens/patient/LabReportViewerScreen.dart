import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LabReportViewerScreen extends StatelessWidget {
  final String reportUrl;

  const LabReportViewerScreen({super.key, required this.reportUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lab Report".tr()),
      ),
      body: Center(
        child: Image.network(
          reportUrl,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const CircularProgressIndicator();
          },
          errorBuilder: (context, error, stackTrace) {
            return Text("Failed to load lab report.".tr());
          },
        ),
      ),
    );
  }
}
