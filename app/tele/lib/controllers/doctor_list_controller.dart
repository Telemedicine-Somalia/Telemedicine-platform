import 'package:get/get.dart';
import 'package:tele/Models/doctors_list_nodel.dart';
import 'package:tele/services/get_api_services.dart';

// class DoctorListController extends GetxController{
//   var doctorsList = <DoctorList>[].obs;
//   var isLoading = false.obs;
//   void fetchDoctorsList() async {
//     try {
//       isLoading.value = true;
//       final doctros = await ApiGetServices().fechDoctorsList();
//       // doctorsList.assignAll(doctros.where((hname) => hname.hospitalname.toLowerCase().startsWith('dig')));
//       doctorsList.assignAll(doctros);
//        doctorsList.refresh();
//     } catch (e) {
//       print("Error fetching Doctors: $e");
//     }finally{
//       isLoading.value = false;
//     }
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     fetchDoctorsList();
//   }
// }

class DoctorListController extends GetxController {
  var doctorsList = <DoctorList>[].obs;
  var filteredDoctorsList = <DoctorList>[].obs;
  var isLoading = false.obs;

  void fetchDoctorsList() async {
    try {
      isLoading.value = true;
      final doctors = await ApiGetServices().fechDoctorsList();
      doctorsList.assignAll(doctors);
      filteredDoctorsList.assignAll(doctors);
    } catch (e) {
      print("Error fetching Doctors: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void filterDoctors(String query) {
    if (query.isEmpty) {
      filteredDoctorsList.assignAll(doctorsList);
    } else {
      filteredDoctorsList.assignAll(
        doctorsList.where((doc) =>
            doc.name.toLowerCase().contains(query.toLowerCase()) ||
            doc.speciality.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchDoctorsList();
  }
}
