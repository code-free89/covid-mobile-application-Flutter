import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid/components/button.dart';
import 'package:covid/components/dropdown.dart';
import 'package:covid/components/textbox.dart';
import 'package:covid/components/textedit.dart';
import 'package:covid/models/dependent.dart';
import 'package:covid/providers/dataProvider.dart';
import 'package:covid/utils/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDependent extends StatefulWidget {
  const AddDependent({Key? key}) : super(key: key);

  @override
  _AddDependentState createState() => _AddDependentState();
}

class _AddDependentState extends State<AddDependent> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController passportController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController postCodeController = new TextEditingController();
  Map<String, dynamic> userData = {};
  bool isLoading = false;
  DependentData dependentData = new DependentData();

  @override
  void initState() {
    userData = getUserData(context);
    dependentData.relation = "Spouse";
    dependentData.gender = "Male";
    dependentData.state = "Johor";
    formatDependent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        leading: InkWell(
          child: Icon(
            Icons.keyboard_arrow_left,
            size: 35,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        shadowColor: Colors.transparent,
        title: Text("Add dependents"),
        actions: <Widget>[
          new Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextBox(
                        value: "Enter your dependent's details",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        padding: 10,
                      ),
                      TextBox(
                        value: "All field are mandatory.",
                        fontStyle: FontStyle.italic,
                        fontSize: 13,
                        fontColor: Colors.black87,
                        padding: 30,
                      ),
                      TextEdit(
                        hintText: "Full name",
                        labelText: "Full name",
                        controller: nameController,
                        isUnderline: true,
                      ),
                      DropDown(
                        items: [
                          "Spouse",
                          "Child",
                          "Siblings",
                          "Parents / Parents-in-law",
                          "Grandparents",
                          "Guardian",
                          "Others"
                        ],
                        padding: 20,
                        hintText: "Relation",
                        isUnderline: true,
                        onChange: onChangeRelation,
                      ),
                      TextEdit(
                        hintText: "NRIC / Passport No",
                        controller: passportController,
                        isUnderline: true,
                      ),
                      TextEdit(
                        hintText: "Age",
                        controller: ageController,
                        isUnderline: true,
                      ),
                      DropDown(
                        items: [
                          "Male",
                          "Female",
                        ],
                        padding: 20,
                        hintText: "Gender",
                        isUnderline: true,
                        onChange: onChangeGender,
                      ),
                      TextEdit(
                        hintText: "Current Address",
                        controller: addressController,
                        isUnderline: true,
                      ),
                      TextEdit(
                        hintText: "Postcode",
                        controller: postCodeController,
                        isUnderline: true,
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
                        hintText: "State",
                        isUnderline: true,
                        onChange: onChangeState,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            isLoading
                ? Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.3),
                    ),
                    height: MediaQuery.of(context).size.height - 100,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Container(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.all(10),
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Button(
              color: Colors.black,
              bgColor: Colors.white,
              width: 80,
              shadow: false,
              label: "Cancel",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Row(
              children: [
                Button(
                  label: "Add another",
                  width: 100,
                  color: Colors.black,
                  bgColor: Colors.white,
                  shadow: false,
                  onPressed: () => onSaveAndNew(context),
                ),
                Button(
                  label: "Save",
                  width: 50,
                  onPressed: () => onSave(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void formatDependent() {
    nameController.text = "";
    passportController.text = "";
    ageController.text = "";
    addressController.text = userData["address"];
    postCodeController.text = userData["postcode"];
    dependentData.address = userData["address"];
    dependentData.postcode = userData["postcode"];
  }

  void onChangeRelation(String relation) {
    setState(() {
      dependentData.relation = relation;
    });
  }

  void onChangeGender(String gender) {
    setState(() {
      dependentData.gender = gender;
    });
  }

  void onChangeState(String state) {
    setState(() {
      dependentData.state = state;
    });
  }

  void onSave(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
        dependentData.user_id = FirebaseAuth.instance.currentUser!.uid;
        dependentData.name = nameController.value.text;
        dependentData.passport = passportController.value.text;
        dependentData.age = ageController.value.text;
      });
      CollectionReference<Map<String, dynamic>> dependentCollection =
          FirebaseFirestore.instance.collection("dependent");
      DocumentReference<Map<String, dynamic>> newDependent =
          await dependentCollection.add(dependentData.toJson());
      dependentData.id = newDependent.id;
      List<DependentData> dependents =
          Provider.of<DataProvider>(context, listen: false).getDependents;
      dependents.add(dependentData);
      Provider.of<DataProvider>(context, listen: false).setDependents =
          dependents;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
    Navigator.pop(context);
  }

  void onSaveAndNew(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
        dependentData.user_id = FirebaseAuth.instance.currentUser!.uid;
        dependentData.name = nameController.value.text;
        dependentData.passport = passportController.value.text;
        dependentData.age = ageController.value.text;
      });
      CollectionReference<Map<String, dynamic>> dependentCollection =
          FirebaseFirestore.instance.collection("dependent");
      DocumentReference<Map<String, dynamic>> newDependent =
          await dependentCollection.add(dependentData.toJson());
      dependentData.id = newDependent.id;
      List<DependentData> dependents =
          Provider.of<DataProvider>(context, listen: false).getDependents;
      dependents.add(dependentData);
      Provider.of<DataProvider>(context, listen: false).setDependents =
          dependents;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
    formatDependent();
  }
}
