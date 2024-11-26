import 'package:flutter/material.dart';
import 'package:nfc_petro/config/petro_padding.dart';

class PetroScaffold extends StatelessWidget {
  const PetroScaffold(
      {super.key,
      required this.body,
      this.padding = PetroPadding.all_12,
      this.appbar});

  final Widget body;
  final EdgeInsetsGeometry padding;
  final PreferredSizeWidget? appbar;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appbar ,
        body: Padding(
          padding: padding,
          child: body,
        ),
      ),
    );
  }
}
