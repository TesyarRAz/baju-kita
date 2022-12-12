import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({Key? key}) : super(key: key);

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 150,
              color: Colors.black,
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
