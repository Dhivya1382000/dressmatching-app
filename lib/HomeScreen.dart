import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:tinycolor2/tinycolor2.dart';
import 'package:tuple/tuple.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? eventPhotoFile;

  Color predominantColor = Colors.white;
  List<Color> matchingColors = [];
  List<String> items = ['Mens-Shirt', 'Ladies-Top', 'T-shirt', 'Pant'];
  String selectedItem = 'Mens-Shirt';
  bool isloading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Dress Matching',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black12, width: 1),
                  ),
                  child: DropdownButton<String>(
                    underline: SizedBox(),
                    icon: Image.asset(
                      "assets/dropdown.png",
                      width: 20,
                      height: 20,
                    ),
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    isDense: true,
                    isExpanded: true,
                    value: selectedItem,
                    items: items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedItem = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  child: Text('Select your dress',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                      textAlign: TextAlign.center),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Pick an image"),
                          actions: [
                            TextButton(
                              child: Text("From Gallery"),
                              onPressed: () {
                                _getImageFromGallery();
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text("From Camera"),
                              onPressed: () {
                                _getImageFromCamera();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.2,
                      margin: EdgeInsets.fromLTRB(30, 10, 30, 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          image: eventPhotoFile != null
                              ? DecorationImage(
                                  image: FileImage(
                                    eventPhotoFile!,
                                  ),
                                  fit: BoxFit.cover)
                              : null,
                          border: Border.all(color: Colors.black12)),
                      child: Center(
                          child: Visibility(
                        visible: eventPhotoFile != null ? false : true,
                        child: Icon(
                          Icons.add,
                          color: Colors.black45,
                          size: 50,
                        ),
                      )),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: isloading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            2, // Change this to the number of columns you want
                        crossAxisSpacing:
                            8.0, // Adjust the spacing between columns
                        mainAxisSpacing: 8.0, // Adjust the spacing between rows
                      ),
                      itemCount: matchingColors.length,
                      itemBuilder: (context, index) {
                        isloading = false;
                        return selectedItem == "Mens-Shirt"
                            ? Container(
                                margin: EdgeInsets.all(5),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black12, width: 1)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image(
                                    image: AssetImage('assets/newpantimg.png'),
                                    // Load an image from your assets
                                    fit: BoxFit.fill,
                                    width: 40,
                                    height: 40,
                                    color: matchingColors[index],
                                    // Adjust the fit as needed (e.g., BoxFit.cover, BoxFit.fill, etc.)
                                  ),
                                ),
                              )
                            : selectedItem == "Ladies-Top"
                                ? Container(
                                    margin: EdgeInsets.all(5),
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.black12, width: 1)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image(
                                        image: AssetImage(
                                            'assets/leggingsimg.png'),
                                        // Load an image from your assets
                                        fit: BoxFit.fill,
                                        width: 40,
                                        height: 40,
                                        color: matchingColors[index],
                                        // Adjust the fit as needed (e.g., BoxFit.cover, BoxFit.fill, etc.)
                                      ),
                                    ),
                                  )
                                : selectedItem == "T-shirt"
                                    ? Container(
                                        width: 40,
                                        height: 40,
                                        margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black12,
                                                width: 1)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image(
                                            image: AssetImage(
                                                'assets/shortsimg.png'),
                                            // Load an image from your assets
                                            fit: BoxFit.fill,
                                            width: 40,
                                            height: 40,
                                            color: matchingColors[index],
                                            // Adjust the fit as needed (e.g., BoxFit.cover, BoxFit.fill, etc.)
                                          ),
                                        ),
                                      )
                                    : selectedItem == "Pant"
                                        ? Container(
                                            width: 40,
                                            height: 40,
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.black12,
                                                    width: 1)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/imageshirt.png'),
                                                // Load an image from your assets
                                                fit: BoxFit.fill,
                                                width: 40,
                                                height: 40,
                                                color: matchingColors[index],
                                                // Adjust the fit as needed (e.g., BoxFit.cover, BoxFit.fill, etc.)
                                              ),
                                            ),
                                          )
                                        : Container(
                                            width: 40,
                                            height: 40,
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.black12,
                                                    width: 1)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/newpantimg.png'),
                                                // Load an image from your assets
                                                fit: BoxFit.fill,
                                                width: 40,
                                                height: 40,
                                                color: matchingColors[index],
                                                // Adjust the fit as needed (e.g., BoxFit.cover, BoxFit.fill, etc.)
                                              ),
                                            ),
                                          );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImageFromGallery() async {
    matchingColors.clear();
    eventPhotoFile = null;
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    print('pickedFilegal ${pickedFile}');
    setState(() {
      isloading = true;
    });
    if (pickedFile != null) {
      eventPhotoFile = File(pickedFile.path);
    } else {
      setState(() {
        isloading = false;
      });
    }
    final result = await detectPredominantColor(eventPhotoFile!);
    setState(() {
      predominantColor = result.item1;
      isloading = false;
      matchingColors.addAll(result.item2);
    });
  }

  Future<void> _getImageFromCamera() async {
    matchingColors.clear();
    eventPhotoFile = null;
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    print('pickedFile $pickedFile');
    setState(() {
      isloading = true;
    });
    if (pickedFile != null) {
      eventPhotoFile = File(pickedFile.path);
    } else {
      setState(() {
        isloading = false;
      });
    }
    final result = await detectPredominantColor(eventPhotoFile!);

    print('result of images ${result.item2}');
    setState(() {
      predominantColor = result.item1;
      isloading = false;
      matchingColors.addAll(result.item2);
    });
  }

  Future<Tuple2<Color, List<Color>>> detectPredominantColor(
      File imageFile) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      FileImage(imageFile),
      maximumColorCount: 20, // Adjust as needed
    );

    final dominantColor = paletteGenerator.dominantColor!.color;

    // Suggest matching colors based on the dominant color
    final matchingColors = generateMatchingColors(dominantColor);

    return Tuple2<Color, List<Color>>(dominantColor, matchingColors);
  }

  List<Color> generateMatchingColors(Color predominantColor) {
    // Generate a complementary color using 'tinycolor'
    //final complementaryColor = TinyColor(predominantColor).complement().color;
    /* final triadicColors = calculateTriadicColors(predominantColor);

    final matchingColors = [complementaryColor, ...triadicColors];*/
    final List<Color> matchingColors = [];

    final HSLColor hslColor = HSLColor.fromColor(predominantColor);
    final double hue = hslColor.hue;

    // Calculate two additional colors by evenly spacing them 120 degrees apart
    for (int i = 0; i < 4; i++) {
      final double modifiedHue = (hue + (i * 36)) % 360;
      final Color newColor = HSLColor.fromAHSL(
              1, modifiedHue, hslColor.saturation, hslColor.lightness)
          .toColor();
      matchingColors.add(newColor);
    }

    return matchingColors;
    // return [complementaryColor];
  }

/*  List<Color> calculateTriadicColors(Color color) {


    final Color triadicColor1 = HSLColor.fromAHSL(
            1, (hue + 120) % 360, hslColor.saturation, hslColor.lightness)
        .toColor();
    final Color triadicColor2 = HSLColor.fromAHSL(
            1, (hue + 240) % 360, hslColor.saturation, hslColor.lightness)
        .toColor();

    return [triadicColor1, triadicColor2];
  }*/
}
