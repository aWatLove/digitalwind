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
          color: Colors.grey[200],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
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
