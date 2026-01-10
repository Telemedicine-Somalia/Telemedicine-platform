import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tele/views/screens/components/config.dart';
import 'package:tele/views/screens/loading_message_screen.dart';

class Selfdetailts extends StatefulWidget {
  final String imagePath;
  final String title;
  final String description;
  final String createdDate;

  const Selfdetailts({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.createdDate,
  });

  @override
  State<Selfdetailts> createState() => _SelfdetailtsState();
}

class _SelfdetailtsState extends State<Selfdetailts> {
  final url = Config.baseUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "diet_and_exercise".tr(),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(

        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: widget.imagePath.isNotEmpty && widget.imagePath != "N/A"
                  ? Image(
                      image: CachedNetworkImageProvider('$url/${widget.imagePath}'),
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: const Center(
                              child: LoadingMessage(message: ''),
                            ),
                          );
                        }
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image),
                        );
                      },
                    )
                  : Image.asset(
                      'assets/default_image.png',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "detailed_information".tr(),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            // Make the description scrollable with better spacing
            Container(
              width: double.infinity,
              height: 350,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.6,  // Adjust line height for better readability
                    letterSpacing: 0.5,  // Adjust character spacing for clarity
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
