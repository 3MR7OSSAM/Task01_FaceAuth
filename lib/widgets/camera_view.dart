// import 'dart:typed_data';
// import 'package:face_camera/face_camera.dart';
// import 'package:flutter/material.dart';
//
// class CameraView extends StatefulWidget {
//   const CameraView({
//     Key? key,
//     required this.onImage,
//   }) : super(key: key);
//
//   final Function(Uint8List image) onImage;
//
//   @override
//   State<CameraView> createState() => _CameraViewState();
// }
//
// class _CameraViewState extends State<CameraView> {
//   Uint8List? _imageBytes;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: double.infinity,
//           height: 300,
//           decoration: const BoxDecoration(
//             color: Colors.yellowAccent,
//           ),
//           child: _imageBytes != null
//               ? Image.memory(
//             _imageBytes!,
//             fit: BoxFit.cover,
//           )
//               : const Center(
//             child: Icon(
//               Icons.camera_alt,
//               size: 32,
//               color: Color(0xff2E2E2E),
//             ),
//           ),
//         ),
//         const SizedBox(height: 12),
//         ElevatedButton(
//           onPressed: _captureImage,
//           child: const Text(
//             "Click here to Capture",
//             style: TextStyle(fontSize: 14),
//           ),
//         ),
//         const SizedBox(height: 12),
//       ],
//     );
//   }
//
//   Future<void> _captureImage() async {
//     // Open face camera and capture the image
//     final image = await showDialog<Uint8List>(
//       context: context,
//       builder: (BuildContext context) => FaceDetectorView(),
//     );
//
//     if (image != null) {
//       setState(() {
//         _imageBytes = image;
//       });
//       widget.onImage(image);
//     }
//   }
// }
//
// class FaceDetectorView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Face Camera")),
//       body: SmartFaceCamera(
//         onCapture: (image) {
//           Navigator.of(context).pop(image); // Return captured image
//         },
//       ),
//     );
//   }
// }
