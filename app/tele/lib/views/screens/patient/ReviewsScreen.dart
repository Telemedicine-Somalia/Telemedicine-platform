import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:tele/controllers/reviews_controller.dart';

class ReviewsScreen extends StatefulWidget {
  final String doctorId;
  final String patientId;
  final String appointmentId;

  const ReviewsScreen({
    super.key,
    required this.doctorId,
    required this.patientId,
    required this.appointmentId,
  });

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final ReviewsController controller = Get.put(ReviewsController());
  final TextEditingController commentController = TextEditingController();
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (_, controllerScroll) => SingleChildScrollView(
          controller: controllerScroll,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rate the Doctor'.tr(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(
                children: List.generate(5, (index) {
                  final i = index + 1;
                  return IconButton(
                    icon: Icon(
                      Icons.star,
                      color: rating >= i ? Colors.amber : Colors.grey.shade400,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        rating = i.toDouble();
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 24),
              Text('Leave a Comment'.tr(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              const SizedBox(height: 10),
              TextField(
                controller: commentController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Write your feedback here...'.tr(),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 24),
              Obx(() => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          final comment = commentController.text.trim();

                          if (rating == 0.0 || comment.isEmpty) {
                            Get.snackbar('Incomplete'.tr(), 'Please give a rating and write a comment'.tr());
                            return;
                          }

                          await controller.feedbackPatient(
                            comment,
                            widget.doctorId,
                            widget.patientId,
                            widget.appointmentId,
                            rating
                          );

                          if (!controller.isLoading.value) {
                            Navigator.of(context).pop(); // Close the screen
                          }
                        },
                        child: Text('Submit'.tr(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
