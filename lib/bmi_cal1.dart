import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  double bmi = 0.0;
  String conclusion = '';

  //define for select male and female icon
  bool isMaleSelected = false;
  bool isFemaleSelected = false;

  //change the color of text as pe BMI
  TextStyle underweightStyle = const TextStyle(color: Colors.blue);
  TextStyle normalWeightStyle = const TextStyle(color: Colors.green);
  TextStyle overweightStyle = const TextStyle(color: Colors.orange);
  TextStyle obeseStyle = const TextStyle(color: Colors.red);

  //function for get Textstyle which return a color
  TextStyle getTextStyleForBMI(double bmi) {
    if (bmi < 18.5) {
      return underweightStyle;
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return normalWeightStyle;
    } else if (bmi >= 25.0 && bmi < 29.9) {
      return overweightStyle;
    } else {
      return obeseStyle;
    }
  }

  //Function for calculate BMI
  void calculateBMI() {
    double height = double.tryParse(heightController.text) ?? 0.0;
    double weight = double.tryParse(weightController.text) ?? 0.0;
    double bmiResult = weight / ((height / 100) * (height / 100));

    setState(() {
      bmi = bmiResult;
      if (bmi < 18.5) {
        conclusion = 'Underweight';
      } else if (bmi >= 18.5 && bmi < 24.9) {
        conclusion = 'Normal Weight';
      } else if (bmi >= 25.0 && bmi < 29.9) {
        conclusion = 'Overweight';
      } else {
        conclusion = 'Obese';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'BMI Calculator',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blueAccent.withOpacity(0.1),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Handle settings action here
              },
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 0, 11, 74),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // GestureDetector recognize and respond to various gestures made by the user on the screen
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isMaleSelected = true;
                        isFemaleSelected = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: !isMaleSelected
                            ? Colors.blueAccent.withOpacity(0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child:
                          const Icon(Icons.male, size: 60, color: Colors.blue),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isMaleSelected = false;
                        isFemaleSelected = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: !isFemaleSelected
                            ? Colors.blueAccent.withOpacity(0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(Icons.female,
                          size: 60, color: Colors.pink),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: 'Your height in cm',
                  labelStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.blueAccent.withOpacity(0.1),
                  // alignLabelWithHint: true, // Center-align the label
                ),
                textAlign: TextAlign.center,

                style: const TextStyle(
                    color: Colors.white), // Set text color to white
              ),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                decoration: InputDecoration(
                  labelText: 'Your weight in kg',
                  labelStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.blueAccent.withOpacity(0.1),
                ),
                style: const TextStyle(
                    color: Colors.white), // Set text color to white
                textAlign: TextAlign.center,
              ),
              const Text(
                'Your BMI',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              Text(
                bmi.toStringAsFixed(1),
                style: getTextStyleForBMI(bmi)
                    .copyWith(fontSize: 24), // add font size in style
              ),
              Text(
                conclusion,
                style: getTextStyleForBMI(bmi).copyWith(fontSize: 24),
              ),
              ElevatedButton(
                onPressed: calculateBMI,
                child: const Text('Calculate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
