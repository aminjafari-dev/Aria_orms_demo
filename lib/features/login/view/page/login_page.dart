import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_petro/config/image_path.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/config/petro_radius.dart';
import 'package:nfc_petro/config/petro_string.dart';
import 'package:nfc_petro/core/data%20base/db_controller.dart';
import 'package:nfc_petro/core/get%20it/locator.dart';
import 'package:nfc_petro/core/router/page_router.dart';
import 'package:nfc_petro/core/service/main_service.dart';
import 'package:nfc_petro/core/widgets/petro_button.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';
import 'package:nfc_petro/core/widgets/petro_text_field.dart';
import 'package:nfc_petro/features/app%20setting/controller/app_setting_controller.dart';
import 'package:nfc_petro/features/login/controller/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = LoginController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FocusNode _usernameFocus = FocusNode();
  List<String> allUsers = [];
  List<String> filteredUsers = [];

  @override
  void initState() {
    super.initState();

    // Load all users from SharedPreferences
    fetchAllUsers();

    // Add listener to the username TextField
    _username.addListener(() {
      filterUsers(_username.text);
    });

    _usernameFocus.addListener(() {
      if (_usernameFocus.hasFocus) {
        filterUsers(_username.text); // Update suggestions when focused
      }
    });
  }

  @override
  void dispose() {
    _usernameFocus.dispose();
    _username.dispose();
    super.dispose();
  }

  Future<void> fetchAllUsers() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      allUsers = prefs.getStringList('registeredUsers') ?? [];
      filteredUsers =
          allUsers.reversed.take(10).toList(); // Initially show last 3 users
    });
  }

  void filterUsers(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredUsers = allUsers.reversed
            .take(10)
            .toList(); // Show last 3 users if query is empty
      } else {
        filteredUsers = allUsers
            .where((user) => user.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> saveUser(String username) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> users = prefs.getStringList('registeredUsers') ?? [];
    if (!users.contains(username)) {
      users.add(username);
      await prefs.setStringList('registeredUsers', users);
    }
  }

  @override
  Widget build(BuildContext context) {
    int count = 1;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    count++;
                    if (count > 3) {
                      await locator<AppSettingController>().getFromDB();
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, PageName.appSetting);
                      count = 1;
                    }
                  },
                  child: Image.asset(
                    ImagePath.orms,
                    height: 100,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: PetroColors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: PetroText(PetroString.signIn,
                              size: 20, color: Colors.white),
                        ),
                        const SizedBox(height: 20),
                        const PetroText(PetroString.userName,
                            size: 16, color: Colors.white),
                        PetroTextField(
                          hint: PetroString.pleaseEnterUserName,
                          controller: _username,
                          focusNode: _usernameFocus,
                        ),
                        const SizedBox(height: 5),
                        _lastUsersWidget(),
                        const SizedBox(height: 20),
                        const PetroText(PetroString.password,
                            size: 16, color: Colors.white),
                        PetroTextField(
                          hint: PetroString.pleaseEnterPassword,
                          controller: _password,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: PetroButton(
                        text: PetroString.login,
                        onPressed: () async {
                          await saveUser(_username.text); // Save the new user
                          if (await loginController.isUserValid(
                              _username.text, _password.text)) {
                            // ignore: use_build_context_synchronously
                            loginController.navigateToHome(context);
                          } else {
                            Get.snackbar("Error", "User not found");
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: PetroButton(
                        text: PetroString.synct,
                        onPressed: () async {
                          log(locator<MainService>().baseUrl);
                          if (await locator<MainService>()
                              .checkAPI
                              .apiCheck()) {
                            await locator<DbController>().clearUsersAndRoles();
                            locator<MainService>().userService.getUsers();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _lastUsersWidget() {
    if (_usernameFocus.hasFocus && filteredUsers.isNotEmpty) {
      return Container(
        constraints: BoxConstraints.loose(const Size(double.infinity, 127)),
        decoration: BoxDecoration(
          borderRadius: PetroRadius.radus_10,
          color: PetroColors.lightBlue,
        ),
        child: ListView(
          shrinkWrap: true,
          children: filteredUsers
              .map(
                (user) => InkWell(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PetroText(user),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 0,
                        indent: 10,
                        endIndent: 10,
                      )
                    ],
                  ),
                  onTap: () {
                    _username.text = user;
                    setState(() {
                      filteredUsers.clear(); // Hide the box
                    });
                  },
                ),
              )
              .toList(),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
