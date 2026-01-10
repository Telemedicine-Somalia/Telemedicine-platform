import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:tele/controllers/doctor_list_controller.dart';
import 'package:tele/views/screens/components/doctor_card.dart';
import 'package:tele/views/screens/loading_message_screen.dart';

class VideoConsultationScreen extends StatefulWidget {
  const VideoConsultationScreen({super.key});

  @override
  State<VideoConsultationScreen> createState() =>
      _VideoConsultationScreenState();
}

class _VideoConsultationScreenState extends State<VideoConsultationScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final doctorListController = Get.put(DoctorListController());

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      doctorListController.filterDoctors(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Search doctor...".tr(),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.black, fontSize: 18),
              )
            : Text("Search Doctor".tr()),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search, size: 30),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) _searchController.clear();
              });
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            if (doctorListController.isLoading.value) {
              return LoadingMessage();
            }
            // Check if the list of hospitals is empty
            if (doctorListController.doctorsList.isEmpty) {
              return Center(
                child: Text(
                  "No Doctors available. ${doctorListController.doctorsList.length}".tr(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            }
            return ListView.builder(
              itemCount: doctorListController.filteredDoctorsList.length,
              itemBuilder: (context, index) {
                // final doctorList = doctorListController.filteredDoctorsList[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: DoctorCard(
                    doctor: doctorListController.filteredDoctorsList[index],
                  ),
                );
              },
            );
          })),
    );
  }
}
