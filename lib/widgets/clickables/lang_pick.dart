import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/dark_mode_provider.dart';
import 'package:to_do/providers/language_provider.dart';

// ignore: must_be_immutable
class LangPick extends StatelessWidget {
  LangPick({super.key,});

  String dropdownvalue = "en";

  List<String> langs = ["ar", "en", "es"];

  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageProvider, DarkModeProvider>(builder: (context, lp,dm, _) {
      return Column(
        children: [
          Container(
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color:dm.isDark ? Colors.blueGrey : Colors.grey[300],
              border: Border.all(color: dm.isDark ? Colors.blueGrey : Colors.grey, width: 1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: DropdownButton(
              value: lp.lang,
              icon:  Icon(Icons.keyboard_arrow_down,
                  color: dm.isDark ? Colors.white: Colors.grey),
              iconSize: 24,
              style: TextStyle(color: dm.isDark ? Colors.white: Colors.grey[800], fontSize: 16),
              items: langs.map((String lang) {
                return DropdownMenuItem(
                  value: lang,
                  child: Text(lang),
                );
              }).toList(),
              onChanged: (String? newValue) {
                dropdownvalue = newValue!;
                lp.switchLanguage(newValue);
              },
              dropdownColor:dm.isDark ? Colors.blueGrey :  Colors.white,
              focusColor: Colors.grey[300],
              elevation: 4,
            ),
          )
        ],
      );
    });
  }
}
