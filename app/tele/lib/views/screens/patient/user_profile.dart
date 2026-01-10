import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:tele/services/StorageService.dart';
import 'package:tele/controllers/language_controller.dart';
import 'package:tele/views/screens/components/change_password_screen.dart';
import 'package:tele/views/screens/components/config.dart';
import 'package:tele/views/screens/components/update_profile_picture_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final LanguageController languageController = Get.find<LanguageController>();
  final url = Config.baseUrl;
  String id = 'loading..';
  String name = 'loading..';
  String phone = 'loading..';
  String email = 'loading..';
  String username = 'loading..';
  String address = 'loading..';
  String age = 'loading..';
  String gender = 'loading..';
  String? picture;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    Map<String, String?> userData = await StorageService.getUserData();
    setState(() {
      id = userData['userId'] ?? '';
      name = userData['username'] ?? 'unknown';
      phone = userData['phone'] ?? 'N/A';
      address = userData['address'] ?? "N/A";
      username = userData['nickname'] ?? "N/A";
      gender = userData['gender'] ?? "N/A";
      age = userData['age'] ?? "N/A";
      email = userData['email'] ?? "N/A";
      picture = userData['picture'] ?? "N/A";
    });
  }

  void handleLogout() async {
    await StorageService.clearUserData(); // Clear saved user data
    Get.offAllNamed(
        '/login'); // Navigate to login screen & remove all previous screens
  }

  void updateProfileScreen(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (_) => UpdateProfilePictureScreen(id: id),
    );
  }

  void changePassword(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (_) => ChangePasswordScreen(id: id),
    );
  }

  // void showLanguageSelection(BuildContext context) {
  //   final LanguageController languageController =
  //       Get.find<LanguageController>();

  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.white,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (BuildContext context) {
  //       return Container(
  //         padding: EdgeInsets.all(20),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(
  //               'language_selection'.tr(),
  //               style: TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             Obx(() => ListTile(
  //                   leading: Icon(Icons.language),
  //                   title: Text('english'.tr()),
  //                   trailing: languageController.isEnglish
  //                       ? Icon(Icons.check, color: Colors.green)
  //                       : null,
  //                   onTap: () async {
  //                     await languageController.changeLanguage('en', context);
  //                     Navigator.pop(context);
  //                   },
  //                 )),
  //             Obx(() => ListTile(
  //                   leading: Icon(Icons.language),
  //                   title: Text('somali'.tr()),
  //                   trailing: languageController.isSomali
  //                       ? Icon(Icons.check, color: Colors.green)
  //                       : null,
  //                   onTap: () async {
  //                     await languageController.changeLanguage('so', context);
  //                     Navigator.pop(context);
  //                   },
  //                 )),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
void showLanguageSelection(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          Future<void> _confirmLanguageChange(String langCode) async {
            final shouldChange = await showModalBottomSheet<bool>(
              context: context,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (BuildContext ctx) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const Icon(Icons.language, size: 40, color: Colors.green),
                      const SizedBox(height: 12),
                      Text(
                        'confirm_language_change'.tr(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'app_will_restart'.tr(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  
                                ),
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white
                              ),
                              onPressed: () => Navigator.pop(ctx, false),
                              child: Text('cancel'.tr()),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white
                              ),
                              onPressed: () => Navigator.pop(ctx, true),
                              child: Text('apply'.tr()),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );

            if (shouldChange == true) {
              await Get.find<LanguageController>().changeLanguage(langCode, context);
              if (context.mounted) Navigator.pop(context);
            }
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Text(
                  'language_selection'.tr(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text('english'.tr()),
                  trailing: context.locale.languageCode == 'en'
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () => _confirmLanguageChange('en'),
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text('somali'.tr()),
                  trailing: context.locale.languageCode == 'so'
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () => _confirmLanguageChange('so'),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}





  @override
  Widget build(BuildContext context) {
    // Sync language controller with context on build
    // languageController.syncWithContext(context);
    
    return Scaffold(
          backgroundColor: const Color(0xFF118C11), // Green background
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text('profile'.tr(), style: TextStyle(color: Colors.white)),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // This Column holds the white container and leaves space at the top
                Column(
                  children: [
                    // Leave space so the CircleAvatar can overlap the white container
                    const SizedBox(height: 60),

                    // The main white container
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 90),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Personal Information Section
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "personal_information".tr(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _buildInfoRow(
                                  Icons.person,
                                  'name'.tr(),
                                  name,
                                ),
                                _buildInfoRow(
                                  Icons.public,
                                  'country'.tr(),
                                  'somalia'.tr(),
                                ),
                                _buildInfoRow(
                                  Icons.phone,
                                  'phone'.tr(),
                                  phone,
                                ),
                                _buildInfoRow(Icons.email, 'email'.tr(), email),
                                _buildInfoRow(
                                  Icons.person_outline,
                                  'username'.tr(),
                                  username,
                                ),
                                _buildInfoRow(
                                  Icons.location_on,
                                  'address'.tr(),
                                  address,
                                ),
                                _buildInfoRow(
                                  Icons.person,
                                  'gender'.tr(),
                                  gender,
                                ),
                                _buildInfoRow(
                                  Icons.cake,
                                  'age'.tr(),
                                  age,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Settings Section
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "settings".tr(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _buildSettingsRow(
                                    Icons.person, 'change_profile_picture'.tr(),
                                    onTap: () => updateProfileScreen(context)),
                                _buildSettingsRow(
                                    Icons.lock, 'change_password'.tr(),
                                    onTap: () => changePassword(context)),
                                // _buildSettingsRow(Icons.pin, 'Change Pin'),
                                _buildSettingsRow(
                                    Icons.language, 'change_language'.tr(),
                                    onTap: () =>
                                        showLanguageSelection(context)),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // // downloads
                          // Container(
                          //   padding: const EdgeInsets.all(16),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(15),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Colors.black12,
                          //         blurRadius: 5,
                          //         spreadRadius: 2,
                          //       ),
                          //     ],
                          //   ),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       const Text(
                          //         "Downloads",
                          //         style: TextStyle(
                          //           fontSize: 16,
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //       const SizedBox(height: 10),
                          //       // _buildDownloadsRow(Icons.person, 'Downloads',onTap:() => updateProfileScreen(context)),
                          //       _buildDownloadsRow(
                          //           Icons.download, 'Offline Downloads', onTap: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (_) => OfflineSavedItemsScreen()),
                          //         );
                          //       }),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "other".tr(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _buildSettingsRow(
                                    Icons.qr_code, 'share_qr_code'.tr()),
                                _buildSettingsRow(
                                    Icons.share, 'share_apk'.tr()),
                                _buildSettingsRow(Icons.logout, 'log_out'.tr(),
                                    onTap: handleLogout),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Circle Avatar + Pending status (overlapping the white container)
                Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white, // White border effect
                      child: CircleAvatar(
                        radius: 47,
                        backgroundImage:
                            (picture?.isNotEmpty ?? false) && picture != "N/A"
                                ? NetworkImage('$url/$picture')
                                : AssetImage('assets/default_image.png')
                                    as ImageProvider,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "pending".tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
  }

  // Helper widget to build each info row in the Personal Information section
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.black, size: 20),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build each row in the Settings section
  Widget _buildSettingsRow(IconData icon, String title, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: 20),
            const SizedBox(width: 10),
            Text(title),
          ],
        ),
      ),
    );
  }

//   // Helper widget to build each row in the Settings section
//   Widget _buildDownloadsRow(IconData icon, String title,
//       {VoidCallback? onTap}) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         child: Row(
//           children: [
//             Icon(icon, color: Colors.black, size: 20),
//             const SizedBox(width: 10),
//             Text(title),
//           ],
//         ),
//       ),
//     );
//   }
}
