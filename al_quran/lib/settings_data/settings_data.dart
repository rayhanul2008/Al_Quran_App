import 'package:shared_preferences/shared_preferences.dart';

class SettingsData {
  double arabicFontSize;
  double banglaFontSize;
  double englishFontSize;
  bool showArabic = true;
  bool showBangla = true;
  bool showEnglish = true;
  SettingsData(
    this.arabicFontSize,
    this.banglaFontSize,
    this.englishFontSize,
    this.showArabic,
    this.showBangla,
    this.showEnglish,
  );

  get stream => null;
}

class LoadData {
  double arabicFontSize = 28;
  double banglaFontSize = 20;
  double englishFontSize = 20;
  bool showArabic = true;
  bool showBangla = true;
  bool showEnglish = true;
  Stream<SettingsData> stream() async* {
    SharedPreferences pref = await SharedPreferences.getInstance();
    yield* Stream.periodic(const Duration(milliseconds: 300), (i) {
      arabicFontSize = pref.getDouble("arabicFontSize") ?? 28;
      banglaFontSize = pref.getDouble("banglaFontSize") ?? 20;
      englishFontSize = pref.getDouble("englishFontSize") ?? 20;
      showArabic = pref.getBool("showArabic") ?? true;
      showBangla = pref.getBool("showBangla") ?? true;
      showEnglish = pref.getBool("showEnglish") ?? true;
      return SettingsData(
        arabicFontSize,
        banglaFontSize,
        englishFontSize,
        showArabic,
        showBangla,
        showEnglish,
      );
    });
  }
}
