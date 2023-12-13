import 'package:dressmatching/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const HomeScreen(),
    );
  }
}
/*
class Sample extends StatefulWidget {
  const Sample({Key? key}) : super(key: key);

  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  Color primaryColor = Colors.grey; // Default color

  @override
  void initState() {
    super.initState();
    _analyzeImageColors();
  }

  Future<void> _analyzeImageColors() async {
    PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
      NetworkImage(
          'https://example.com/your_image.jpg'), // Replace with your image URL
    );

    setState(() {
      primaryColor = palette.dominantColor!.color;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color complementaryColor = primaryColor.complementary();
    Color triadicColor1 = primaryColor.triadic1();
    Color triadicColor2 = primaryColor.triadic2();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Outfit Color Matcher'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                color: primaryColor,
                child: Center(child: Text('Primary Color')),
              ),
              Container(
                width: 100,
                height: 100,
                color: complementaryColor,
                child: Center(child: Text('Complementary Color')),
              ),
              Container(
                width: 100,
                height: 100,
                color: triadicColor1,
                child: Center(child: Text('Triadic Color 1')),
              ),
              Container(
                width: 100,
                height: 100,
                color: triadicColor2,
                child: Center(child: Text('Triadic Color 2')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
