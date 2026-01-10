// import 'package:flutter/material.dart';

// class AddsScreen extends StatefulWidget {
//   final String imageUri;
//   const AddsScreen({super.key, required this.imageUri});

//   @override
//   State<AddsScreen> createState() => _AddsScreenState();
// }

// class _AddsScreenState extends State<AddsScreen> {
//    ImageProvider getImageProvider(String? uri) {
//     if ((uri?.isNotEmpty ?? false) && uri != "N/A") {
//       return NetworkImage(uri!);
//     } else {
//       return AssetImage('assets/default_image.png');
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: List.generate(5, (index) {
//           return Container(
//               width: 200,
//               height: 120,
//               margin: EdgeInsets.only(right: 12),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 image: DecorationImage(
//                   image: getImageProvider(widget.imageUri), // Replace with your own ad images
//                   fit: BoxFit.cover,
//                 ),
//               ));
//         }),
//       ),
//     );
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tele/views/screens/components/config.dart';

class AddsScreen extends StatefulWidget {
  final String imageUri;
  const AddsScreen({super.key, required this.imageUri});

  @override
  State<AddsScreen> createState() => _AddsScreenState();
}

class _AddsScreenState extends State<AddsScreen> {
  final url = Config.baseUrl;
  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
     final cardWith = screenWidth * 0.87;
    return Container(
      
      width: cardWith,
      height: 180,
      margin: EdgeInsets.only(right: 10,top: 00),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: (widget.imageUri.isNotEmpty && widget.imageUri != 'N/A')
              ? CachedNetworkImageProvider('$url/${widget.imageUri}')
              : AssetImage('assets/images/noads.png') as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
