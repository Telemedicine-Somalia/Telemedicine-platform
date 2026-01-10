// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:tele/services/StorageService.dart';

// class LanguageController extends GetxController {
//   var currentLanguage = 'en'.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadSavedLanguage();
//   }

//   Future<void> loadSavedLanguage() async {
//     String savedLanguage = await StorageService.getLanguage();
//     if (savedLanguage.isEmpty) savedLanguage = 'en';
//     currentLanguage.value = savedLanguage;
//   }

//   // Sync with EasyLocalization context when app starts
//   void syncWithContext(BuildContext context) {
//     String contextLanguage = context.locale.languageCode;
//     if (contextLanguage != currentLanguage.value) {
//       currentLanguage.value = contextLanguage;
//     }
//   }

//   // Future<void> changeLanguage(String languageCode, BuildContext context) async {
//   //   await StorageService.saveLanguage(languageCode);
//   //   currentLanguage.value = languageCode;
//   //   await context.setLocale(Locale(languageCode));
//   //   // The Obx wrapper will automatically rebuild the UI
//   // }
//   Future<void> changeLanguage(String languageCode, BuildContext context) async {
//     await context.setLocale(Locale(languageCode)); // triggers rebuild
//     await StorageService.saveLanguage(
//         languageCode); // if you still need custom storage
//     currentLanguage.value = languageCode;
//   }

//   bool get isSomali => currentLanguage.value == 'so';
//   bool get isEnglish => currentLanguage.value == 'en';
// }
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:tele/services/StorageService.dart';

// class LanguageController extends GetxController {
//   var currentLanguage = 'en'.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadSavedLanguage();
//   }

//   Future<void> loadSavedLanguage() async {
//     String savedLanguage = await StorageService.getLanguage();
//     if (savedLanguage.isEmpty) savedLanguage = 'en';
//     currentLanguage.value = savedLanguage;
//   }

//   Future<void> changeLanguage(String languageCode, BuildContext context) async {
//     await context.setLocale(Locale(languageCode)); // triggers EasyLocalization rebuild
//     await StorageService.saveLanguage(languageCode); // optional custom storage
//     currentLanguage.value = languageCode;
//   }

//   bool get isSomali => currentLanguage.value == 'so';
//   bool get isEnglish => currentLanguage.value == 'en';
// }


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tele/main.dart';
import 'package:tele/services/StorageService.dart';

class LanguageController extends GetxController {
  var currentLanguage = 'en'.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedLanguage();
  }

  Future<void> loadSavedLanguage() async {
    String savedLanguage = await StorageService.getLanguage();
    if (savedLanguage.isEmpty) savedLanguage = 'en';
    currentLanguage.value = savedLanguage;
    // Force update the locale if it's different from saved
    final context = navigatorKey.currentContext;
    if (context != null && context.locale.languageCode != savedLanguage) {
      await context.setLocale(Locale(savedLanguage));
    }
  }

  Future<void> changeLanguage(String languageCode, BuildContext context) async {
    await context.setLocale(Locale(languageCode));
    await StorageService.saveLanguage(languageCode);
    currentLanguage.value = languageCode;
    // Force rebuild the entire app
    Get.forceAppUpdate();
  }

  bool get isSomali => currentLanguage.value == 'so';
  bool get isEnglish => currentLanguage.value == 'en';
}