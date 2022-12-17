import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BAJUKITA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Tim Kami',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          StaggeredGrid.count(
            crossAxisCount: 2,
            children: [
              _buildAvatarUser('M Ihsan Permana', "ihsan.jpeg"),
              _buildAvatarUser('M Diki Ramlan', "diki.jpg"),
              _buildAvatarUser('Nurul Fauziah', "nurul.jpg"),
              _buildAvatarUser('M Tesyar Razbani', "tesyar.jpg"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarUser(String name, String image) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/images/$image",
              fit: BoxFit.cover,
            ),
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
