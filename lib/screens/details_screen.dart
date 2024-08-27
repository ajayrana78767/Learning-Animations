import 'package:flutter/material.dart';
import 'package:learning_animations/models/trip.dart';
import 'package:learning_animations/shared/heart.dart';
// import 'package:lipsum/lipsum.dart' as lipsum;
// import 'package:lorem_ipsum/lorem_ipsum.dart' as lipsum;
// import 'package:lipsum/lipsum.dart' as lipsum;
import 'package:lorem_ipsum/lorem_ipsum.dart';
class DetailsScreen extends StatelessWidget {

  final Trip trip;
  const DetailsScreen({super.key,  @required required this.trip });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
            child: Image.asset(
              trip.img,
              height: 360,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            )
          ),
          const SizedBox(height: 30),
          ListTile(
            title: Text(
              trip.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.grey[800]
              )
            ),
            subtitle: Text(
              '${trip.nights} night stay for only \$${trip.price}',
              style: const TextStyle(letterSpacing: 1)
            ),
            trailing: const Heart()
          ),
           Padding(
            padding: const EdgeInsets.all(18),
            child: Text(
             loremIpsum(paragraphs: 1,)
            //  lipsum.createText(numParagraphs: 1, numSentences: 3),
            //   style: TextStyle(
            //     color: Colors.grey[600],
            //     height: 1.4
            //   )
            )
          ),
        ],
      )
    );
  }
}