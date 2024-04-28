import 'package:flutter/material.dart';

class TestPreview extends StatelessWidget {
  
  final  String imagePath;
  final String text;
  final String id;

  const TestPreview({super.key, required this.imagePath, required this.text, required this.id});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () {
      Navigator.pushNamed(context, '/theme', arguments: {'id':id});
    } ,child:ListTile(

      title: Container(
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
              // width: 200,
              height: 169,
              child: Container(
                // width: 100,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              )
            ),
            
            // const SizedBox(width: 10),

            SizedBox(
              width: 100,
              height: 150,
              child: Text(
                text,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      )
    ));
  }
}
