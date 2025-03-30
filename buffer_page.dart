
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'resultpage.dart';

class BufferCalculationPage extends StatefulWidget {
  @override
  _BufferCalculationPageState createState() => _BufferCalculationPageState();
}

class _BufferCalculationPageState extends State<BufferCalculationPage> {
  // Controllers for user inputs
  TextEditingController acidController = TextEditingController();
  TextEditingController baseController = TextEditingController();
  TextEditingController temperatureController = TextEditingController();
  TextEditingController pHController = TextEditingController();
  TextEditingController additionalInputController = TextEditingController();

  // Variables for file upload
  String? uploadedFileName;
  String? fileContent; // To store the file's content if needed
  bool fileValid = true;
  String fileErrorMessage = "";

  // Variables to hold the calculated results
  double bufferCapacity = 0.0;
  double accuracy = 0.0;

  // Function to pick and read a text file using file_picker.
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );
    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      setState(() {
        uploadedFileName = file.name;
      });
      // Read file content if available
      if (file.path != null) {
        File f = File(file.path!);
        String content = await f.readAsString();
        setState(() {
          fileContent = content;
        });
        // Parse file content: assume each non-empty line is a reading.
        List<String> lines = content
            .split('\n')
            .where((line) => line.trim().isNotEmpty)
            .toList();
        // We expect exactly 2 readings: first for acid and second for base.
        if (lines.length != 2) {
          setState(() {
            fileValid = false;
            fileErrorMessage =
            "For more than 2 readings, please upload a file with exactly 2 readings (acid and base concentration).";
          });
        } else {
          setState(() {
            fileValid = true;
            fileErrorMessage = "";
            // Optionally, fill the input fields with values from the file.
            acidController.text = lines[0].trim();
            baseController.text = lines[1].trim();
          });
        }
      }
    }
  }

  // This function calculates the buffer capacity and sets an accuracy value.
  // Replace the formula with your actual calculation logic.
  void calculateBufferCapacity() {
    final acid = double.tryParse(acidController.text) ?? 0.0;
    final base = double.tryParse(baseController.text) ?? 0.0;
    // Parse temperature and pH if provided; set defaults if not entered.
    final temperature = double.tryParse(temperatureController.text) ?? 25.0;
    final pH = double.tryParse(pHController.text) ?? 7.0;

    // Example calculation: simply the average of acid and base concentrations.
    bufferCapacity = (acid + base) / 2;

    // Example accuracy; in a real app, this might depend on additional factors.
    accuracy = 97.5;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buffer Capacity Calculator"),
      ),
      body: Stack(
        children: [
          // Background image for the buffer page
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Input form wrapped in a scrollable view
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                color: Colors.white70,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Enter Buffer Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Acid concentration input field
                      TextField(
                        controller: acidController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Acid Concentration (M)",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Base concentration input field
                      TextField(
                        controller: baseController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Base Concentration (M)",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Temperature (optional) input field
                      TextField(
                        controller: temperatureController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Temperature (°C) (Optional)",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      // pH input field
                      TextField(
                        controller: pHController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "pH",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Additional chemical parameter input field (optional)
                      TextField(
                        controller: additionalInputController,
                        decoration: InputDecoration(
                          labelText: "Additional Chemical Parameter (Optional)",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Instruction above file upload button
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "For more than 2 readings, please upload a file with exactly 2 readings (acid and base concentration).",
                          style: TextStyle(fontSize: 14, color: Colors.red),
                        ),
                      ),
                      SizedBox(height: 5),
                      // File upload button: using file_picker for real file uploads
                      ElevatedButton.icon(
                        onPressed: () async {
                          await pickFile();
                        },
                        icon: Icon(Icons.upload_file),
                        label: Text(uploadedFileName == null
                            ? "Upload Buffer Concentration Text File"
                            : "File: $uploadedFileName"),
                      ),
                      // If file is invalid, show error message
                      if (!fileValid)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            fileErrorMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      SizedBox(height: 20),
                      // Button to perform calculation and navigate to the result page
                      ElevatedButton(
                        onPressed: () {
                          // Only proceed if file is valid (or if no file was uploaded)
                          if (fileValid) {
                            calculateBufferCapacity();
                            // Navigate to ResultPage with calculated values
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultPage(
                                  bufferCapacity: bufferCapacity,
                                  accuracy: accuracy,
                                ),
                              ),
                            );
                          }
                        },
                        child: Text("Calculate Buffer Capacity"),
                      ),
                    ],
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
