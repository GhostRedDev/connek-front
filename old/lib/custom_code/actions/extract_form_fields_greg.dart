// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
import 'dart:convert';

// Define a function to parse the JSON and return the formFields list
List<String> extractFormFieldsGreg(String jsonString) {
  // Decode the JSON string
  Map<String, dynamic> jsonMap = jsonDecode(jsonString);

  // Extract the formFields list
  List<String> formFields = List<String>.from(jsonMap['formFields']);

  return formFields;
}
