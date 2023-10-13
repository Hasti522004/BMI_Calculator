import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  TextEditingController feetController = TextEditingController();
  TextEditingController inchesController = TextEditingController();

  TextEditingController cheight = TextEditingController();
  TextEditingController cweight = TextEditingController();
  TextStyle underweightStyle = const TextStyle(color: Colors.blue);
  TextStyle normalWeightStyle = const TextStyle(color: Colors.green);
  TextStyle overweightStyle = const TextStyle(color: Colors.orange);
  TextStyle obeseStyle = const TextStyle(color: Colors.red);

  String height = '';
  String weight = '';
  String resultText = '';
  double bmi = 0;
  String result = '';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BMI Calculator'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
          child: Column(
            children: [
              Title(
                color: Colors.red,
                child: const Text(
                  'Calculate Body Mass Index(BMI)',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.amber),
                ),
              ),
              TextField(
                controller: cheight,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Enter Height in cm'),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: cweight,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Enter Weight in kg'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  double parsedHeight = double.tryParse(cheight.text) ?? 0;
                  double parsedWeight = double.tryParse(cweight.text) ?? 0;
                  String result = calculateBMI(parsedHeight, parsedWeight);
                  bmi = parsedWeight /
                      ((parsedHeight / 100) * (parsedHeight / 100));
                  setState(() {
                    height = cheight.text;
                    weight = cheight.text;
                    resultText = result;
                  });
                },
                child: const Text('Calculate BMI'),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                resultText,
                style: getTextStyleForBMI(bmi),
              ),
              const Divider(
                color: Colors.blueGrey, // Color of the line
                height: 100, // Thickness of the line
                thickness: 2, // Height of the line
              ),
              Title(
                color: Colors.red,
                child: const Text(
                  'Convert height from feet,Inches to cm',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.amber),
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: feetController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(), hintText: 'Feet'),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Flexible(
                    child: TextField(
                      controller: inchesController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(), hintText: 'Inches'),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  double feet = double.tryParse(feetController.text) ?? 0.0;
                  double inches = double.tryParse(inchesController.text) ?? 0.0;

                  double totalInches = (feet * 12) + inches;
                  double cm = totalInches * 2.54;

                  setState(() {
                    result = 'Height in cm: ${cm.toStringAsFixed(2)}';
                  });
                },
                child: const Text('Convert'),
              ),
              const SizedBox(height: 20.0),
              Text(
                result,
              ),
            ],
          ),
        ));
  }
}

String calculateBMI(double height, double weight) {
  double bmi = weight / ((height / 100) * (height / 100));
  String conclusion;

  if (bmi < 18.5) {
    conclusion = 'Underweight';
  } else if (bmi >= 18.5 && bmi < 24.9) {
    conclusion = 'Normal Weight';
  } else if (bmi >= 25.0 && bmi < 29.9) {
    conclusion = 'Overweight';
  } else {
    conclusion = 'Obese';
  }

  return 'BMI : ${bmi.toStringAsFixed(2)}\nConclusion : $conclusion';
}
