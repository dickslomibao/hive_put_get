import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_update_delete/view/widgets/spacer.dart';
import 'package:hive_update_delete/view/widgets/txt_field.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FocusNode> focus = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  TextEditingController usernameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final myBox = Hive.box('info');
  final _formKey = GlobalKey<FormState>();

  void add() {
    myBox.put('username', usernameController.text);
    myBox.put('firstname', firstnameController.text);
    myBox.put('lastname', lastnameController.text);
    myBox.put('address', addressController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.deepPurple,
        content: Text(
          'Successfully Saved',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
    for (var element in focus) {
      element.unfocus();
    }
    setState(() {});
  }

  dynamic validate({value, emptyLabelErr, type = ""}) {
    if (value.isEmpty) {
      return emptyLabelErr;
    }
    if (type == "username" && value.length <= 4) {
      return "Username must be 5 or more character";
    }
    return null;
  }

  void retrieve() {
    if (myBox.isNotEmpty) {
      usernameController.text = myBox.get('username');
      firstnameController.text = myBox.get('firstname');
      lastnameController.text = myBox.get('lastname');
      addressController.text = myBox.get('address');
    }
  }

  @override
  Widget build(BuildContext context) {
    retrieve();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive DB'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.save_outlined),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  add();
                }
              },
            ),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg1_image.png'),
            fit: BoxFit.cover,
            opacity: .03,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SvgPicture.asset(
                      'assets/images/bg_img1.svg',
                      width: 250,
                    ),
                    SpacerWidget(height: 30),
                    const Text(
                      'Your Personal Information',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromRGBO(0, 0, 0, .8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SpacerWidget(height: 40),
                    TxtFormFieldWidget(
                      focus: focus[0],
                      validator: (value) {
                        return validate(
                          value: value,
                          emptyLabelErr: 'Username is required',
                          type: 'username',
                        );
                      },
                      controller: usernameController,
                      label: 'Username:',
                    ),
                    SpacerWidget(height: 10),
                    TxtFormFieldWidget(
                      focus: focus[1],
                      validator: (value) {
                        return validate(
                            value: value,
                            emptyLabelErr: 'Firstname is required');
                      },
                      controller: firstnameController,
                      label: 'Firstname:',
                    ),
                    SpacerWidget(height: 10),
                    TxtFormFieldWidget(
                      focus: focus[2],
                      validator: (value) {
                        return validate(
                            value: value,
                            emptyLabelErr: 'Lastname is required');
                      },
                      controller: lastnameController,
                      label: 'Lastname:',
                    ),
                    SpacerWidget(height: 10),
                    TxtFormFieldWidget(
                      focus: focus[3],
                      validator: (value) {
                        return validate(
                            value: value, emptyLabelErr: 'Address is required');
                      },
                      controller: addressController,
                      label: 'Address:',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
