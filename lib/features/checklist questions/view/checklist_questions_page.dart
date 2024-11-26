import 'package:flutter/material.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/config/petro_string.dart';
import 'package:nfc_petro/core/widgets/petro_app_bar.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';
import 'package:nfc_petro/core/widgets/petro_text_field.dart';

class ChecklistQuestionsPage extends StatefulWidget {
  const ChecklistQuestionsPage({
    super.key,
  });
  @override
  // ignore: library_private_types_in_public_api
  _ChecklistQuestionsPageState createState() => _ChecklistQuestionsPageState();
}

class _ChecklistQuestionsPageState extends State<ChecklistQuestionsPage> {
  // List to hold the selected answers for each question
  List<String?> answers = List<String?>.filled(15, null);
  List<String> questions = [
    'عدم انسداد کندانسور هوایی',
    'دمای وردی گلیکول',
    'هشدارهای صوتی یا تصویری بررسی شدند',
    'بازرسی گلاس چیلر',
    'ست پونت سیستم چیلر',
    'دمای خروجی گلیکول',
    'بارسی نشت گلیکول',
    'پمپ حرارتی',
    'فشار گاز',
    'نشت گاز در عناصر گرمایشی',
    'کانال ها و دریچه ها',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PetroAppBar(
        title: PetroString.cmmsChecklist,
        onPressed: () {},
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: questions.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PetroText(
                    questions[index],
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: PetroString.ok,
                        groupValue: answers[index],
                        onChanged: (value) {
                          setState(() {
                            answers[index] = value;
                          });
                        },
                      ),
                      const PetroText(
                        PetroString.ok,
                        size: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      Radio<String>(
                        value: PetroString.notOk,
                        groupValue: answers[index],
                        onChanged: (value) {
                          setState(() {
                            answers[index] = value;
                          });
                        },
                      ),
                      const PetroText(
                        PetroString.notOk,
                        size: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const PetroTextField(
                    hint: "نظرات",
                    minLines: 1,
                    maxLines: 5,
                  ),
                  const Divider(
                    color: PetroColors.darkBlue,
                    endIndent: 10,
                    indent: 10,
                    thickness: 2,
                    height: 20,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
