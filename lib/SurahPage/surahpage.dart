import 'package:al_quran/settings_data/settings_data.dart';
import 'package:flutter/material.dart';
import 'package:al_quran/Classes/classes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class SurahPage extends StatefulWidget {
  const SurahPage({Key? key, required this.surah}) : super(key: key);
  final Surah surah;

  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  List<Ayat> ayats = [];
  bool showSettings = false;
  double arabicFontSize = 28;
  double banglaFontSize = 20;
  double englishFontSize = 20;
  bool showArabic = true;
  bool showBangla = true;
  bool showEnglish = true;

  @override
  void initState() {
    for (int i = 0; i < widget.surah.ayats.length; i++) {
      ayats.add(Ayat(
        ayatNo: widget.surah.ayats[i]["Ayat No"] ??
            i + 1, // Default to 0 if it's null.
        ayat: widget.surah.ayats[i]["Ayat"] ??
            "", // Default to an empty string if it's null.
        banglaTranslation: widget.surah.ayats[i]["Bangla Translation"] ??
            "", // Default to an empty string if it's null.
        englishTranslation: widget.surah.ayats[i]["English Translation"] ??
            "", // Default to an empty string if it's null.
      ));
    }
    super.initState();
  }

  String space = " " * 1000;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SettingsData>(
        stream: LoadData().stream(),
        builder: (context, snapshot) {
          arabicFontSize =
              snapshot.hasData ? snapshot.data!.arabicFontSize : 28;
          banglaFontSize =
              snapshot.hasData ? snapshot.data!.banglaFontSize : 20;
          englishFontSize =
              snapshot.hasData ? snapshot.data!.englishFontSize : 20;
          showArabic = snapshot.hasData ? snapshot.data!.showArabic : true;
          showBangla = snapshot.hasData ? snapshot.data!.showBangla : true;
          showEnglish = snapshot.hasData ? snapshot.data!.showEnglish : true;
          return showSettings
              ? settings(snapshot.data)
              : Scaffold(
                  //backgroundColor: const Color(0xFF8FC9C1),
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  appBar: AppBar(
                    actions: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            showSettings = true;
                          });
                        },
                        icon: const Icon(Icons.settings),
                      ),
                    ],
                    //backgroundColor: const Color(0xFF0F8A7A),
                    backgroundColor: const Color.fromARGB(255, 20, 174, 156),
                    title: Text(
                      widget.surah.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    centerTitle: true,
                  ),
                  body: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: ayats.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(15),
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 241, 245, 246),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 169, 169, 169)
                                    .withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(
                                    1, -1), // changes position of shadow
                              ),
                            ]),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //textDirection: TextDirection.rtl,
                          children: [
                            Text(
                              "আয়াত: ${NumberFormat.decimalPattern('bn').format(ayats[index].ayatNo)}",
                              style: const TextStyle(
                                fontSize: 10,
                                //fontWeight: FontWeight.w600,
                              ),
                              textAlign:
                                  TextAlign.left, // Align text to the left.
                            ),
                            //const SizedBox(height: 8),

                            showArabic
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      ayats[index].ayat + space,
                                      style: TextStyle(
                                        fontFamily: "uthman",
                                        fontSize: arabicFontSize,
                                      ),
                                      textAlign: TextAlign
                                          .right, // Align text to the right.
                                    ),
                                  )
                                : const SizedBox(),
                            showBangla
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(ayats[index].banglaTranslation,
                                        style: TextStyle(
                                          fontFamily: "kalpurush",
                                          fontSize: banglaFontSize,
                                        ),
                                        textAlign: TextAlign.left),
                                  )
                                : const SizedBox(),
                            showEnglish
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(ayats[index].englishTranslation,
                                        style: TextStyle(
                                          fontFamily: "lato",
                                          fontSize: englishFontSize,
                                        ),
                                        textAlign: TextAlign.left),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      );
                    },
                  ),
                );
        });
  }

  Widget settings(SettingsData? data) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 174, 156),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                showSettings = false;
              });
            },
            icon: const Icon(Icons.pages),
          ),
        ],
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            fontSizeChanger("arabicFontSize", "Arabic", data!.arabicFontSize),
            visibleChanger("showArabic", "Show Arabic", data.showArabic),
            fontSizeChanger("banglaFontSize", "Bangla", data.banglaFontSize),
            visibleChanger("showBangla", "Show Bangla", data.showBangla),
            fontSizeChanger("englishFontSize", "English", data.englishFontSize),
            visibleChanger("showEnglish", "Show English", data.showEnglish),
          ],
        ),
      ),
    );
  }

  Widget fontSizeChanger(String key, String name, double fontSize) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 241, 245, 246),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 169, 169, 169).withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(1, -1), // changes position of shadow
            ),
          ]),
      width: double.infinity,
      child: Column(children: [
        Text(
          "$name Font Size",
          style: TextStyle(
            fontSize: fontSize,
          ),
        ),
        Slider(
          onChanged: (val) {
            //print(val);
            doubleSetter(key, val);
          },
          value: fontSize,
          max: 45,
          min: 9,
          //divisions: 37,
        )
      ]),
    );
  }

  doubleSetter(String key, double value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setDouble(key, value);
  }

  Widget visibleChanger(String key, String name, bool show) {
    return Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 241, 245, 246),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 169, 169, 169).withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(1, -1), // changes position of shadow
              ),
            ]),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Show $name"),
            Checkbox(
                value: show,
                onChanged: (val) {
                  boolSetter(key, val);
                })
          ],
        ));
  }

  boolSetter(String key, bool? val) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(key, val!);
  }
}
