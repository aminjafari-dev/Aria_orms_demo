import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_petro/config/image_path.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/config/petro_padding.dart';
import 'package:nfc_petro/core/router/page_router.dart';
import 'package:nfc_petro/core/widgets/petro_gap.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';

class CheckListItem extends StatelessWidget {
  final String text;

  const CheckListItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, PageName.checklistQuestions);
      },
      child: Container(
        padding: PetroPadding.all_10,
        decoration: BoxDecoration(
          color: PetroColors.lightBlue,
          border: Border.all(color: PetroColors.blue, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SvgPicture.asset(ImagePath.package),
            PetroGap.gap_8,
            Expanded(
              child: PetroText(
                text,
                size: 20,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
