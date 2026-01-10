import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tele/views/screens/components/config.dart';
import 'package:tele/views/screens/loading_message_screen.dart';
import 'package:tele/views/screens/selfDetailts.dart';

class ArticleCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String createdDate;

  const ArticleCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.createdDate,
  });

  @override
  Widget build(BuildContext context) {
    final url = Config.baseUrl;
    String formatDate(String dateStr) {
      DateTime dateTime = DateTime.parse(dateStr).toLocal();
      return DateFormat('dd MM yyyy').format(dateTime);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with caching
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: imagePath.isNotEmpty && imagePath != "N/A"
                    ? Image(
                        image: CachedNetworkImageProvider(
                          '$url/$imagePath',
                        ),
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
              const SizedBox(height: 12),
              // Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              Divider(color: Colors.grey[300]),
              const SizedBox(height: 4),
              // Read More Button
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // This ensures they are spaced out on the same line
                  children: [
                    // Created Date
                    Text(
                      "${'publish_date'.tr()}: ${formatDate(createdDate)}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600], // A subtle color for the date
                      ),
                    ),
                    // Read More Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Selfdetailts(
                                    imagePath: imagePath,
                                    title: title,
                                    description: description,
                                    createdDate: createdDate,
                                  )),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 9, 130, 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        'read_more'.tr(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
