import 'package:get/get.dart';
import 'package:tele/Models/doctors_list_nodel.dart';
import 'package:tele/Models/specialist_model.dart';
import 'package:tele/services/get_api_services.dart';

class SpecialistController extends GetxController{
   var specialist = <SpecialistModel>[].obs;
  var filteredSpecialist = <SpecialistModel>[].obs;
   var doctorsList = <DoctorList>[].obs;
  var isLoading = false.obs;

  void fetchSpecialist() async {
    try {
      isLoading.value = true;
      var hospitalList = await ApiGetServices().fetchSpecialist();
      print("✅✅✅✅✅");
      specialist.assignAll(hospitalList);
      filteredSpecialist.assignAll(hospitalList); // Initialize filtered list
    } catch (e) {
      print("Error fetching specialist: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void filterSpecialist(String query) {
    if (query.isEmpty) {
      filteredSpecialist.assignAll(specialist);
    } else {
      filteredSpecialist.assignAll(
        specialist.where((hospital) =>
            hospital.name.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }
  
  Future<void> fetchDoctorsList(String specialistId) async {
    try {
      isLoading.value = true;
      final doctros = await ApiGetServices().filterSpeciality(specialistId);
      // doctorsList.assignAll(doctros.where((hname) => hname.hospitalname.toLowerCase().startsWith('dig')));
      doctorsList.assignAll(doctros);
       doctorsList.refresh();
    } catch (e) {
      print("Error fetching Doctors: $e");
    }finally{
      isLoading.value = false;
    }
  }
  @override
  void onInit() {
    super.onInit();
    fetchSpecialist();
  }
}