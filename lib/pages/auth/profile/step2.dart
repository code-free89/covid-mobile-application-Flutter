import 'package:covid/components/button.dart';
import 'package:covid/components/dropdown.dart';
import 'package:covid/components/textbox.dart';
import 'package:covid/components/textedit.dart';
import 'package:covid/utils/functions.dart';
import 'package:flutter/material.dart';

class SetupProfile2 extends StatefulWidget {
  const SetupProfile2({Key? key}) : super(key: key);

  @override
  _SetupProfile2State createState() => _SetupProfile2State();
}

class _SetupProfile2State extends State<SetupProfile2> {
  TextEditingController addressController = new TextEditingController();
  TextEditingController postCodeController = new TextEditingController();
  var userData;
  @override
  void initState() {
    setState(() {
      userData = getUserData(context);
      userData["gender"] = "male";
      userData["ethnity"] = "Malay";
      userData["state"] = "Johor";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onChangeGender(String gender) {
      setState(() {
        userData["gender"] = gender;
      });
    }

    void onChangeEthnity(String ethnity) {
      setState(() {
        userData["ethnity"] = ethnity;
      });
    }

    void onChangeState(String state) {
      setState(() {
        userData["state"] = state;
      });
    }

    void onSubmit() {
      if (addressController.value.text == "" ||
          postCodeController.value.text == "") {
        showToast("Please input all data");
      } else {
        setState(() {
          userData["address"] = addressController.value.text;
          userData["postcode"] = postCodeController.value.text;
        });
        print(userData);
        setUserData(context, userData);
        Navigator.pushNamed(context, "/setupProfile3");
      }
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          child: Center(
            child: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.blue,
              size: 40,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 20,
          padding: EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBox(
                    value: "Step 2 of 3",
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    padding: 10,
                  ),
                  TextBox(
                    value: "Update your personal details",
                    fontSize: 14,
                    fontColor: Colors.black45,
                    padding: 10,
                  ),
                  TextBox(
                    value: "All fields are mandatory.",
                    fontSize: 14,
                    fontColor: Colors.black45,
                    fontStyle: FontStyle.italic,
                    padding: 10,
                  ),
                  DropDown(
                    items: ["Male", "Female"],
                    padding: 20,
                    onChange: onChangeGender,
                  ),
                  DropDown(
                    items: [
                      "Malay",
                      "Chinese",
                      "Indian",
                      "Bumiputera Sabah",
                      "Bumiputera Sarawak",
                      "Orang Asli",
                      "Others"
                    ],
                    onChange: onChangeEthnity,
                  ),
                  TextEdit(
                    hintText: "Current Address",
                    controller: addressController,
                  ),
                  TextEdit(
                    hintText: "Postcode",
                    controller: postCodeController,
                    type: "number",
                    padding: 20,
                  ),
                  DropDown(
                    items: [
                      "Johor",
                      "Kedah",
                      "Kelantan",
                      "Melaka",
                      "Negeri Sembilan",
                      "Pahang",
                      "Perak",
                      "Perlis",
                      "Pulau Pinang",
                      "Sabah",
                      "Sarawak",
                      "Selangor",
                      "Terengganu",
                      "WP Kuala Lumpur",
                      "WP Labuan",
                      "WP Putrajaya",
                    ],
                    padding: 20,
                    onChange: onChangeState,
                  ),
                  Button(
                    onPressed: () {
                      onSubmit();
                    },
                    label: "Next",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
