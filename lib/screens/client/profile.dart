import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? dosya;

  profilePhotoUpdate() async {
    try {
      ImagePicker picker = ImagePicker();
      XFile? secilenDosya = await picker.pickImage(
        source: ImageSource.gallery,
        requestFullMetadata: false,
      );

      if (secilenDosya == null) {
        setState(() {
          dosya = null;
        });
        return;
      }

      setState(() {
        dosya = File(secilenDosya.path);
      });
    } on Exception catch (e) {
      print("Hata");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Gap(20),
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://upload.wikimedia.org/wikipedia/en/c/c6/NeoTheMatrix.jpg"),
                maxRadius: 64,
              ),
              const Gap(20),
              OutlinedButton(
                onPressed: profilePhotoUpdate,
                child:
                    const Text("Profil fotografini güncellemek için tiklayin."),
              ),
              const Gap(20),
              if (dosya != null) Image.file(dosya!),
            ],
          ),
        ),
      ),
    );
  }
}
