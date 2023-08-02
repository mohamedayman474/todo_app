import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../view_model/provider/AppConfigProvider.dart';
import 'LanguageBottomSheet.dart';
import 'ModeBottomSheet.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    AppConfigProvider provider=Provider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            margin: const EdgeInsets.all(16),
            child: Text(AppLocalizations.of(context)!.language,
              textAlign: TextAlign.start,style: Theme.of(context).textTheme.titleSmall,)),
        InkWell(
          onTap: () {
            showLanguageBottomSheet();
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Theme
                    .of(context)
                    .primaryColor)
            ),
            child: Row(
              children: [
                Text(provider.appLanguage=="en"?"English":"العربية"),
                const Spacer(),
                Icon(Icons.arrow_drop_down, color: Theme
                    .of(context)
                    .primaryColor,)

              ],
            ),
          ),
        ),
        Container(
            margin: const EdgeInsets.all(16),
            child: Text(AppLocalizations.of(context)!.mode,
                textAlign: TextAlign.start,style: Theme.of(context).textTheme.titleSmall)),
        InkWell(
          onTap: () {
            showModeBottomSheet();
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Theme
                    .of(context)
                    .primaryColor)
            ),
            child: Row(
              children: [
                Text(provider.mode==ThemeMode.light?AppLocalizations.of(context)!.light
                    : AppLocalizations.of(context)!.dark),
                const Spacer(),
                Icon(Icons.arrow_drop_down, color: Theme
                    .of(context)
                    .primaryColor,)

              ],
            ),
          ),
        )
      ],
    );
  }


  void showLanguageBottomSheet() {
    showModalBottomSheet(context: context, builder: (context) {
      return LanguageBottomSheet();
    });
  }


  void showModeBottomSheet() {
    showModalBottomSheet(context: context,
        builder: (context) {
          return ModeBottomSheet();
        });
  }
}