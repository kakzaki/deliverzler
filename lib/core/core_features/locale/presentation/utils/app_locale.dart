import 'package:deliverzler/core/presentation/helpers/localization_helper.dart';
import 'package:deliverzler/core/presentation/styles/app_images.dart';
import 'package:flutter/material.dart';

enum AppLocale {
  english('en', AppImages.languageIconEnglish),
  arabic('ar', AppImages.languageIconArabic);

  const AppLocale(this.code, this.flag);

  final String code;
  final String flag;
}

extension LanguageExtension on AppLocale {
  String getLanguageName(BuildContext context) {
    switch (this) {
      case AppLocale.arabic:
        return tr(context).arabic;
      case AppLocale.english:
        return tr(context).english;
    }
  }
}
