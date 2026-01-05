// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<EmployeesStruct>> employeesToDataType(
    List<EmployeesRow> employeesQuery) async {
  // Convert the List of Supabase rows to a list of EmployeesStruct.

  List<EmployeesStruct> employeesDataList = [];

  for (EmployeesRow employee in employeesQuery) {
    EmployeesStruct employeeData = EmployeesStruct(
        id: employee.id,
        name: employee.name,
        description: employee.description,
        price: employee.price,
        currency: employee.currency,
        purpose: employee.purpose,
        skills: employee.skills,
        frequency: employee.frequency,
        stripePriceId: employee.stripePriceId);

    // Add the newly created EmployeesStruct to the list
    employeesDataList.add(employeeData);
  }

  return employeesDataList;
}
