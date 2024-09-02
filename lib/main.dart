// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:learning_animations/screens/sandbox.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.dancingScriptTextTheme(
          // Apply Pacifico font to the whole app
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  PizzaAppScreen()
      //  const Sandbox(
      //   initialContainerHeight: 100,
      //   initialContainerWidth: 100,
      // ), // Initial small size),
    );
  }
}



class PizzaAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Pizza'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Top Picks'),
            SizedBox(height: 10),
            _buildHorizontalParallaxList(topPicksData),
            SizedBox(height: 20),
            _buildSectionTitle('Special Offers'),
            SizedBox(height: 10),
            _buildHorizontalParallaxList(specialOffersData),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildHorizontalParallaxList(List<CardData> data) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _buildParallaxCard(data[index], index, context);
        },
      ),
    );
  }

Widget _buildParallaxCard(
      CardData cardData, int index, BuildContext context) {
    return Container(
      width: 250,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background image with stronger parallax effect
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Increase the parallax shift by using a larger multiplier for index
                double parallaxOffset =
                    index * 0.5; // Adjust this value for more shift
                return Image.network(
                  cardData.imageUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment(-1 + parallaxOffset, 0),
                );
              },
            ),
          ),
          // Foreground content
          Center(
            child: Container(
              width: 125,
              color: Colors.black54,
              child: Center(
                child: Text(
                  cardData.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}

// Pizza-related data with the correct image URL
class CardData {
  final String imageUrl;
  final String title;

  CardData({required this.imageUrl, required this.title});
}

List<CardData> topPicksData = [
  CardData(
    imageUrl: 'https://www.engelvoelkers.com/wp-content/uploads/2014/07/pizza-stock.jpg',
    title: 'Pepperoni Pizza',
  ),
  CardData(
    imageUrl: 'https://www.engelvoelkers.com/wp-content/uploads/2014/07/pizza-stock.jpg',
    title: 'Margherita Pizza',
  ),
  CardData(
    imageUrl: 'https://www.engelvoelkers.com/wp-content/uploads/2014/07/pizza-stock.jpg',
    title: 'Veggie Pizza',
  ),
];

List<CardData> specialOffersData = [
  CardData(
    imageUrl: 'https://www.engelvoelkers.com/wp-content/uploads/2014/07/pizza-stock.jpg',
    title: 'BBQ Chicken Pizza',
  ),
  CardData(
    imageUrl: 'https://www.engelvoelkers.com/wp-content/uploads/2014/07/pizza-stock.jpg',
    title: 'Cheese Lovers Pizza',
  ),
  CardData(
    imageUrl: 'https://www.engelvoelkers.com/wp-content/uploads/2014/07/pizza-stock.jpg',
    title: 'Spicy Pizza',
  ),
];
