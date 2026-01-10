import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tele/controllers/labs_controller.dart';
import 'package:toastification/toastification.dart';

class UpdateProfilePictureScreen extends StatefulWidget {
  final String id;
  const UpdateProfilePictureScreen({super.key, required this.id});

  @override
  State<UpdateProfilePictureScreen> createState() =>
      _UpdateProfilePictureScreenState();
}

class _UpdateProfilePictureScreenState
    extends State<UpdateProfilePictureScreen> {
  File? _selectedImage;
  final LabsController _labsController = Get.put(LabsController());
  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('take_photo'.tr()),
            onTap: () async {
              Navigator.pop(context);
              final picked =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              if (picked != null) {
                setState(() {
                  _selectedImage = File(picked.path);
                });
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('choose_from_gallery'.tr()),
            onTap: () async {
              Navigator.pop(context);
              final picked =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (picked != null) {
                setState(() {
                  _selectedImage = File(picked.path);
                });
              }
            },
          ),
        ],
      ),
    );
  }

  void _uploadProfilePicture() async {
    if (_selectedImage == null) {
      toastification.show(
        context: context,
        title: Text("missing_info".tr()),
        description: Text("please_complete_all_fields".tr()),
        type: ToastificationType.warning,
        autoCloseDuration: const Duration(seconds: 3),
      );
      return;
    }
    await _labsController.uploadProfilePicture(
        id: widget.id, imageFile: _selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.3,
        expand: false,
        builder: (_, controllerScroll) => SingleChildScrollView(
          controller: controllerScroll,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              InkWell(
                onTap: _pickImage,
                child: _selectedImage != null
                    ? Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        clipBehavior: Clip.antiAlias,
                        child: Image.file(
                          _selectedImage!,
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : DottedBorderPlaceholder(),
              ),
              const SizedBox(height: 10),
              // Colored pick image button
              Center(
                child: TextButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(
                    Icons.image_outlined,
                    color: Colors.white,
                  ),
                  label: Text("pick_change_image".tr(),
                      style: TextStyle(color: Colors.white)),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                ),
              ),
              // Green upload button
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.cloud_upload_outlined,
                      color: Colors.white),
                  label: Text("upload_save_record".tr(),
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                  ),
                  onPressed:
                      _labsController.isUploading.value ? null : _uploadProfilePicture,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DottedBorderPlaceholder extends StatelessWidget {
  const DottedBorderPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.grey, style: BorderStyle.solid, width: 1),
          borderRadius: BorderRadius.circular(12)),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_photo_alternate_outlined,
            size: 50,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          Text("tap_to_add_image".tr(), style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
