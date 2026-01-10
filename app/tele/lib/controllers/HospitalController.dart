import 'package:get/get.dart';
import 'package:tele/Models/doctors_list_nodel.dart';
import 'package:tele/Models/hospital_model.dart';
import 'package:tele/services/get_api_services.dart';

class HospitalController extends GetxController {
  var hospitals = <Hospital>[].obs;
  var filteredHospitals = <Hospital>[].obs;
  var isLoading = false.obs;

   var doctorsList = <DoctorList>[].obs;

  void fetchHospitals() async {
    try {
      isLoading.value = true;
      var hospitalList = await ApiGetServices().fetchHospitals();

      hospitals.assignAll(hospitalList);
      filteredHospitals.assignAll(hospitalList); // Initialize filtered list
    } catch (e) {
      print("Error fetching hospitals: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void filterHospitals(String query) {
    if (query.isEmpty) {
      filteredHospitals.assignAll(hospitals);
    } else {
      filteredHospitals.assignAll(
        hospitals.where((hospital) =>
            hospital.name.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }

  Future<void> fetchDoctorsList(String hospitalId) async {
    try {
      isLoading.value = true;
      final doctros = await ApiGetServices().filterHospital(hospitalId);
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
    fetchHospitals();
  }
}
