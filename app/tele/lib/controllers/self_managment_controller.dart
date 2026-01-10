import 'package:get/get.dart';
import 'package:tele/Models/self_managment_models.dart';
import 'package:tele/services/get_api_services.dart';

class SelfManagmentController extends GetxController{
  var isLoading = false.obs;
  var selfManagments = <SelfManagmentModels>[].obs;
  var filteredSelfManagments = <SelfManagmentModels>[].obs;

  void selfManagment() async {
    try {
      isLoading.value = true;
      final selfmanagment = await ApiGetServices().selfManagment();
      selfManagments.assignAll(selfmanagment);
      filteredSelfManagments.assignAll(selfmanagment);
    } catch (e) {
      print("Error fetching hospitals: $e");
    }finally{
      isLoading.value = false;
    }
  }
  // filteredSelfManagments
   void filteredSelfManagment(String query){
    if(query.isEmpty){
      filteredSelfManagments.assignAll(selfManagments);
    } else{
      filteredSelfManagments.assignAll(
        selfManagments.where((self) => self.title.toLowerCase().contains(query.toLowerCase()))
        );
    }
  }
   @override
  void onInit() {
    super.onInit();
   selfManagment();
  }

}