import 'package:get/get.dart';
import 'package:tele/Models/adds_model.dart';
import 'package:tele/services/get_api_services.dart';

class AddsController extends GetxController{
  var isLoading = false.obs;
  var adds = <AddsModel>[].obs;
  Future<void> allAdds() async{
    try {
      isLoading.value = true;
      final response = await ApiGetServices.adds();
      adds.assignAll(response);
    } catch (e) {
      print("Error fetching hospitals: $e");
    }finally{
      isLoading.value = false;
    }
  }
   @override
  void onInit() {
    super.onInit();
   allAdds();
  }
}