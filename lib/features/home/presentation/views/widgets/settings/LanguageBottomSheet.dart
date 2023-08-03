import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/navigator.dart';
import '../../../view_model/provider/AppConfigProvider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({Key? key}) : super(key: key);

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    AppConfigProvider provider=Provider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
            onTap: (){
              provider.setNewLanguage('en');
              hideLoadingDialog(context);

            },
            child: getMainView("English",provider.appLanguage=="en" )),
        InkWell(
            onTap: (){
              provider.setNewLanguage('ar');
              hideLoadingDialog(context);
            },
            child: getMainView("العربية", provider.appLanguage=="ar"))
      ],
    );
  }
  Widget getMainView(String lang, bool selected){
    if(selected==true){
      return Container(
        margin: const EdgeInsets.all(16),
        child: Row(
          children: [
            Text(lang,style: TextStyle(color: Theme.of(context).primaryColor),),
            const Spacer(),
            Icon(Icons.check,color: Theme.of(context).primaryColor,)
          ],
        ),
      );
    }else{
      return  Container(
          margin: const EdgeInsets.all(16),
          child: Text(lang));
    }
  }
}
