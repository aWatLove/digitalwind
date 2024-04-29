// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TestPreview extends StatelessWidget {
  final String imagePath;
  final String text;
  final String id;
  final bool proccess;

  const TestPreview(
      {super.key,
      required this.imagePath,
      required this.text,
      required this.id,
      this.proccess = false});

  @override
  Widget build(BuildContext context) {
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
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      style:
                          const TextStyle(fontSize: 20, fontFamily: "Roboto"),
                    ),
                  ),

                  // proccess
                  SizedBox(
                    width: double.infinity,
                    child: proccess
                        ? Container(
                            margin: const EdgeInsets.only(right: 210, top: 30),
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(136, 246, 193, 100),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.check_circle_outline_outlined,
                                  color: Color.fromRGBO(0, 169, 87, 0.612),
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
                            margin: const EdgeInsets.only(right: 180, top: 30),
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(246, 136, 136, 100),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.play_circle_rounded,
                                  color: Color.fromRGBO(255, 62, 62, 100),
                                ),
                                SizedBox(
                                  width: 10,
                                  height: 10,
                                ),
                                Text(
                                  "Не завершен",
                                )
                              ],
                            )),
                  )
                ],
              ),
            )));
  }
}
