import 'dart:io';
import 'package:flutter/material.dart';
import '../Https/network.dart';
import '../components/appbar.dart';
import 'package:image_picker/image_picker.dart';

class AddUserScreen extends StatefulWidget {
  AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  String? firstName;
  final firstNameController = TextEditingController();

  String? name;
  final nameController = TextEditingController();

  DateTime? birthday;
  final birthdayController = TextEditingController();

  String? adress;
  final adressController = TextEditingController();

  String? phone;
  final phoneController = TextEditingController();
  
  String? mail;
  final mailController = TextEditingController();

  String? gender;
  final genderController = TextEditingController();

  String? citation;
  final citationController = TextEditingController();

  String? picture;
  File? imageFile;

  String dateFormat(DateTime date) {
    if(date == null) {
      return "";
    }
    return date.year.toString() + "-" + date.month.toString().padLeft(2, "0") + "-" + date.day.toString().padLeft(2, "0");
  } 

  _showMsg(msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Code to execute.
          },
        ),
      ),
    );
  }


  /// Get from gallery
  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        picture = pickedFile.path;
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        picture = pickedFile.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      birthday = DateTime.parse("2000-01-01");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titlePage: "Ajoutez vous", context: context),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
              child: Form(
               key: _formKey,
               child: Column(
               children: [
                const Text(
                  'Enregistrez vous en quelques clics 😊',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Card(
                  child: imageFile == null
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          SizedBox(width: 10),
                          Text("Picture")
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              _getFromCamera();
                            },
                            icon: const Icon(Icons.camera_alt)
                          ),
                          IconButton(
                            onPressed: () {
                              _getFromGallery();
                            },
                            icon: const Icon(Icons.image)
                          )
                        ],
                      )
                    ]
                  )
                  : Container(
                    height: 200,
                    child: Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                    ),
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 170,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 2,
                          shadowColor: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: firstNameController,
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                              border:InputBorder.none,
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                            validator: (firstNameValue) {
                              if (firstNameValue!.isEmpty) {
                                return 'This field is required';
                              }
                              firstName = firstNameValue;
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),

                    Container(
                      width: 170,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 2,
                          shadowColor: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: nameController,
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                              border:InputBorder.none,
                              prefixIcon: Icon(Icons.perm_contact_calendar_outlined),
                            ),
                            validator: (nameValue) {
                              if (nameValue!.isEmpty) {
                                return 'This field is required';
                              }
                              name = nameValue;
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 170,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 2,
                          shadowColor: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                          child: TextFormField(
                            keyboardType: TextInputType.none,
                            controller: TextEditingController(text: dateFormat(birthday!)),
                            decoration: const InputDecoration(
                              labelText: 'Birth Date',
                              border:InputBorder.none,
                              prefixIcon: Icon(Icons.calendar_month_outlined),
                            ),
                            onTap: () async {
                              DateTime? dateTime = await showDatePicker(
                                context: context,
                                initialDate: DateTime.parse("2000-01-01"),
                                firstDate: DateTime.parse("1960-01-01"),
                                lastDate: DateTime.now()
                              );

                              if(mounted && dateTime != null) {
                                setState(() {
                                  birthday = dateTime;
                                });
                              }
                            },
                            validator: (birthdayValue) {
                              if (birthdayValue!.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),

                     Container(
                       width: 170,
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Material(
                           elevation: 2,
                           shadowColor: Colors.black,
                           borderRadius: BorderRadius.circular(5),
                           child: TextFormField(
                             keyboardType: TextInputType.streetAddress,
                             controller: adressController,
                             decoration: const InputDecoration(
                               labelText: 'Adress',
                               border: InputBorder.none,
                               prefixIcon: Icon(Icons.location_on),
                             ),
                             validator: (adressValue) {
                               if (adressValue!.isEmpty) {
                                 return 'This field is required';
                               }
                               adress = adressValue;
                               return null;
                             },
                           ),
                         ),
                       ),
                     ),
                  ],
                ),


                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 2,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: mailController,
                      decoration: const InputDecoration(
                        labelText: 'Email Adress',
                        border:InputBorder.none,
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (emailValue) {
                        if (emailValue!.isEmpty) {
                          return 'This field is required';
                        }
                        mail = emailValue;
                        return null;
                      },
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 2,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      decoration: const InputDecoration(
                          labelText: 'Telephone Number',
                          border:InputBorder.none,
                          prefixIcon: Icon(Icons.phone)),
                      validator: (phoneValue) {
                        if (phoneValue!.isEmpty) {
                          return 'This field is required';
                        }
                        phone = phoneValue;
                        return null;
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 2,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                    child: TextFormField(
                      controller: citationController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(8.0),
                          border:InputBorder.none,
                          icon:Icon(Icons.wb_incandescent_sharp),
                          hintText: 'Citation',
                      ),
                      validator: (citationValue) {
                        if (citationValue!.isEmpty) {
                          return 'This field is required';
                        }
                        citation = citationValue;
                        return null;
                      },
                      maxLines: 4,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: const [

                     Center(child: Text("Gender",
                         style:TextStyle(
                             fontFamily: "Raleway"
                         )))
                   ],
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Radio(
                         value: "male",
                         groupValue: gender,
                         onChanged: (String? value) {
                           if(value != null) {
                             setState(() {
                               gender = value;
                             });
                           }
                         }
                     ),
                     const Text("Male"),
                     const SizedBox(width: 10),
                     Radio(
                         value: "female",
                         groupValue: gender,
                         onChanged: (String? value) {
                           if(value != null) {
                             setState(() {
                               gender = value;
                             });
                           }
                         }
                     ),
                     const Text("Female"),
                   ],
                 ),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      _saveUser();
                    },
                    color: Colors.purpleAccent,
                    child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                      "Sauvegardé",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  _saveUser() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      var data = {
        'mail': mail,
        'firstname': firstName,
        'lastname': name,
        'phone': phone,
        'adress': adress,
        'gender': gender,
        'citation': citation,
        'birthday': dateFormat(birthday!),
        "picture": picture
      };

      HTTPNetwork.addUser(data).then((value) {
        if(value) {
          _showMsg("User registred successfully.");
          Navigator.of(context).pushReplacementNamed("list_user");
        } else {
          isLoading = false;
          _showMsg("User not registred.");
        }
      });

    } else {
      isLoading = false;
      _showMsg("Some field is missed.");
    }
  }
}