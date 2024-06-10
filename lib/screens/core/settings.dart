import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String camResult = "Reddedildi";
  String locationResult = "Reddedildi";
  String locationInfo = "";
  bool loading = false;

  @override
  void initState() {
    super.initState();
    // İzinleri kontrol et
    checkPermissions();

    // İzin durumlarını başlangıçta "Reddedildi" olarak ayarla
    setState(() {
      camResult = "Reddedildi";
      locationResult = "Reddedildi";
    });
  }

  // İzinleri kontrol eden metod
  void checkPermissions() async {
    var camStatus = await Permission.camera.status;
    var locationStatus = await Permission.location.status;

    setState(() {
      // İzin durumlarını güncelle
      camResult = _getStatusString(camStatus);
      locationResult = _getStatusString(locationStatus);
    });
  }

  // İzin durumlarını stringe dönüştüren metod
  String _getStatusString(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.denied:
        return "Reddedildi.";
      case PermissionStatus.granted:
        return "İzin Verildi.";
      case PermissionStatus.restricted:
        return "Yetki sınırlı.";
      case PermissionStatus.limited:
        return "Yetki kısıtlı.";
      case PermissionStatus.permanentlyDenied:
        return "Yetki kalıcı olarak reddedildi.";
      case PermissionStatus.provisional:
        return "Yetki geçici olarak verildi.";
      default:
        return "Bilinmeyen durum.";
    }
  }

  // Kamera izni açma metod
  void openCameraSettings() async {
    // Kullanıcıya kamera izni talebi göster
    var status = await Permission.camera.request();

    // İzin durumunu güncelle
    setState(() {
      if (status == PermissionStatus.granted) {
        camResult = "İzin Verildi";
      }
    });
  }

  // Konum izni açma metod
  void openLocationSettings() async {
    // Kullanıcıya konum izni talebi göster
    var status = await Permission.location.request();

    // İzin durumunu güncelle
    setState(() {
      if (status == PermissionStatus.granted) {
        locationResult = "İzin Verildi";
      }
    });
  }

  // Konum bilgisi almak için metod
  void getLocation() async {
    // Eğer widget aktif değilse işlem yapma
    if (!mounted) return;

    // İşlem başladığında loading durumunu true yap
    setState(() {
      loading = true;
    });

    // Konum servisi açık mı kontrol et
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // Konum servisi kapalıysa bilgi ver ve işlemi sonlandır
    if (!serviceEnabled) {
      setState(() {
        locationInfo = "Konum Hizmetleri Ayarlardan Kapalı";
        loading = false;
      });
      return;
    }

    // Konum izni kontrol et
    LocationPermission permission = await Geolocator.checkPermission();
    // Konum izni reddedildiyse bilgi ver ve işlemi sonlandır
    if (permission == LocationPermission.denied) {
      setState(() {
        locationInfo = "Reddedildi.";
        loading = false;
      });
      return;
    }

    // Konum izni kalıcı olarak reddedildiyse bilgi ver ve işlemi sonlandır
    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationInfo = "Kapatıldı.";
        loading = false;
      });
      return;
    }

    // Konum bilgisini al
    final pos = await Geolocator.getCurrentPosition();

    // Konum bilgisini güncelle ve işlemi sonlandır
    setState(() {
      locationInfo = '''
        accuracy: ${pos.accuracy}
        longitude: ${pos.longitude}
        latitude: ${pos.latitude}
        speed: ${pos.speed}
        speed Dikkati: ${pos.speedAccuracy}
        veri zamani: ${pos.timestamp}
        ''';
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar"),
      ),
      body: SizedBox.expand(
        child: ListView(
          children: [
            ExpansionTile(
              title: const Text("Kamera İzni"),
              children: [
                Text(camResult),
                const Gap(20),
                ElevatedButton(
                  onPressed: openCameraSettings,
                  child: const Text("İzin Al"),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("Konum İzni"),
              children: [
                Text(locationResult),
                const Gap(20),
                ElevatedButton(
                  onPressed: openLocationSettings,
                  child: const Text("İzin Al"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
