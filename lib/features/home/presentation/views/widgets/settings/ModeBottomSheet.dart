import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../view_model/provider/AppConfigProvider.dart';

class ModeBottomSheet extends StatefulWidget {
  const ModeBottomSheet({Key? key}) : super(key: key);

  @override
  State<ModeBottomSheet> createState() => _ModeBottomSheetState();
}

class _ModeBottomSheetState extends State<ModeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    AppConfigProvider provider=Provider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
            onTap: (){
              provider.setNewMode(ThemeMode.light);
            },
            child: getMainView(AppLocalizations.of(context)!.light,
                provider.mode==ThemeMode.light )),
        InkWell(
            onTap: (){
              provider.setNewMode(ThemeMode.dark);
            },
            child: getMainView(AppLocalizations.of(context)!.dark,
                provider.mode==ThemeMode.dark))
      ],
    );
  }
  Widget getMainView(String theme, bool selected){
    if(selected==true){
      return Container(
        margin: const EdgeInsets.all(16),
        child: Row(
          children: [
            Text(theme,style: TextStyle(color: Theme.of(context).primaryColor),),
            const Spacer(),
            Icon(Icons.check,color: Theme.of(context).primaryColor,)
          ],
        ),
      );
    }else{
      return  Container(
          margin: const EdgeInsets.all(16),
          child: Text(theme));
    }
  }
}