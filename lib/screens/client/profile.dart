// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? dosya;
  String boyutlar = "";
  File? cacheFile;

  profiliVarsaYukle() async {
    final Directory appCacheDir = await getApplicationCacheDirectory();
    File f = File("${appCacheDir.path}/avatar.jpg");

    if (f.existsSync()) {
      print("dosya bulundu");
      setState(() {
        cacheFile = f;
      });
    } else {
      print("dosya bulunmadi");
    }
  }

  @override
  void initState() {
    super.initState();
    profiliVarsaYukle();
  }

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

      var fileLength = await secilenDosya.length();

      var fileType = secilenDosya.name.split(".").last;

      bool canIResize = false;

      switch (fileType.toLowerCase()) {
        case ("jpg"):
        case ("jpeg"):
        case ("png"):
          canIResize = true;
          break;
      }

      if (!canIResize) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Dosya boyutu"),
            content: Text("dosya tipi geçersiz."),
          ),
        );
        return;
      }

      img.Image? temp;

      if (fileType.toLowerCase() == "jpg" || fileType.toLowerCase() == "jpeg") {
        temp = img.decodeJpg(File(secilenDosya.path).readAsBytesSync());
      } else if (fileType.toLowerCase() == "png") {
        temp = img.decodePng(File(secilenDosya.path).readAsBytesSync());
      }

      if (temp!.width < 500 || temp.height < 500 || temp == null) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Dosya boyutu"),
            content:
                Text("en az 500px yükseklik ve genislige sahip dosya seciniz."),
          ),
        );
        return;
      }

      img.Image thumbnail;

      if (temp.width >= temp.height) {
        thumbnail = img.copyResize(temp, height: 500);
      } else {
        thumbnail = img.copyResize(temp, width: 500);
      }
      final resizedDosyaVerileri = img.encodeJpg(thumbnail, quality: 85);

      final Directory tempDir = await getTemporaryDirectory();
      final Directory appSupportDir = await getApplicationSupportDirectory();
      final Directory appCacheDir = await getApplicationCacheDirectory();


      File yeniFile = File("${appCacheDir.path}/avatar.jpg");
      yeniFile.writeAsBytesSync(resizedDosyaVerileri);
      setState(() {
        dosya = yeniFile;
        boyutlar = "${temp!.width}x${temp.height}";
        cacheFile = yeniFile;
      });
    } on Exception catch (e) {
      print("Hata");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Gap(20),
              if (cacheFile == null)
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/en/c/c6/NeoTheMatrix.jpg"),
                  maxRadius: 64,
                ),
              if (cacheFile != null)
                CircleAvatar(
                  backgroundImage: FileImage(cacheFile!),
                  maxRadius: 64,
                ),
              const Gap(20),
              OutlinedButton(
                onPressed: profilePhotoUpdate,
                child:
                    const Text("Profil fotografini güncellemek için tiklayin."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
