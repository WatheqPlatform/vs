// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:watheq/database_connection/connection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:string_capitalize/string_capitalize.dart';

class JobOfferDetailScreen extends StatefulWidget {
  var offerID;

  JobOfferDetailScreen({
    super.key,
    required this.offerID,
  });

  @override
  State<JobOfferDetailScreen> createState() => _StateJobOfferDetailScreen();
}

class _StateJobOfferDetailScreen extends State<JobOfferDetailScreen> {
  List offerDetails = [];

  bool empty = true;

  Future<void> getdata() async {
    var res = await http.post(
      Uri.parse(Connection.jobDetailData),
      body: {"ID": widget.offerID},
    );

    if (res.statusCode == 200) {
      var red = json.decode(res.body);
      red[0]['experiences'] = json.decode(red[0]['experiences']);
      red[0]['qualifications'] = json.decode(red[0]['qualifications']);
      red[0]['skills'] = json.decode(red[0]['skills']);

      setState(() {
        offerDetails.addAll(red);
        empty = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  //checking optional fields value

  Widget startingDateCheck() {
    if (offerDetails[0]["StartingDate"] != null &&
        offerDetails[0]["StartingDate"] != "") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 1),
            child: Text(
              "Starting Date",
              style: TextStyle(
                  fontSize: 19.0,
                  color: Color(0xFF024A8D),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.justify,
            ),
          ),
          Text(
            "${offerDetails[0]["StartingDate"]}",
            style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 37, 42, 74),
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.justify,
          ),
        ],
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }

  Widget workingDaysCheck() {
    if (offerDetails[0]["WorkingDays"] != null &&
        offerDetails[0]["WorkingDays"] != "") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 1),
            child: Text(
              "Working Days",
              style: TextStyle(
                  fontSize: 19.0,
                  color: Color(0xFF024A8D),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.justify,
            ),
          ),
          Text(
            "\u{25AA}  ${offerDetails[0]["WorkingDays"]}"
                .capitalizeEach()
                .replaceAll(", ", "\n\u{25AA}  "),
            style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 37, 42, 74),
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.left,
          )
        ],
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }

  Widget workingHoursCheck() {
    if (offerDetails[0]["WorkingHours"] != null &&
        offerDetails[0]["WorkingHours"] != "") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 1),
            child: Text(
              "Working Hours",
              style: TextStyle(
                fontSize: 19.0,
                color: Color(0xFF024A8D),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          Text(
            "${offerDetails[0]["WorkingHours"]}h Per Day",
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 37, 42, 74),
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }

  Widget renderSkills() {
    if (offerDetails[0]['skills'].length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 1),
            child: Text(
              "Required Skills",
              style: TextStyle(
                  fontSize: 19.0,
                  color: Color(0xFF024A8D),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.justify,
            ),
          ),
          Text(
            "${offerDetails[0]['skills']}"
                .replaceAll("[", "\u{25AA}  ")
                .replaceAll("]", "")
                .replaceAll(", ", "\n\u{25AA}  "),
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 37, 42, 74),
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          )
        ],
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }

  Widget renderQualifications() {
    if (offerDetails[0]['qualifications'].length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 1),
            child: Text(
              "Required Qualifications",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFF024A8D),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.justify,
            ),
          ),
          Text(
            "${offerDetails[0]['qualifications']}"
                .replaceAll("[", "")
                .replaceAll("]", "")
                .replaceAll("{", "\u{25AA} ")
                .replaceAll("}", " Degree\n")
                .replaceAll("Field:", "")
                .replaceAll(", ", "\n")
                .replaceAll("DegreeLevel:", "  "),
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 37, 42, 74),
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }

  Widget renderExpriences() {
    if (offerDetails[0]['experiences'].length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 1),
            child: Text(
              "Required Experiences",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFF024A8D),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.justify,
            ),
          ),
          Text(
            "${offerDetails[0]['experiences']}"
                .replaceAll("[", "")
                .replaceAll("]", "")
                .replaceAll("{", "")
                .replaceAll("}", " Years\n")
                .replaceAll("Description: ", "\u{25AA}  ")
                .replaceAll("ExperienceField", "   Field")
                .replaceAll("YearsOfExperience", "   Years Of Experience")
                .replaceAll(", ", " \n"),
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 37, 42, 74),
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }

  Widget notesCheck() {
    if (offerDetails[0]["AdditionalNotes"] != null &&
        offerDetails[0]["AdditionalNotes"] != "") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 1),
            child: Text(
              "Additional Notes",
              style: TextStyle(
                  fontSize: 19.0,
                  color: Color(0xFF024A8D),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.justify,
            ),
          ),
          Text(
            "${offerDetails[0]["AdditionalNotes"]}"
                .replaceAll(RegExp(r'(?:[\t ]*(?:\r?\n|\r))+'), '\n'),
            style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 37, 42, 74),
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.justify,
          ),
        ],
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: empty
          ? null
          : Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/PagesBackground.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 2,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 40,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 1),
                        child: Text(
                          "${offerDetails[0]["JobTitle"]}".capitalizeEach(),
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: screenWidth * 0.055,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 30,
                          child: IconButton(
                            icon: const Icon(
                              Icons.account_circle_rounded,
                              size: 30,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            "   ${offerDetails[0]["CompanyName"]}"
                                .capitalizeEach()
                                .replaceAll(
                                    RegExp(r'(?:[\t ]*(?:\r?\n|\r))+'), '\n'),
                            style: TextStyle(
                              fontSize: screenWidth * 0.050,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 30,
                    ),
                    height: screenHeight * 0.82,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),

                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.all(5),
                            children: [
                              Text(
                                "Posted on ${offerDetails[0]["Date"]}",
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    color: Color.fromARGB(169, 158, 158, 158),
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 1),
                                child: Text(
                                  "Job Description",
                                  style: TextStyle(
                                      fontSize: 19.0,
                                      color: Color(0xFF024A8D),
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Text(
                                "${offerDetails[0]["JobDescription"]}"
                                    .replaceAll(
                                        RegExp(r'(?:[\t ]*(?:\r?\n|\r))+'),
                                        '\n'),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 37, 42, 74),
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.justify,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 1),
                                child: Text(
                                  "Category".capitalizeEach().replaceAll(
                                      RegExp(r'(?:[\t ]*(?:\r?\n|\r))+'), '\n'),
                                  style: const TextStyle(
                                      fontSize: 19.0,
                                      color: Color(0xFF024A8D),
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Text(
                                "${offerDetails[0]["CategoryName"]}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 37, 42, 74),
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.justify,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 1),
                                child: Text(
                                  "Type",
                                  style: TextStyle(
                                      fontSize: 19.0,
                                      color: Color(0xFF024A8D),
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Text(
                                "${offerDetails[0]["EmploymentType"]}"
                                    .capitalizeEach(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 37, 42, 74),
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.justify,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 1),
                                child: Text(
                                  "Location",
                                  style: TextStyle(
                                      fontSize: 19.0,
                                      color: Color(0xFF024A8D),
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Text(
                                "${offerDetails[0]["JobAddress"]} ${offerDetails[0]["CityName"]}"
                                    .capitalizeEach()
                                    .replaceAll(
                                        RegExp(r'(?:[\t ]*(?:\r?\n|\r))+'),
                                        '\n'),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 37, 42, 74),
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.justify,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 1),
                                child: Text(
                                  "Salary Range",
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Color(0xFF024A8D),
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Text(
                                "${offerDetails[0]["MinSalary"]}SAR - ${offerDetails[0]["MaxSalary"]}SAR",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 37, 42, 74),
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.justify,
                              ),
                              startingDateCheck(),
                              workingDaysCheck(),
                              workingHoursCheck(),
                              renderSkills(),
                              renderExpriences(),
                              renderQualifications(),
                              notesCheck(),
                            ],
                          ),
                        ),
                        //Buttons
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF024A8D),
                                  fixedSize: Size(
                                      screenWidth * 0.8, screenHeight * 0.056),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 5,
                                ),
                                child: const Text(
                                  "Apply",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 17,
                              ),
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    width: 1.5,
                                    color: Color(0xFF024A8D),
                                  ),
                                  fixedSize: Size(
                                      screenWidth * 0.8, screenHeight * 0.052),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: const Text(
                                  "Mock Interview ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF024A8D),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
