import 'package:flutter/material.dart';
import 'package:nfc_petro/config/image_path.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/features/splash/controller/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashController _splashController = SplashController();
  @override
  void initState() {
    _splashController.navigateToHome(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PetroColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImagePath.colleague,
              height: 200,
            ),
            Image.asset(
              ImagePath.orms,
              height: 87,
            ),
          ],
        ),
      ),
    );
  }
}
