import 'package:al_quran/Classes/classes.dart';
import 'package:al_quran/Data/data.dart';
import 'package:flutter/material.dart';
import '../SurahPage/surahpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Surah> surahs = [];

  @override
  void initState() {
    for (int i = 0; i < quranData.length; i++) {
      surahs.add(Surah(
        surahNo: quranData[i]["Surah No"],
        name: quranData[i]["Name"],
        ayats: quranData[i]["Ayats"],
      ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // scaffold
        //backgroundColor: const Color(0xFF8FC9C1),
        backgroundColor: const Color.fromARGB(255, 241, 246, 245),
        appBar: AppBar(
          title: const Text(
            "Al Quran",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: "kalpurush",
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          centerTitle: true,
          elevation: 4,
          //backgroundColor: Color.fromARGB(255, 20, 174, 156),
          backgroundColor: const Color.fromARGB(255, 20, 174, 156),
        ),
        body: Align(
            alignment: const Alignment(0, 0),
            child: Column(
              children: [
                ...surahs
                    .map((surah) => Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      SurahPage(surah: surah)));
                            },
                            child: Material(
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 3,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 60,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 241, 246, 245),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(surah.name,
                                          style: const TextStyle(
                                            fontFamily: "kalpurush",
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        surah.surahNo.toString(),
                                        style: const TextStyle(
                                          fontFamily: "lato",
                                        ),
                                      ), // Text("${surah.surahNo}"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList()
              ],
            )),
      ),
    );
  }
}
