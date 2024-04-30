// import 'dart:ffi';

// ignore_for_file: must_be_immutable

import 'package:dw/screens/Test/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../model/consts/consts.dart';

class ThemePreviewProvider with ChangeNotifier {
  ProcessStatus? _isFinished;
  final int id;
  ThemePreviewProvider({required this.id});
  ProcessStatus? get isFinished => _isFinished;
  
  Future<void> loadFinished() async {
    try {
      return await SharedPreferences.getInstance().then((value) {
        final checked = value.getBool("${Consts.finishThemeKey}$id");
        checked == true
            ? _isFinished = ProcessStatus.finished
            : checked == false
                ? _isFinished = ProcessStatus.continued
                : _isFinished = ProcessStatus.non;
      });
    } catch (e) {
      _isFinished = ProcessStatus.non;
    } finally {
      notifyListeners();
    }
  }
}

class TestPreview extends StatelessWidget {
  final String imagePath;
  final String text;
  final int id;
  // late bool? proccess;

  const TestPreview(
      {super.key,
      required this.imagePath,
      required this.text,
      required this.id});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemePreviewProvider(id: id),
        child: Consumer<ThemePreviewProvider>(builder: (context, provider, _) {
          provider.loadFinished();
          return InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/theme', arguments: {'id': id});
              },
              child: ListTile(
                  minLeadingWidth: 339,
                  title: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 400,
                    ),
                    width: 200,
                    height: 332,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 2,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                            // picture
                            // width: 200,
                            height: 169,
                            child: Container(
                              // width: 100,
                              // height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: AssetImage(imagePath),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            )),

                        // title

                        Container(
                          margin: const EdgeInsets.all(13.0),
                          width: double.infinity,
                          // height: ,
                          child: Text(
                            text,
                            style: const TextStyle(
                                fontSize: 20, fontFamily: "Roboto"),
                          ),
                        ),

                        // proccess
                        Visibility(
                            visible: true,
                            child: SizedBox(
                              width: double.infinity,
                              child: (provider.isFinished ==
                                      ProcessStatus.finished)
                                  ? Container(
                                      margin: const EdgeInsets.only(
                                        right: 210,
                                      ),
                                      decoration: const BoxDecoration(
                                        color:
                                            Color.fromRGBO(136, 246, 193, 0.75),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: const Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle_outline_outlined,
                                            color:
                                                Color.fromRGBO(0, 169, 87, 1),
                                          ),
                                          SizedBox(
                                            width: 10,
                                            height: 10,
                                          ),
                                          Text(
                                            "Завершен",
                                          )
                                        ],
                                      ))
                                  : Container(
                                      margin: const EdgeInsets.only(
                                        right: 180,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(248, 222, 199, 1),
                                        //color: Color.fromRGBO(246, 136, 136, 0.5),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.play_circle_outline_outlined,
                                            color:
                                                Color.fromRGBO(255, 154, 4, 1),
                                            //color: Color.fromRGBO(255, 62, 62, 1),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                            height: 10,
                                          ),
                                          Text(provider.isFinished ==
                                                  ProcessStatus.non
                                              ? "Приступить"
                                              : provider.isFinished ==
                                                      ProcessStatus.continued
                                                  ? 'Продолжить'
                                                  : '')
                                        ],
                                      )),
                            ))
                      ],
                    ),
                  )));
        }));
  }
}

enum ProcessStatus { finished, continued, non }
