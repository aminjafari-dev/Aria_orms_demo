import 'package:flutter/material.dart';
import 'package:nfc_petro/config/image_path.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';

// ignore: must_be_immutable
class PetroAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subTitle;
  void Function()? onPressed;
  PetroAppBar(
      {super.key, required this.title, required this.onPressed, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Image.asset(
          ImagePath.logo,
        ),
      ),
      title: Column(
        children: [
          PetroText(
            title,
            color: Colors.white,
            size: 20,
            fontWeight: FontWeight.bold,
          ),
          if (subTitle != null)
            PetroText(subTitle!, color: Colors.white, size: 20),
        ],
      ),
      actions: [
        IconButton(
            icon:const Icon(
              Icons.menu_rounded,
              color: Colors.white,
              size: 35,
            ),
            onPressed: onPressed??(){
              
            })
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
