import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/language_provider.dart';

class LangPick extends StatelessWidget {
  LangPick({super.key, required this.title, required this.onTap});

  final String title;
  final Function onTap;

  String dropdownvalue = "en";

  List<String> langs = ["ar", "en", "es"];
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(builder: (context, lp, _) {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[300],
            ),
            child: DropdownButton(
              value: lp.lang,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: langs.map((String langs) {
                return DropdownMenuItem(
                  value: langs,
                  child: Text(langs),
                );
              }).toList(),
              onChanged: (String? newValue) {
                dropdownvalue = newValue!;
                lp.switchLanguage(newValue);
              },
            ),
          )
        ],
      );
    });
  }
}
