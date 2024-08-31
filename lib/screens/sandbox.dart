// import 'dart:async';
// import 'package:flutter/material.dart';

// class Sandbox extends StatefulWidget {
//   final double initialContainerHeight; // Add an initial height property
//    final double initialContainerWeight; // Add an initial height property
//   const Sandbox({super.key, required this.initialContainerHeight, required this.initialContainerWeight});

//   @override
//   State<Sandbox> createState() => _SandboxState();
// }

// class _SandboxState extends State<Sandbox> {
//   late double
//       containerHeight; // Track the container height with late initialization
//        late double
//       containerWeight; // Track the container weight with late initialization

//   @override
//   void initState() {
//     super.initState();
//     containerHeight =
//         widget.initialContainerHeight; // Initialize with the provided height
//     Timer.periodic(const Duration(seconds: 4), (value) {
//       setState(() {
//         // Set to a large finite height instead of double.infinity
//         containerHeight = double.infinity;
//         containerWeight = double.infinity;
//       });
//     });
//   }

//   bool isTapped = false;

//   @override
//   Widget build(BuildContext context) {
//     var margin = isTapped ? 10.0 : 100.0;

//     return Scaffold(
//       body: Column(
//         children: [
//           //   const Spacer(),
//           AnimatedContainer(
//             margin: EdgeInsets.all(margin),
//             height: containerHeight,
//             width: containerWeight,
//             color: Colors.amber,
//             duration: const Duration(milliseconds: 500),
//           ),
//           // const Spacer(),
//           // ElevatedButton(
//           //   onPressed: () {
//           //     setState(() {
//           //       isTapped = !isTapped;
//           //     });
//           //     if (kDebugMode) {
//           //       print(isTapped);
//           //     }
//           //   },
//           //   child: const Text('ON TAP'),
//           // ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';

class Sandbox extends StatefulWidget {
  final double initialContainerWidth; // Unified initial size property
  final double initialContainerHeight; // Unified initial size property

  const Sandbox({
    super.key,
    required this.initialContainerWidth,
    required this.initialContainerHeight,
  });

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  late double
      containerWidth; // Track the container width with late initialization
  late double
      containerHeight; // Track the container height with late initialization
  bool timerCompleted = false;
  double textOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    containerWidth =
        widget.initialContainerWidth; // Initialize with the provided size
    containerHeight = widget.initialContainerHeight;

    // Start the animation after a delay
    Timer(const Duration(seconds: 1), () {
      setState(() {
        containerWidth = MediaQuery.of(context)
            .size
            .width; // Expand to fill the width of the screen
        containerHeight = MediaQuery.of(context)
            .size
            .height; // Expand to fill the height of the screen
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              height: containerHeight,
              width: containerWidth,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
              ),
              duration: const Duration(seconds: 2), // Smooth animation duration
              curve: Curves.decelerate, // Smooth animation curve
              onEnd: () {
                setState(() {
                  timerCompleted = true;
                  // Start fading in the text after the container animation ends
                  Timer(const Duration(milliseconds: 500), () {
                    setState(() {
                      textOpacity = 1.0;
                    });
                  });
                });
              },
            ),
            // AnimatedOpacity for fading in text
            AnimatedOpacity(
              opacity: textOpacity,
              duration: const Duration(seconds: 3),
              child: timerCompleted
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Center the content vertically
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [
                                Colors.black,
                                Color.fromRGBO(251, 182, 26, 1),
                              ],
                              tileMode: TileMode.clamp,
                            ).createShader(bounds),
                            child: const Text(
                              'WELCOME TO OUR APP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors
                                    .white, // This color is used as a fallback
                              ),
                            ),
                          ),

                          const SizedBox(
                              height: 16), // Adjust the height as needed
                          Image.network(
                            'https://th.bing.com/th/id/R.39df44bdbedef720881dfdace9297b91?rik=kdcdDXSWEFgZkw&riu=http%3a%2f%2fwww.clipartbest.com%2fcliparts%2fdi6%2fxe6%2fdi6xe6z9T.gif&ehk=0LkbeAihmqhQS1ZkmDRxFyGQpdYmuo7hL%2byAcp2y9Pk%3d&risl=&pid=ImgRaw&r=0',
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) {
                                return child;
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                  child: Text('Failed to load image'));
                            },
                          )
                        ],
                      ),
                    )
                  : const SizedBox
                      .shrink(), // Hide text until animation completes
            ),
          ],
        ),
      ),
    );
  }
}
