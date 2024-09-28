import 'dart:convert';
import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:face_detector/model/face_features.dart';
import 'package:face_detector/model/user_model.dart';
import 'package:face_detector/services/extract_features.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? _capturedImage;
  FaceFeatures? _faceFeatures;
  bool isRegistering = false;

  late FaceCameraController _controller;

  final _formFieldKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    _controller = FaceCameraController(
      autoCapture: true,
      defaultCameraLens: CameraLens.front,
      onCapture: (File? image) {
        setState(() {
          _capturedImage = image;
        });
      },
      onFaceDetected: (Face? face) {
        // You can handle face detection events here
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Register User"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Display the captured image or the face camera view
            _capturedImage != null
                ? Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.file(
                    _capturedImage!,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _controller.startImageStream();
                      setState(() => _capturedImage = null);
                    },
                    child: const Text(
                      'Capture Again',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            )
                : SmartFaceCamera(
              controller: _controller,
              messageBuilder: (context, face) {
                if (face == null) {
                  return _buildMessage('Place your face in the camera');
                }
                if (!face.wellPositioned) {
                  return _buildMessage('Center your face in the square');
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 16),
            if (_capturedImage != null) _buildForm(context),
          ],
        ),
      ),
    );
  }

  // Message widget displayed during face alignment
  Widget _buildMessage(String message) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
    child: Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 14,
        height: 1.5,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  // Form for user registration
  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formFieldKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter user name',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text("Start Registering"),
              onPressed: () async {
                await _registerUser();
              },
            ),
          ],
        ),
      ),
    );
  }

  // Function to handle user registration
  Future<void> _registerUser() async {
    if (_capturedImage == null) {
      showToast('No image captured. Please try again.');
      return;
    }

    if (_formFieldKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      _showLoadingDialog();

      try {
        final String imageString = base64Encode(await _capturedImage!.readAsBytes());
        final userId = const Uuid().v1();
        final user = UserModel(
          id: userId,
          name: _nameController.text.trim(),
          image: imageString,
          registeredOn: DateTime.now(),
          faceFeatures: _faceFeatures,
        );

        final box = Hive.box<UserModel>('users');
        await box.put(userId, user);

        showToast('Registered successfully');
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context); // Go back to previous screen
        });
      } catch (e) {
        showToast('Registration failed. Please try again.');
      } finally {
        Navigator.of(context).pop();
      }
    }
  }

  // Helper method to show a toast message
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }

  // Helper method to show a loading dialog
  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
