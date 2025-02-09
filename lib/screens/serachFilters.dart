import 'package:flutter/material.dart';
import 'package:needed_app/customWidgets/blueButton.dart';
import 'package:needed_app/customWidgets/textField.dart';
import 'package:needed_app/variables/colors.dart';

class SearchFilters extends StatefulWidget {
  const SearchFilters({super.key});

  @override
  State<SearchFilters> createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchFilters> {
  final _locationController = TextEditingController();
  final _workerController = TextEditingController();
  String selectedStatus = "Available";
  String selectedExperience = "Not Necessary";
  String selectedRating = "5.0";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: white),
          title: Text(
            'Search Filters',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: white, fontSize: 22),
          ),
          centerTitle: true,
          backgroundColor: blueColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: buildTextField("Location", _locationController,
                        Icons.location_city, null),
                  ),
                  const SizedBox(width: 10),
                  CustomButton(
                    height: 30,
                    width: 100,
                    color: blueColor,
                    text: "Choose Location",
                    opacity: 0.0,
                    fontSize: 9,
                    onTap: () {},
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: buildTextField(
                        "Worker", _workerController, Icons.person, null),
                  ),
                  const SizedBox(width: 10),
                  CustomButton(
                    height: 30,
                    width: 100,
                    color: blueColor,
                    text: "Choose Worker",
                    opacity: 0.0,
                    fontSize: 9,
                    onTap: () {},
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Status",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildRadioButton(
                  title: "Available",
                  value: "Available",
                  groupValue: selectedStatus,
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value!;
                    });
                  }),
              buildRadioButton(
                  title: "Unavailable",
                  value: "Unavailable",
                  groupValue: selectedStatus,
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value!;
                    });
                  }),
              const Text(
                "Experience",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildRadioButton(
                  title: "Not Necessary",
                  value: "Not Necessary",
                  groupValue: selectedExperience,
                  onChanged: (value) {
                    setState(() {
                      selectedExperience = value!;
                    });
                  }),
              buildRadioButton(
                  title: "1 Year",
                  value: "1 Year",
                  groupValue: selectedExperience,
                  onChanged: (value) {
                    setState(() {
                      selectedExperience = value!;
                    });
                  }),
              buildRadioButton(
                  title: "Less than 3 years",
                  value: "Less than 3 years",
                  groupValue: selectedExperience,
                  onChanged: (value) {
                    setState(() {
                      selectedExperience = value!;
                    });
                  }),
              const Text(
                "Rating",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildRadioButton(
                      title: "5.0",
                      value: "5.0",
                      groupValue: selectedRating,
                      onChanged: (value) {
                        setState(() {
                          selectedRating = value!;
                        });
                      }),
                  buildRadioButton(
                      title: "4.0",
                      value: "4.0",
                      groupValue: selectedRating,
                      onChanged: (value) {
                        setState(() {
                          selectedRating = value!;
                        });
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildRadioButton(
                      title: "3.0",
                      value: "3.0",
                      groupValue: selectedRating,
                      onChanged: (value) {
                        setState(() {
                          selectedRating = value!;
                        });
                      }),
                  buildRadioButton(
                      title: "2.0",
                      value: "2.0",
                      groupValue: selectedRating,
                      onChanged: (value) {
                        setState(() {
                          selectedRating = value!;
                        });
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildRadioButton(
                      title: "1.0",
                      value: "1.0",
                      groupValue: selectedRating,
                      onChanged: (value) {
                        setState(() {
                          selectedRating = value!;
                        });
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRadioButton({
    required String title,
    required String value,
    required String groupValue,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.1),
      child: Row(
        children: [
          Radio<String>(
            activeColor: blueColor,
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
